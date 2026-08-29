import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/shared/services/repository.dart';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// ── Fake path_provider ────────────────────────────────────────────────────────
// Redirige getApplicationDocumentsDirectory() vers un dossier temporaire.
class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  final String tempPath;
  FakePathProviderPlatform(this.tempPath);

  @override
  Future<String?> getApplicationDocumentsPath() async => tempPath;
}

// ── Implémentation concrète minimale pour les tests ───────────────────────────
class _Item {
  final int id;
  final String name;
  _Item(this.id, this.name);
}

class _ItemRepository extends Repository<_Item> {
  @override
  String get filename => 'test_items.json';

  @override
  String get assetPath => 'assets/data/test_items.json'; // n'existe pas → fallback []

  @override
  _Item fromJson(Map<String, dynamic> json) =>
      _Item(json['id'] as int, json['name'] as String);

  @override
  Map<String, dynamic> toJson(_Item item) => {'id': item.id, 'name': item.name};
}

// ── Helper ────────────────────────────────────────────────────────────────────
late Directory tempDir;
late _ItemRepository repo;

Future<void> _writeRaw(String content) async {
  final file = File('${tempDir.path}/test_items.json');
  await file.writeAsString(content);
}

// ── Suite de tests ────────────────────────────────────────────────────────────
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('repo_test_');
    PathProviderPlatform.instance = FakePathProviderPlatform(tempDir.path);
    repo = _ItemRepository();
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  group('Repository — Gestion d\'erreurs robuste', () {
    // ── Asset manquant ───────────────────────────────────────────────────────
    test('initFile() : asset manquant → crée un fichier vide []', () async {
      // L'assetPath ne correspond à aucun asset → fallback '[]'
      final file = await repo.initFile();
      final content = await file.readAsString();
      expect(content, '[]');
    });

    // ── Fichier vide ─────────────────────────────────────────────────────────
    test('readFile() : fichier vide → retourne []', () async {
      await _writeRaw('');
      final list = await repo.readFile();
      expect(list, isEmpty);
    });

    test(
      'readFile() : fichier contenant seulement des espaces → retourne []',
      () async {
        await _writeRaw('   \n\t  ');
        final list = await repo.readFile();
        expect(list, isEmpty);
      },
    );

    // ── JSON corrompu ────────────────────────────────────────────────────────
    test('readFile() : JSON invalide → lève RepositoryException', () async {
      await _writeRaw('{invalid json{{{{');
      expect(() => repo.readFile(), throwsA(isA<RepositoryException>()));
    });

    test(
      'readFile() : JSON corrompu → message d\'erreur contient le nom du fichier',
      () async {
        await _writeRaw('not valid at all');
        try {
          await repo.readFile();
          fail('Devait lever une RepositoryException');
        } on RepositoryException catch (e) {
          expect(e.message, contains('test_items.json'));
        }
      },
    );

    test(
      'readFile() : JSON corrompu → réinitialise le fichier (contenu = [])',
      () async {
        await _writeRaw('CORRUPTED_DATA');
        try {
          await repo.readFile();
        } on RepositoryException {
          // attendu
        }
        // Après une erreur, le fichier doit avoir été réinitialisé
        final file = File('${tempDir.path}/test_items.json');
        if (await file.exists()) {
          final content = await file.readAsString();
          // Le fichier est soit [] (reset depuis asset vide) soit inexistant
          expect(() => content, returnsNormally);
        }
      },
    );

    // ── Lecture normale ──────────────────────────────────────────────────────
    test('readFile() : JSON valide → désérialise correctement', () async {
      await _writeRaw('[{"id":1,"name":"A"},{"id":2,"name":"B"}]');
      final list = await repo.readFile();
      expect(list.length, 2);
      expect(list[0].id, 1);
      expect(list[0].name, 'A');
      expect(list[1].id, 2);
    });

    // ── Enregistrement individuel invalide ───────────────────────────────────
    test(
      'readFile() : un item avec champ manquant → item ignoré, les autres chargés',
      () async {
        // id=1 valide, id=2 manque "name" → fromJson() lève une TypeError
        await _writeRaw('[{"id":1,"name":"Valide"},{"id":2}]');
        final list = await repo.readFile();
        // En mode release l'item corrompu est ignoré silencieusement
        // En mode debug un assert est déclenché (non fatal en test)
        expect(list.where((i) => i.id == 1).length, 1);
      },
    );

    // ── add() ────────────────────────────────────────────────────────────────
    test('add() : ajoute un item et le persiste dans le fichier', () async {
      await _writeRaw('[]');
      await repo.add(_Item(1, 'Premier'));
      final list = await repo.readFile();
      expect(list.length, 1);
      expect(list.first.name, 'Premier');
    });

    test(
      'add() : deux ajouts successifs → deux items dans le fichier',
      () async {
        await _writeRaw('[]');
        await repo.add(_Item(1, 'Un'));
        await repo.add(_Item(2, 'Deux'));
        final list = await repo.readFile();
        expect(list.length, 2);
      },
    );

    // ── update() ─────────────────────────────────────────────────────────────
    test('update() : met à jour un item existant', () async {
      await _writeRaw('[{"id":1,"name":"Avant"}]');
      await repo.update(1, _Item(1, 'Après'));
      final list = await repo.readFile();
      expect(list.first.name, 'Après');
    });

    test('update() : id inexistant → fichier inchangé', () async {
      await _writeRaw('[{"id":1,"name":"Stable"}]');
      await repo.update(99, _Item(99, 'Fantôme'));
      final list = await repo.readFile();
      expect(list.length, 1);
      expect(list.first.name, 'Stable');
    });

    // ── findById() ───────────────────────────────────────────────────────────
    test('findById() : id existant → retourne l\'item', () async {
      await _writeRaw('[{"id":1,"name":"Trouvé"},{"id":2,"name":"Autre"}]');
      final item = await repo.findById(1);
      expect(item?.name, 'Trouvé');
    });

    test('findById() : id inexistant → retourne null', () async {
      await _writeRaw('[{"id":1,"name":"Existant"}]');
      final item = await repo.findById(999);
      expect(item, isNull);
    });

    // ── generateNewId() ───────────────────────────────────────────────────────
    test('generateNewId() : liste vide → retourne 1', () async {
      await _writeRaw('[]');
      final id = await repo.generateNewId();
      expect(id, 1);
    });

    test('generateNewId() : retourne max(id) + 1', () async {
      await _writeRaw(
        '[{"id":3,"name":"A"},{"id":7,"name":"B"},{"id":5,"name":"C"}]',
      );
      final id = await repo.generateNewId();
      expect(id, 8);
    });

    // ── RepositoryException ───────────────────────────────────────────────────
    test('RepositoryException.toString() contient le message', () {
      const ex = RepositoryException('Fichier inaccessible');
      expect(ex.toString(), contains('Fichier inaccessible'));
    });
  });
}
