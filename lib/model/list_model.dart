class CoinCurrencyItem {
  final String id;
  final num rank;
  final String symbol;
  final num supply;
  final num? maxSupply;
  final num marketCapUsd;
  final num volumeUsd24Hr;
  final num priceUsd;
  final num changePercent24Hr;
  final num vwap24Hr;
  final String explorer;

  PresentCurrency presentedCurrency;

  CoinCurrencyItem(this.id, this.rank, this.symbol, this.supply, this.maxSupply, this.marketCapUsd, this.volumeUsd24Hr, this.priceUsd, this.changePercent24Hr, this.vwap24Hr, this.explorer): presentedCurrency = PresentCurrency("USD", "\$", 1);

  num getPresentedPrice() {
    return priceUsd / presentedCurrency.rateUsd;
  }
}

class PresentCurrency {
  String symbol;
  String? currencySymbol;
  num rateUsd;

  PresentCurrency(this.symbol, this.currencySymbol, this.rateUsd);
}