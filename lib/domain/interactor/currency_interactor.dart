import 'package:coin_converter/domain/model/list_model.dart';

import '../../dio/cc_network_data_source.dart';

class CurrencyInteractor {
  final CCNetworkDataSource _currencyNetworkDataSource;

  CurrencyInteractor(this._currencyNetworkDataSource);

  Future<List<CoinCurrencyItem>> getCurrencies() async {
    return await _currencyNetworkDataSource.getCurrencies() ?? [];
  }


}