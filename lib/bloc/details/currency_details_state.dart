part of 'currency_details_bloc.dart';

abstract class CurrencyDetailsState extends Equatable {
  const CurrencyDetailsState();
}

class CurrencyDetailsInitial extends CurrencyDetailsState {
  @override
  List<Object> get props => [];
}
