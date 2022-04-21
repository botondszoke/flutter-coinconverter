part of 'currency_details_bloc.dart';

@immutable
abstract class CurrencyDetailsEvent {
  const CurrencyDetailsEvent();
}

class LoadCurrencyEvent extends CurrencyDetailsEvent {
  final String id;

  LoadCurrencyEvent(this.id);
}

class ChangedCurrencyEvent extends CurrencyDetailsEvent {
  final CoinCurrencyItem currency;
  final List<PresentCurrency> rates;

  ChangedCurrencyEvent(this.currency, this.rates);
}
