import 'package:coin_converter/domain/model/list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/details/currency_details_bloc.dart';
import '../../di/di_utils.dart';

class CurrencyDetails extends StatelessWidget {
  final String currencyId;

  CurrencyDetails(this.currencyId);

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    return BlocProvider(
        create: (context) => injector<CurrencyDetailsBloc>(),
        child: BlocBuilder<CurrencyDetailsBloc, CurrencyDetailsState>(
          builder: (context, state) {
            if (state is Loading) {
              BlocProvider.of<CurrencyDetailsBloc>(context)
                  .add(LoadCurrencyEvent(currencyId));
              return CurrencyDetailsLoading();
            }
            if (state is Loaded) {
              final currency = state.currency;
              final rates = state.rates;
              rates.removeWhere((element) => element.symbol == currency.symbol);

              return Scaffold(
                appBar: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  title: Text(currency.name)
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Text(
                                currency.name,
                                style: TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                l10n.detailDescription,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      "${l10n.rank}: ${currency.rank}",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ),
                                  ),
                                ]
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      "${l10n.marketCap}: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Text(
                                      currency.getPresentedMarketCap() == null ? l10n.notAvailable : "${currency.getPresentedMarketCap()} ${currency.presentedCurrency.currencySymbol ?? currency.presentedCurrency.symbol}",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${l10n.supply}: ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ]
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currency.getPresentedSupply() == null ? l10n.notAvailable : currency.maxSupply != null ? "${currency.getPresentedSupply()} of ${currency.getPresentedMaxSupply()}" : "${currency.getPresentedSupply()}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ]
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${l10n.volume}: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      currency.getPresentedVolume() == null ? l10n.notAvailable : "${currency.getPresentedVolume()} ${currency.presentedCurrency.currencySymbol ?? currency.presentedCurrency.symbol}",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ]
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${l10n.change}: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      currency.getPresentedChangePercent() == null ? l10n.notAvailable : "${currency.getPresentedChangePercent()} %",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: currency.changePercent24Hr == null ? Colors.black : num.parse(currency.changePercent24Hr.toString()) > 0 ? Colors.green : Colors.red
                                      ),
                                    ),
                                  ]
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${l10n.vwap}: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ]
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currency.getPresentedVWAP() == null ? l10n.notAvailable : "${currency.getPresentedVWAP()} ${currency.presentedCurrency.currencySymbol ?? currency.presentedCurrency.symbol}",
                                    style: TextStyle(
                                        fontSize: 20,
                                    ),
                                  ),
                                ]
                              )
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${l10n.price}: ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        "${currency.getPresentedPrice()} ${currency.presentedCurrency.currencySymbol ?? currency.presentedCurrency.symbol}",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ]
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${l10n.selectCurrency}: ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      DropdownButton(
                                          icon: const Icon(Icons.keyboard_arrow_down),
                                          //TODO: Default curr
                                          value: currency.presentedCurrency.symbol,
                                          items: rates.map((PresentCurrency curr) {

                                            return DropdownMenuItem(
                                              value: curr.symbol,
                                              child: Text(curr.symbol)
                                            );
                                          }).toList(),
                                          onChanged: (Object? newValue) {
                                            currency.setPresentedCurrency(rates.singleWhere((element) => element.symbol == newValue));
                                            BlocProvider.of<CurrencyDetailsBloc>(context).add(ChangedCurrencyEvent(currency, rates));
                                          }
                                      )
                                    ]
                                )
                            ),
                            currency.explorer != null ? ElevatedButton(
                              onPressed: () async {
                                final url = currency.explorer;
                                if (url != null) {
                                  await launch(url, forceWebView: true);
                                }
                              },
                              child: Text(l10n.moreInfoButton),
                            ) : Text(
                              l10n.noMoreInfoText,
                              style: TextStyle(
                                  fontSize: 20
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              );
            }
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text(l10n.unknownCurrencyError),
              )
            );
          }
        )
    );
  }
}

class CurrencyDetailsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}