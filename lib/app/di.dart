import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mina_farid/app/app_prefs.dart';
import 'package:mina_farid/data/data_source/remote_data.dart';
import 'package:mina_farid/data/network/app_api.dart';
import 'package:mina_farid/data/network/dio_factory.dart';
import 'package:mina_farid/data/network/network_info.dart';
import 'package:mina_farid/data/repository_implement/repository_impl.dart';
import 'package:mina_farid/domain/repository/repository.dart';
import 'package:mina_farid/domain/use_cases/forgot_usecace.dart';
import 'package:mina_farid/domain/use_cases/login_usecase.dart';
import 'package:mina_farid/presentation/screens/forget_password/view_model/forgot_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/screens/login/view_model/login_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //shared prefs
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //app_prefs
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // remote_data
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app_api
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // network_info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnection()));

  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}
