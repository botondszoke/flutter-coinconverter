import 'cc_json_models.dart';

abstract class CCApi {
  Future<CCAssetsResponse?> getCCAssets(String searchParam);
  Future<CCAssetResponse?> getCCAssetsById(String id);
  Future<CCRatesResponse?> getCCRates();
}