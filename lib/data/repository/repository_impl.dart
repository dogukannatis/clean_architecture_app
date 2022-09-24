
import 'package:clean_architecture_app/data/mapper/mapper.dart';
import 'package:clean_architecture_app/data/network/error_handler.dart';
import 'package:clean_architecture_app/data/network/failure.dart';
import 'package:clean_architecture_app/data/request/request.dart';
import 'package:clean_architecture_app/domain/model.dart';
import 'package:clean_architecture_app/domain/repository.dart';
import 'package:dartz/dartz.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImp extends Repository {

  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImp(this._remoteDataSource,this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected){
      try{
        // It safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if(response.status == ApiInternalStatus.success){ // success
          return Right(response.toDomain());
        }else{ // return error
          return Left(Failure(response.status ?? ApiInternalStatus.failure, response.message ?? ResponseMessage.defaultError));
        }

      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
      
    }else{
      return Left(DataSource.noInternetConnection.getFailure());

    }
  }

}