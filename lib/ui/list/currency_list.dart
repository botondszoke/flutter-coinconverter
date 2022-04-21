import 'package:coin_converter/bloc/list/currency_list_bloc.dart';
import 'package:coin_converter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/di_utils.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'currency_list_item.dart';

class CurrencyListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return Scaffold(
      //TODO: ADD Language changer button
      appBar: AppBar(
        title: Semantics(
          child: Text(l10n.currencyListTitle),
          label: "This is the CurrencyListPage.",
        )
      ),
      body: BlocProvider(
        create: (context) => injector<CurrencyListBloc>(),
        child: BlocListener<CurrencyListBloc, CurrencyListState>(
          listener: (context, state) {
            if (state is Error) {
              context.showSnackBar(
                content: Text(l10n.snackbarLoadError),
              );
            }
          },
          child: BlocBuilder<CurrencyListBloc, CurrencyListState>(
              builder: (context, state) {
                if (state is Loading) {
                  BlocProvider.of<CurrencyListBloc>(context)
                      .add(LoadCurrenciesEvent(""));
                  return CurrencyListLoading();
                }
                if (state is Loaded) {
                  return CurrencyListItems(state);
                }
                return Center(
                  child: Text(l10n.snackbarLoadError)
                );
              }
          )
        )
      ),
    );
  }
}

class CurrencyListLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}