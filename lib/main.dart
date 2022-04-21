
import 'package:coin_converter/ui/details/currency_details.dart';
import 'package:coin_converter/ui/list/currency_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'di/di_utils.dart';

void main() {
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CoinConverterApp());
}

const DETAIL_PAGE = "/details";

class CoinConverterApp extends StatelessWidget {
  const CoinConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: injector.allReady(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: 'Coin Converter',
            theme: ThemeData(
              primarySwatch: Colors.amber,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: CurrencyListPage(),
            localizationsDelegates: L10n.localizationsDelegates,
            supportedLocales: L10n.supportedLocales,
            onGenerateRoute: (settings) {
              final name = settings.name ?? "";
              if (name.startsWith(DETAIL_PAGE)) {
                if (name == DETAIL_PAGE) {
                  return MaterialPageRoute(
                    settings: RouteSettings(name: "$DETAIL_PAGE/unknown"),
                    builder: (context) {
                      return CurrencyDetails("unknown");
                    },
                  );
                }
                return MaterialPageRoute(
                    settings: RouteSettings(name: settings.name),
                    builder: (context) {
                      print(settings.name);
                      return CurrencyDetails(settings.name.toString().split("/")[2]);
                    },
                );
              }
              return null;
            },
            onUnknownRoute: (route) {
              //TODO: Kéne error page :)
              //return MaterialPageRoute()
            },
          );
        }
        return Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(color: Colors.green,),
          ),
        );
      },
    );
  }
}
