class WrongCredentials implements Exception {
  final String message = 'Wrong credentials';
}

class InvalidToken implements Exception {
  final String message = 'Invalid token';
}
class UserNotFound implements Exception {
  final String message = 'User not found';
}
class ConnectionTimeout implements Exception {
  final String message = 'Connection timeout';
}

class ConnectionError implements Exception {
  final String message = 'Connection error';
}
class CustomError implements Exception {
  final int errorCode;
  final String message;
  CustomError({required this.message, required this.errorCode});
}

