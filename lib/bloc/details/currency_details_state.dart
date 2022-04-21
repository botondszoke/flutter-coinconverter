part of 'currency_details_bloc.dart';

abstract class CurrencyDetailsState {
  const CurrencyDetailsState();
}

class Loading extends CurrencyDetailsState {
  static final Loading _instance = Loading._();

  factory Loading() => _instance;

  Loading._();
}

class Loaded extends CurrencyDetailsState with EquatableMixin {
  final CoinCurrencyItem currency;
  final List<PresentCurrency> rates;

  Loaded({required this.currency, required this.rates});

  @override
  List<Object> get props => [currency];
}

class Error extends CurrencyDetailsState {
  static final Error _instance = Error._();

  factory Error() => _instance;

  Error._();
}
