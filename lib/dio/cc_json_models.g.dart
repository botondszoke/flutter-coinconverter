// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cc_json_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CCAssetsResponse _$CCAssetsResponseFromJson(Map<String, dynamic> json) =>
    CCAssetsResponse(
      (json['data'] as List<dynamic>)
          .map((e) => CCAssetsInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['timestamp'] as int,
    );

Map<String, dynamic> _$CCAssetsResponseToJson(CCAssetsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'timestamp': instance.timestamp,
    };

CCAssetsInformation _$CCAssetsInformationFromJson(Map<String, dynamic> json) =>
    CCAssetsInformation(
      json['id'] as String,
      json['rank'] as String,
      json['symbol'] as String,
      json['name'] as String,
      json['supply'] as String,
      json['maxSupply'] as String?,
      json['marketCapUsd'] as String,
      json['volumeUsd24Hr'] as String,
      json['priceUsd'] as String,
      json['changePercent24Hr'] as String,
      json['vwap24Hr'] as String,
      json['explorer'] as String,
    );

Map<String, dynamic> _$CCAssetsInformationToJson(
        CCAssetsInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rank': instance.rank,
      'symbol': instance.symbol,
      'name': instance.name,
      'supply': instance.supply,
      'maxSupply': instance.maxSupply,
      'marketCapUsd': instance.marketCapUsd,
      'volumeUsd24Hr': instance.volumeUsd24Hr,
      'priceUsd': instance.priceUsd,
      'changePercent24Hr': instance.changePercent24Hr,
      'vwap24Hr': instance.vwap24Hr,
      'explorer': instance.explorer,
    };

CCRatesResponse _$CCRatesResponseFromJson(Map<String, dynamic> json) =>
    CCRatesResponse(
      (json['data'] as List<dynamic>)
          .map((e) => CCRatesInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['timestamp'] as int,
    );

Map<String, dynamic> _$CCRatesResponseToJson(CCRatesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'timestamp': instance.timestamp,
    };

CCRatesInformation _$CCRatesInformationFromJson(Map<String, dynamic> json) =>
    CCRatesInformation(
      json['id'] as String,
      json['symbol'] as String,
      json['currencySymbol'] as String?,
      json['type'] as String,
      json['rateUsd'] as String,
    );

Map<String, dynamic> _$CCRatesInformationToJson(CCRatesInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'currencySymbol': instance.currencySymbol,
      'type': instance.type,
      'rateUsd': instance.rateUsd,
    };
