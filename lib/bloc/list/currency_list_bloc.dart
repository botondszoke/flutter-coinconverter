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
      //emit(Loading());
      try {
        final currencies = await _currencyInteractor.getCurrencies(
            event.searchParam);
        print("Loading currencies successfully finished");
        emit(Loaded(currencies: currencies, searchParam: event.searchParam));
      } on Exception catch (e) {
        print("Loading currencies successfully failed. ${e.toString()}");
        emit(Error(currencies: [], searchParam: event.searchParam));
      }
    });
    on<RefreshCurrenciesEvent> ((event, emit) async {
      if (state is Loaded) {
        emit(Refreshing());
        try {
          final currencies = await _currencyInteractor.getCurrencies(event.searchParam);
          print("Loading currencies successfully finished");
          emit(Loaded(currencies: currencies, searchParam: event.searchParam));
        } on Exception catch (e) {
          print("Loading currencies successfully failed. ${e.toString()}");
          emit(Error(currencies: [], searchParam: event.searchParam));
        }
      }
    });
  }
}
