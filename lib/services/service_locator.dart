import 'package:get_it/get_it.dart';
import '../api/api_client.dart';
import 'api_service.dart';
import 'auth_service.dart';
import 'cache_manager.dart';
import 'cookie_manager.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton(() => CookieManager());

  getIt.registerLazySingleton(() => CacheManager());

  getIt.registerLazySingleton(() => ApiClient(() => getIt<CookieManager>().getCookie(),getIt<CacheManager>()));

  getIt.registerLazySingleton(() => AuthService(getIt<ApiClient>(), getIt<CookieManager>()));

  getIt.registerLazySingleton(() => ApiService(getIt<ApiClient>()));
}