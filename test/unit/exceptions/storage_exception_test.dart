import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/exceptions/storage_exception.dart';

void main() {
  group('StorageException Tests', () {
    test('StorageException displays message', () {
      const exception = StorageException('Fichier non trouvé');
      expect(exception.message, equals('Fichier non trouvé'));
      expect(exception.toString(), contains('Fichier non trouvé'));
    });

    test('StorageException includes cause in toString when provided', () {
      const exception = StorageException('Erreur I/O', 'Permission denied');
      expect(exception.cause, equals('Permission denied'));
      expect(exception.toString(), contains('Cause: Permission denied'));
    });
  });
}
