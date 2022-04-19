import 'package:json_annotation/json_annotation.dart';

part 'cc_json_models.g.dart';

@JsonSerializable()
class CCAssetsResponse {
  final List<CCAssetsInformation> data;
  final int timestamp;

  CCAssetsResponse(this.data, this.timestamp);

  factory CCAssetsResponse.fromJson(Map<String, dynamic> json) => _$CCAssetsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CCAssetsResponseToJson(this);
}

@JsonSerializable()
class CCAssetsInformation {
  final String id;
  final String rank;
  final String symbol;
  final String name;
  final String supply;
  final String? maxSupply;
  final String marketCapUsd;
  final String volumeUsd24Hr;
  final String priceUsd;
  final String changePercent24Hr;
  final String? vwap24Hr;
  final String? explorer;

  CCAssetsInformation(this.id, this.rank, this.symbol, this.name, this.supply, this.maxSupply, this.marketCapUsd, this.volumeUsd24Hr, this.priceUsd, this.changePercent24Hr, this.vwap24Hr, this.explorer);

  factory CCAssetsInformation.fromJson(Map<String, dynamic> json) => _$CCAssetsInformationFromJson(json);
  Map<String, dynamic> toJson() => _$CCAssetsInformationToJson(this);
}

@JsonSerializable()
class CCRatesResponse {
  final List<CCRatesInformation> data;
  final int timestamp;

  CCRatesResponse(this.data, this.timestamp);

  factory CCRatesResponse.fromJson(Map<String, dynamic> json) => _$CCRatesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CCRatesResponseToJson(this);
}

@JsonSerializable()
class CCRatesInformation {
  final String id;
  final String symbol;
  final String? currencySymbol;
  final String type;
  final String rateUsd;

  CCRatesInformation(this.id, this.symbol, this.currencySymbol, this.type, this.rateUsd);

  factory CCRatesInformation.fromJson(Map<String, dynamic> json) => _$CCRatesInformationFromJson(json);
  Map<String, dynamic> toJson() => _$CCRatesInformationToJson(this);
}