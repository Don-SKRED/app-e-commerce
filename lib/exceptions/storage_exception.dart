/// Exception personnalisée levée lors des erreurs d'accès,
/// de lecture ou d'écriture du stockage local (fichiers JSON, etc.).
class StorageException implements Exception {
  final String message;
  final dynamic cause;

  const StorageException(this.message, [this.cause]);

  @override
  String toString() =>
      'StorageException: $message${cause != null ? ' (Cause: $cause)' : ''}';
}
