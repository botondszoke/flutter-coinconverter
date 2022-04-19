import 'cc_json_models.dart';

abstract class CCApi {
  Future<CCAssetsResponse?> getCCAssets();
  Future<CCRatesResponse?> getCCRates();
}