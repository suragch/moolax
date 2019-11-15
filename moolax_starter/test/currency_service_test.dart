import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moolax/services/currency/currency_service_implementation.dart';
import 'package:moolax/services/storage/storage_service.dart';
import 'package:moolax/services/web_api/web_api.dart';
import 'package:moolax/services/service_locator.dart';


// These tests demonstrate how you can mock a service during testing.

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

}