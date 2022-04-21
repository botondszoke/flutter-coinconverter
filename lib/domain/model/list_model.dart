import 'package:equatable/equatable.dart';

class CoinCurrencyItem extends Equatable {
  final String id;
  final num rank;
  final String symbol;
  final String name;
  final num supply;
  final num? maxSupply;
  final num marketCapUsd;
  final num volumeUsd24Hr;
  final num priceUsd;
  final num changePercent24Hr;
  final num? vwap24Hr;
  final String? explorer;

  PresentCurrency presentedCurrency;

  CoinCurrencyItem(this.id, this.rank, this.symbol, this.name, this.supply, this.maxSupply, this.marketCapUsd, this.volumeUsd24Hr, this.priceUsd, this.changePercent24Hr, this.vwap24Hr, this.explorer): presentedCurrency = PresentCurrency("USD", "\$", 1);

  void setPresentedCurrency(PresentCurrency p) {
    presentedCurrency = p;
  }

  num getPresentedPrice() {
    num presentedPrice = priceUsd / presentedCurrency.rateUsd;
    presentedPrice = num.parse(presentedPrice.toStringAsFixed(4));
    return presentedPrice;
  }

  num getPresentedVolume() {
    num presentedVolume = volumeUsd24Hr / presentedCurrency.rateUsd;
    presentedVolume = num.parse(presentedVolume.toStringAsFixed(4));
    return presentedVolume;
  }

  num getPresentedMarketCap() {
    num presentedCap = marketCapUsd / presentedCurrency.rateUsd;
    presentedCap = num.parse(presentedCap.toStringAsFixed(4));
    return presentedCap;
  }

  num? getPresentedVWAP() {
    if (vwap24Hr == null) return null;
    num presentedVWAP = num.parse(vwap24Hr.toString()) / presentedCurrency.rateUsd;
    presentedVWAP = num.parse(presentedVWAP.toStringAsFixed(4));
    return presentedVWAP;
  }

  num getPresentedChangePercent() {
    return num.parse(changePercent24Hr.toStringAsFixed(4));
  }

  num getPresentedSupply() {
    return num.parse(supply.toStringAsFixed(4));
  }

  num? getPresentedMaxSupply() {
    if (maxSupply == null) return null;
    return num.parse(num.parse(maxSupply.toString()).toStringAsFixed(4));
  }

  @override
  List<Object?> get props => [id, rank, symbol, supply, maxSupply, marketCapUsd, volumeUsd24Hr, priceUsd, changePercent24Hr, vwap24Hr, explorer];
}

class PresentCurrency extends Equatable {
  final String symbol;
  final String? currencySymbol;
  final num rateUsd;

  PresentCurrency(this.symbol, this.currencySymbol, this.rateUsd);

  @override
  List<Object?> get props => [symbol, currencySymbol, rateUsd];
}