import 'package:dartz/dartz.dart';
import 'package:mina_farid/data/network/failure.dart';

abstract class BaseUseCass<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
