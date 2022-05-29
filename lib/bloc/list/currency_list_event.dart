part of 'currency_list_bloc.dart';

@immutable
abstract class CurrencyListEvent {
  const CurrencyListEvent();
}

class LoadCurrenciesEvent extends CurrencyListEvent {
  final String searchParam;

  LoadCurrenciesEvent(this.searchParam);
}

class RefreshCurrenciesEvent extends CurrencyListEvent {
  final String searchParam;

  RefreshCurrenciesEvent(this.searchParam);
}

class LanguageChangedEvent extends CurrencyListEvent {
  final String languageCode;
  LanguageChangedEvent(this.languageCode);
}
