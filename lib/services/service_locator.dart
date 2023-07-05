/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'package:get_it/get_it.dart';
import 'package:moolax/pages/favorites/choose_favorites_viewmodel.dart';
import 'package:moolax/pages/home/calculate_screen_manager.dart';
import 'currency_service.dart';

import 'storage_service.dart';
import 'web_api.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // services
  getIt.registerLazySingleton<WebApi>(() => WebApiImpl());
  getIt.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  getIt.registerLazySingleton<CurrencyService>(() => CurrencyServiceImpl());

  getIt.registerFactory<CalculateScreenManager>(() => CalculateScreenManager());
  getIt.registerFactory<ChooseFavoritesManager>(() => ChooseFavoritesManager());
}
