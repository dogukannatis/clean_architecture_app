
import 'dart:async';

import 'package:clean_architecture_app/domain/usecase/login_usecase.dart';
import 'package:clean_architecture_app/presentation/base/base_view_model.dart';
import 'package:flutter/material.dart';

import '../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs{

  final _usernameStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _isAllInputsValidStreamController = StreamController<void>.broadcast();

  var loginObject = LoginObject("","");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(LoginUseCaseInput(loginObject.username, loginObject.password))).fold(
            (failure) => { // Left - Failure
              debugPrint(failure.message)
            },
            (data) => { // Right - Data
              debugPrint(data.customer?.name)
            });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
    _validate();
  }

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  // Outputs

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUsernameValid => _usernameStreamController.stream.map((username) => _isUsernameValid(username));


  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // Private functions

  _validate(){
    inputIsAllInputsValid.add(null);
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username){
    return username.isNotEmpty;
  }

  bool _isAllInputsValid(){
    return _isPasswordValid(loginObject.password) &&  _isUsernameValid(loginObject.username);
  }


}

abstract class LoginViewModelInputs {
  // Three functions for actions
  setUsername(String username);
  setPassword(String password);
  login();

  // Two sinks for streams
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}