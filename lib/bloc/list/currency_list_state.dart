part of 'currency_list_bloc.dart';

@immutable
abstract class CurrencyListState {
  const CurrencyListState();
}

class Loading extends CurrencyListState {
  static final Loading _instance = Loading._();

  factory Loading() => _instance;

  Loading._();
}

abstract class Content extends CurrencyListState {
  final List<CoinCurrencyItem> currencies;

  Content({required this.currencies});
}

class Loaded extends Content with EquatableMixin {
  Loaded({required List<CoinCurrencyItem> currencies}): super(currencies: currencies);

  @override
  List<Object> get props => [currencies];
}

/*class Refreshing extends Content with EquatableMixin {
  Refreshing({required List<CoinCurrencyItem> currencies}): super(currencies: currencies);

  @override
  List<Object> get props => [currencies];
}*/
class Error extends Content with EquatableMixin {
  Error({required List<CoinCurrencyItem> currencies}): super(currencies: currencies);

  @override
  List<Object> get props => [currencies];
}