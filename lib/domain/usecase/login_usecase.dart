
import 'package:clean_architecture_app/data/network/failure.dart';
import 'package:clean_architecture_app/data/request/request.dart';
import 'package:clean_architecture_app/domain/model.dart';
import 'package:clean_architecture_app/domain/repository.dart';
import 'package:clean_architecture_app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../app/functions.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {

  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {

    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(input.email, input.password, deviceInfo.identifier, deviceInfo.name));
  }

}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email,this.password);
}