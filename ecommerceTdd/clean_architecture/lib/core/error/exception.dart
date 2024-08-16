class ServerException implements Exception {
  
  
}

class CacheException implements Exception {}

class SocketException implements Exception {
 
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}
