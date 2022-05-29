import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:coin_converter/main.dart';
import 'package:coin_converter/ui/list/currency_list.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/interactor/currency_interactor.dart';
import '../../domain/model/list_model.dart';

part 'currency_list_event.dart';
part 'currency_list_state.dart';

class CurrencyListBloc extends Bloc<CurrencyListEvent, CurrencyListState> {
  final CurrencyInteractor _currencyInteractor;

  static const CURRENT_LANGUAGE_KEY = "CURRENT_LANGUAGE";

  CurrencyListBloc(
      this._currencyInteractor
      ) : super(Loading()) {
    on<LoadCurrenciesEvent> ((event, emit) async {
      try {

        final prefs = await SharedPreferences.getInstance();
        String languageCode = await prefs.getString(CURRENT_LANGUAGE_KEY) ?? "en";

        final currencies = await _currencyInteractor.getCurrencies(event.searchParam);

        if (languageCode == "hu") {
          final rates = await _currencyInteractor.getRates();
          for (var e in currencies) {
            e.setPresentedCurrency(rates.singleWhere((element) => element.symbol == "HUF"));
          }
        }

        emit(Loaded(currencies: currencies, searchParam: event.searchParam));
      } on Exception {
        emit(Error(currencies: [], searchParam: event.searchParam));
      }
    });
    on<RefreshCurrenciesEvent> ((event, emit) async {
      if (state is Loaded) {
        emit(Refreshing());
        try {
          final prefs = await SharedPreferences.getInstance();
          String languageCode = await prefs.getString(CURRENT_LANGUAGE_KEY) ?? "en";

          final currencies = await _currencyInteractor.getCurrencies(event.searchParam);

          if (languageCode == "hu") {
            final rates = await _currencyInteractor.getRates();
            for (var e in currencies) {
              e.setPresentedCurrency(rates.singleWhere((element) => element.symbol == "HUF"));
            }
          }

          emit(Loaded(currencies: currencies, searchParam: event.searchParam));
        } on Exception {
          emit(Error(currencies: [], searchParam: event.searchParam));
        }
      }
    });
    on<LanguageChangedEvent> ((event, emit) async {
      if (state is Loaded) {
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(CURRENT_LANGUAGE_KEY, event.languageCode);

        } on Exception {
          emit(Error(currencies: [], searchParam: event.languageCode));
        }
      }
    });
  }
}
