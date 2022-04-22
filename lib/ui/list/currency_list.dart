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

    return BlocProvider(
      create: (context) => injector<CurrencyListBloc>(),
      child: /*BlocListener<CurrencyListBloc, CurrencyListState>(
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
              BlocProvider.of<CurrencyListBloc>(context).add(LoadCurrenciesEvent(searchParameter));
              return Scaffold(
                //TODO: ADD Language changer button
                appBar: AppBar(
                  title: Semantics(
                  child: Text(l10n.currencyListTitle),
                    label: "This is the CurrencyListPage.",
                  )
                ),
                body: CurrencyListLoading(),
                floatingActionButton: FloatingActionButton.extended(
                  icon: const Icon(Icons.search),
                  label: Text(l10n.search),
                  onPressed: () {},
                )
              );
            }
            if (state is Loaded) {
              return Scaffold(
                //TODO: ADD Language changer button
                appBar: AppBar(
                  title: Semantics(
                  child: Text(l10n.currencyListTitle),
                    label: "This is the CurrencyListPage.",
                  )
                ),
                body: CurrencyListItems(state),
                floatingActionButton: FloatingActionButton.extended(
                  icon: const Icon(Icons.search),
                  label: Text(l10n.search),
                  onPressed: () async {
                    var result = await showSearchDialog(context, l10n, searchParameter);
                    if (result != l10n.cancel) {
                      BlocProvider.of<CurrencyListBloc>(context).add(RefreshCurrenciesEvent(result.toString()));
                    }
                  },
                )
              );
            }
            return Center(
              child: Text(l10n.snackbarLoadError)
            );
          }
        ),*/
        Scaffold(
          //TODO: ADD Language changer button
          appBar: AppBar(
            title: Semantics(
              child: Text(l10n.currencyListTitle),
              label: "This is the CurrencyListPage."
            )
          ),
          body: BlocListener<CurrencyListBloc, CurrencyListState>(
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
                if (state is Refreshing) {
                  return CurrencyListLoading();
                }
                return Center(
                  child: Text(l10n.snackbarLoadError)
                );
              }
            )
          ),
          floatingActionButton: BlocListener<CurrencyListBloc, CurrencyListState>(
            listener: (context, state) {},
            child: BlocBuilder<CurrencyListBloc, CurrencyListState>(
              builder: (context, state) {
                return FloatingActionButton.extended(
                  icon: const Icon(Icons.search),
                  label: Text(l10n.search),
                  onPressed: () async {
                    if (state is Loaded) {
                      var result = await showSearchDialog(context, l10n);
                      if (result != null) {
                        BlocProvider.of<CurrencyListBloc>(context).add(RefreshCurrenciesEvent(result));
                      }
                    }
                  },
                );
              }
            ),
          )
        )

            /*if (state is Refreshing) {}*/
      /*Scaffold(
          //TODO: ADD Language changer button
          appBar: AppBar(
          title: Semantics(
          child: Text(l10n.currencyListTitle),
      label: "This is the CurrencyListPage.",
      )
      ),
      body: BlocListener<CurrencyListBloc, CurrencyListState>(
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
          .add(LoadCurrenciesEvent(searchParameter));
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
      ),

      floatingActionButton: BlocListener<CurrencyListBloc, CurrencyListState
    }>(
          listener: (context, state) {},
          child: BlocBuilder<CurrencyListBloc, CurrencyListState>(
            builder: (context, state) {
              return FloatingActionButton.extended(
                icon: const Icon(Icons.search),
                label: Text(l10n.search),
                onPressed: () {
                  if (state is Loaded) {
                    showSearchDialog(context, l10n, searchParameter);
                  }
                },
              );
            }
          ),
        )

        //)
      },
    );*/
    );
  }

  Future<String?> showSearchDialog(BuildContext context, L10n l10n) {
    return showDialog<String> (
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String searchParam = "";
        return AlertDialog(
          title: Text(l10n.searchDialog),
          content: TextField(
            decoration: const InputDecoration(
              labelText: "ETH, Bitcoin, etc.",
            ),
            onChanged: (text) {
              searchParam = text;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text(l10n.cancel)
            ),
            TextButton(
              onPressed: () => {
                Navigator.pop(context, searchParam)
              },
              child: Text(l10n.search)
            )
          ],
        );
      }
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