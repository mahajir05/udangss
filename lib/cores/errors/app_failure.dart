import 'package:equatable/equatable.dart';

abstract class AppFailure extends Equatable {
  final int? code;
  final dynamic messages;
  final Map<String, dynamic>? errors;
  const AppFailure({
    this.code,
    this.messages,
    this.errors,
  });

  @override
  List<Object?> get props => [code, messages, errors];
}

class ClientFailure extends AppFailure {
  const ClientFailure({
    super.code,
    String? super.messages,
    super.errors,
  });
}

class ServerFailure extends AppFailure {
  const ServerFailure() : super();
}

class UnknownFailure extends AppFailure {}

class OfflineFailure extends AppFailure {}

class RequestCancelledFailure extends AppFailure {}

class SessionFailure extends AppFailure {}

//
class MobileValidationFailure extends AppFailure {
  const MobileValidationFailure({
    super.errors,
  });
}
