// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'package:get_it/get_it.dart';
import 'package:moolax/pages/favorites/choose_favorites_manager.dart';
import 'package:moolax/pages/home/calculate_screen_manager.dart';
// import 'package:moolax/services/iap_service.dart';
import 'currency_service.dart';

import 'storage_service.dart';
import 'web_api.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // services
  getIt.registerLazySingleton<WebApi>(() => WebApi());
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  getIt.registerLazySingleton<CurrencyService>(() => CurrencyService());

  getIt.registerFactory<CalculateScreenManager>(() => CalculateScreenManager());
  getIt.registerFactory<ChooseFavoritesManager>(() => ChooseFavoritesManager());
}
