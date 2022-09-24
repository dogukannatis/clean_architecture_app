
import 'package:clean_architecture_app/domain/model.dart';
import 'package:dartz/dartz.dart';

import '../data/network/failure.dart';
import '../data/request/request.dart';

abstract class Repository {
  // It can be return two possible result, so we use "Either".
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}