
import 'package:clean_architecture_app/app/app_prefs.dart';
import 'package:clean_architecture_app/data/data_source/remote_data_source.dart';
import 'package:clean_architecture_app/data/network/app_api.dart';
import 'package:clean_architecture_app/data/network/dio_factory.dart';
import 'package:clean_architecture_app/data/network/network_info.dart';
import 'package:clean_architecture_app/data/repository/repository_impl.dart';
import 'package:clean_architecture_app/domain/repository.dart';
import 'package:clean_architecture_app/domain/usecase/login_usecase.dart';
import 'package:clean_architecture_app/presentation/login/login_viewmodel.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

/// Dependency Injection
Future<void> initAppModule() async {

  final sharedPrefs = await SharedPreferences.getInstance();

  // Shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // App prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // Network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));

  // Dio
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // App service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // Remote Data Source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance()));

  // Repository
  instance.registerLazySingleton<Repository>(() => RepositoryImp(instance(), instance()));

}

initLoginModule(){
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}