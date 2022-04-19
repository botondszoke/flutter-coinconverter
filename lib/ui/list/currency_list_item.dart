import 'dart:async';

import 'package:coin_converter/bloc/list/currency_list_bloc.dart';
import 'package:coin_converter/domain/model/list_model.dart';
import 'package:coin_converter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyListItems extends StatefulWidget {
  final Content state;

  CurrencyListItems(this.state);

  @override
  _CurrencyListItemState createState() => _CurrencyListItemState(state);
}

class _CurrencyListItemState extends State<CurrencyListItems> {
  Content state;
  late Completer _refreshCompleter;

  _CurrencyListItemState(this.state);

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer();
  }

  @override
  Widget build(BuildContext) {
    return BlocListener<CurrencyListBloc, CurrencyListState>(
      listener: (_, state) {
        if(!(state is Loading)) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
        }
      },
      child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<CurrencyListBloc>(context).add(LoadCurrenciesEvent());
            return _refreshCompleter.future;
          },
          child: ListView.builder(
            itemCount: state.currencies.length,
            itemBuilder: (context, index) {
              final item = state.currencies[index];
              return ListTile(
                shape: RoundedRectangleBorder(),
                leading: Icon(
                    Icons.monetization_on_rounded,
                    size: 30
                ),
                title: Text(
                  item.name,
                  overflow: TextOverflow.fade,
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "${item.getPresentedPrice()} ${item.presentedCurrency.currencySymbol == null ? item.presentedCurrency.symbol : item.presentedCurrency.currencySymbol}"
                    ),
                    IconButton(
                      padding: EdgeInsets.all(16),
                        splashRadius: 20,
                        splashColor: Colors.green,
                        iconSize: 20,
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            DETAIL_PAGE,
                            arguments: item.id
                          );
                        })
                  ],
                ),
              );
            }
          )
      )
    );
  }
}