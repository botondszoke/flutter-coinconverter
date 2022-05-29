import 'package:bloc/bloc.dart';
import 'package:coin_converter/domain/interactor/currency_interactor.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/model/list_model.dart';

part 'currency_details_event.dart';
part 'currency_details_state.dart';

class CurrencyDetailsBloc extends Bloc<CurrencyDetailsEvent, CurrencyDetailsState> {
  final CurrencyInteractor _currencyInteractor;

  CurrencyDetailsBloc(
      this._currencyInteractor
      ) : super(Loading()) {
    on<LoadCurrencyEvent>((event, emit) async {
      try {
        final currency = await _currencyInteractor.getCurrencyById(event.id);

        final rates = await _currencyInteractor.getRates();

        emit(Loaded(currency: currency, rates: rates));
      } on Exception {
        emit(Error());
      }
    });
    on<ChangedCurrencyEvent>((event, emit) async {
      if (state is Loaded) {
        try {
          emit(Loading());
          emit(Loaded(currency: event.currency, rates: event.rates));
        } on Exception {
          emit(Error());
        }
      }
    });
  }
}
