import 'package:coin_converter/dio/cc_json_models.dart';
import 'package:coin_converter/domain/model/list_model.dart';

import 'cc_api.dart';

class CCNetworkDataSource {
  final CCApi _ccApi;

  CCNetworkDataSource(this._ccApi);

  Future<List<CoinCurrencyItem>> getCurrencies(String searchParam) async {
    try {
      var response = await _ccApi.getCCAssets(searchParam);
      if (response == null) throw Exception("Unexpected error occurred while loading network data.");
      var domainResponse = response.toDomainModel();
      domainResponse.sort((a, b) => a.name.compareTo(b.name));
      return domainResponse;
    }
    on Exception catch (e) {
      throw Exception("Unexpected error occurred while loading network data. ${e.toString()}");
    }
  }

  Future<CoinCurrencyItem> getCurrencyById(String id) async {
    try {
      final response = await _ccApi.getCCAssetsById(id);
      if (response == null) throw Exception("Unexpected error occurred while loading network data.");
      return response.toDomainModel();
    } on Exception catch (e) {
      throw Exception("Unexpected error occured while loading network data. ${e.toString()}");
    }
  }

  Future<List<PresentCurrency>> getRates() async {
    try {
      final response = await _ccApi.getCCRates();
      if (response == null) throw Exception("Unexpected error occurred while loading network data.");
      var domainResponse = response.toDomainModel();
      domainResponse.sort((a, b) => a.symbol.compareTo(b.symbol));
      return domainResponse;
    }
    on Exception catch (e) {
      throw Exception("Unexpected error occurred while loading network data. ${e.toString()}");
    }
  }
}

extension on CCAssetsResponse {
  List<CoinCurrencyItem> toDomainModel() {
    return this.data.map((e) => CoinCurrencyItem(
      e.id,
      num.parse(e.rank),
      e.symbol,
      e.name,
      num.parse(e.supply),
      e.maxSupply == null ? null : num.parse(e.maxSupply.toString()),
      num.parse(e.marketCapUsd),
      num.parse(e.volumeUsd24Hr),
      num.parse(e.priceUsd),
      num.parse(e.changePercent24Hr),
      e.vwap24Hr == null ? null : num.parse(e.vwap24Hr.toString()),
      e.explorer
    )
    ).toList();
  }
}

extension on CCAssetResponse {
  CoinCurrencyItem toDomainModel() {
    return CoinCurrencyItem(
        data.id,
        num.parse(data.rank),
        data.symbol,
        data.name,
        num.parse(data.supply),
        data.maxSupply == null ? null : num.parse(data.maxSupply.toString()),
        num.parse(data.marketCapUsd),
        num.parse(data.volumeUsd24Hr),
        num.parse(data.priceUsd),
        num.parse(data.changePercent24Hr),
        data.vwap24Hr == null ? null : num.parse(data.vwap24Hr.toString()),
        data.explorer
    );
  }
}

extension on CCRatesResponse {
  List<PresentCurrency> toDomainModel() {
    return this.data.map(
      (e) => PresentCurrency(
      e.symbol,
      e.currencySymbol,
      num.parse(e.rateUsd))
    ).toList();
  }
}