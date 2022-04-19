import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/interactor/currency_interactor.dart';
import '../../domain/model/list_model.dart';

part 'currency_list_event.dart';
part 'currency_list_state.dart';

class CurrencyListBloc extends Bloc<CurrencyListEvent, CurrencyListState> {
  final CurrencyInteractor _currencyInteractor;

  CurrencyListBloc(
      this._currencyInteractor
      ) : super(Loading()) {
    on<LoadCurrenciesEvent> ((event, emit) async {
      try {
        final currencies = await _currencyInteractor.getCurrencies();
        print("Loading currencies successfully finished");
        emit(Loaded(currencies: currencies));
      } on Exception catch (e) {
        print("Loading currencies successfully failed. ${e.toString()}");
        emit(Error(currencies: []));
      }
    },);
  }

  /*@override
  Stream<CurrencyListState> mapEventToState(CurrencyListEvent event) async* {
    if (event is LoadCurrenciesEvent) {
      yield* _mapLoadCurrenciesToState();
  }

  Stream<CurrencyListState> _mapLoadCurrenciesToState() async* {
    try {
      print("Loading currencies from the API");
      final currencies = await _currencyInteractor.getCurrencies();
      print("Loading currencies successfully finished");
      yield ContentReady(currencies: currencies);
    } on Exception catch (e) {
      print("Loading currencies successfully failed. ${e.toString()}");
      yield Error(currencies: []);
    }
  }*/
}
