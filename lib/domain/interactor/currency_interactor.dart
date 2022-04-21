import 'package:coin_converter/domain/model/list_model.dart';

import '../../dio/cc_network_data_source.dart';

class CurrencyInteractor {
  final CCNetworkDataSource _currencyNetworkDataSource;

  CurrencyInteractor(this._currencyNetworkDataSource);

  Future<List<CoinCurrencyItem>> getCurrencies(String searchParam) async {
    return await _currencyNetworkDataSource.getCurrencies(searchParam);
  }

  Future<CoinCurrencyItem> getCurrencyById(String id) async {
    return await _currencyNetworkDataSource.getCurrencyById(id);
  }

  Future<List<PresentCurrency>> getRates() async {
    return await _currencyNetworkDataSource.getRates();
  }

}