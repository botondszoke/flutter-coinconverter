part of 'currency_list_bloc.dart';

@immutable
abstract class CurrencyListEvent {
  const CurrencyListEvent();
}

class LoadCurrenciesEvent extends CurrencyListEvent {
  final String searchParam;

  LoadCurrenciesEvent(this.searchParam);
}
