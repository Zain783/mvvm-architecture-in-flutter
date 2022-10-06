class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error during communication');
}

class BadDataException extends AppException {
  BadDataException([String? message]) : super(message, 'Invalid Request');
}

class UnauthorisedDataException extends AppException {
  UnauthorisedDataException([String? message])
      : super(message, 'Unauthorised Request');
}

class InvalidDataException extends AppException {
  InvalidDataException([String? message]) : super(message, 'invalid Request');
}
