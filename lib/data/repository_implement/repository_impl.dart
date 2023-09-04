import 'package:dartz/dartz.dart';
import 'package:mina_farid/data/mapper/mapper.dart';

import 'package:mina_farid/data/network/failure.dart';
import 'package:mina_farid/data/network/network_info.dart';

import 'package:mina_farid/data/network/requests.dart';

import 'package:mina_farid/domain/model/model.dart';

import '../../domain/repository/repository.dart';
import '../data_source/remote_data.dart';
import '../network/error_handler.dart';

class RepositoryImpl extends Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) async {
    // check for network
    if (await _networkInfo.isConnected) {
      try {
        //add request to get data
        final response = await _remoteDataSource.login(loginRequest);
        // data success
        if (response.status == 0) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
