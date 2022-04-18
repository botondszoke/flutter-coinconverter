import 'package:coin_converter/dio/cc_json_models.dart';
import 'package:coin_converter/dio/cc_service.dart';
import 'package:coin_converter/model/list_model.dart';

class ListRepository {
  var ccService = CCService();

  Future<List<CoinCurrencyItem>> getCurrencyList() async {
    var response = await ccService.getCCAssets();
    return response.data.map(
        (e) => CoinCurrencyItem(
            e.id,
            num.parse(e.rank),
            e.symbol,
            num.parse(e.supply),
            e.maxSupply == null ? null : num.parse(e.maxSupply.toString()),
            num.parse(e.marketCapUsd),
            num.parse(e.volumeUsd24Hr),
            num.parse(e.priceUsd),
            num.parse(e.changePercent24Hr),
            num.parse(e.vwap24Hr), e.explorer)
    ).toList();
  }

  Future<List<PresentCurrency>> getRateList() async {
    var response = await ccService.getCCRates();
    return response.data.map(
        (e) => PresentCurrency(
            e.symbol,
            e.currencySymbol,
            num.parse(e.rateUsd))
    ).toList();
  }
}