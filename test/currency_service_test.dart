import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moolax/business_logic/services/currency/currency_service.dart';
import 'package:moolax/business_logic/services/currency/currency_service_implementation.dart';
import 'package:moolax/business_logic/services/storage/storage_service.dart';
import 'package:moolax/business_logic/services/web_api/web_api.dart';
import 'package:moolax/service_locator.dart';

class MockStorageService extends Mock implements StorageService {}

class MockWebApi extends Mock implements WebApi {}

void main() {

  setUpAll(() {
    setupServiceLocator();
    serviceLocator.allowReassignment = true;
  });

  test('Constructing Service should find correct dependencies', () {
    var currencyService = CurrencyServiceImpl();
    expect(currencyService != null, true);
  });

  test(
    'should return the default when the storage service returns null',
    () async {
      // arrange
      var mockStorageService = MockStorageService();
      when(mockStorageService.getFavoriteCurrencies()).thenAnswer((_) => Future.value(null));
      serviceLocator.registerSingleton<StorageService>(mockStorageService);

      // act
      final currencyService = CurrencyServiceImpl();
      final favorites = await currencyService.getFavoriteCurrencies();

      // assert
      expect(favorites, CurrencyServiceImpl.defaultFavorites);
    },
  );

  test(
    'should return the default when the storage service is an empty list',
        () async {
      // arrange
      var mockStorageService = MockStorageService();
      when(mockStorageService.getFavoriteCurrencies()).thenAnswer((_) => Future.value([]));
      serviceLocator.registerSingleton<StorageService>(mockStorageService);

      // act
      final currencyService = CurrencyServiceImpl();
      final favorites = await currencyService.getFavoriteCurrencies();

      // assert
      expect(favorites, CurrencyServiceImpl.defaultFavorites);
    },
  );

//  test(
//    'should return all exchange rates when network is connected and cache expired',
//        () async {
//      // arrange
//      var mockStorageService = MockStorageService();
//      when(mockStorageService.getFavoriteCurrencies()).thenAnswer((_) => Future.value([]));
//      serviceLocator.registerSingleton<StorageService>(mockStorageService);
//
////      var mockWebApi = MockWebApi();
////      when(mockWebApi.getExchangeRateData()).thenAnswer((_) => Future.value(null));
////      serviceLocator.registerSingleton<WebApi>(mockWebApi);
//
//      // act
//      final currencyService = CurrencyServiceImpl();
//      final favorites = await currencyService.getAllExchangeRates();
//
//      // assert
//      expect(favorites, CurrencyServiceImpl.defaultFavorites);
//    },
//  );
}