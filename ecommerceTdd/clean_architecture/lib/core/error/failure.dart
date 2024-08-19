
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [];
}


class ServerFailure extends Failure{
  const ServerFailure(super.message);
  
}

class SocketFailure extends Failure{
  const SocketFailure(super.message);
  
}

class ConnectionFailure extends Failure{
  const ConnectionFailure(super.message);
  
}

class DatabaseFailure extends Failure{
  const DatabaseFailure(super.message);
  
}


class CacheFailure extends Failure{
  const CacheFailure(super.message);


}

class NotFoundFailure extends Failure{
  const NotFoundFailure(super.message);
  
}