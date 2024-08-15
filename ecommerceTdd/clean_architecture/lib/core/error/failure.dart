
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [];
}


class ServerFailure extends Failure{
  const ServerFailure(String message): super(message);
  
}

class SocketFailure extends Failure{
  const SocketFailure(String message): super(message);
  
}

class ConnectionFailure extends Failure{
  const ConnectionFailure(String message): super(message);
  
}

class DatabaseFailure extends Failure{
  const DatabaseFailure(String message): super(message);
  
}


class CacheFailure extends Failure{
  CacheFailure(super.message);


}