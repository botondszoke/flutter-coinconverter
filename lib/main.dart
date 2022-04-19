
import 'package:coin_converter/ui/list/currency_list.dart';
import 'package:flutter/material.dart';

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
            ),
            home: CurrencyListPage(),
            onGenerateRoute: (settings) {
              final name = settings.name ?? "";
              if (name.startsWith(DETAIL_PAGE)) {
                return MaterialPageRoute(
                  builder: (context) {
                    //return CurrencyDetails(settings.arguments as int);
                    return Container();
                  },
                );
              }
              return null;
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
