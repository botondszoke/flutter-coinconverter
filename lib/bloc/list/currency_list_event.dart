part of 'currency_list_bloc.dart';

@immutable
abstract class CurrencyListEvent {
  const CurrencyListEvent();
}

class LoadCurrenciesEvent extends CurrencyListEvent {
  static final LoadCurrenciesEvent _instance = LoadCurrenciesEvent._();

  factory LoadCurrenciesEvent() => _instance;

  LoadCurrenciesEvent._();
}

/*class RefreshCurrenciesEvent extends CurrencyListEvent {
  static final RefreshCurrenciesEvent _instance = RefreshCurrenciesEvent._();

  factory RefreshCurrenciesEvent() => _instance;

  RefreshCurrenciesEvent._();
}*/
