
import 'package:coin_converter/bloc/list/currency_list_bloc.dart';
import 'package:coin_converter/ui/details/currency_details.dart';
import 'package:coin_converter/ui/list/currency_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di/di_utils.dart';

void main() {
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CoinConverterApp());
}

const DETAIL_PAGE = "/details";
class CoinConverterApp extends StatefulWidget {
  CoinConverterApp({Key? key}) : super(key: key);
  @override
  CoinConverterAppState createState() => new CoinConverterAppState();
}
class CoinConverterAppState extends State<CoinConverterApp> {

  late Locale locale;

  @override
  void initState() {
    locale = L10n.supportedLocales[0];
    super.initState();
    readDefaultValue();
  }

  void changeLocale(Locale l) {
    setState(() {
      locale = l;
    });
  }

  void readDefaultValue() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = await prefs.getString(CurrencyListBloc.CURRENT_LANGUAGE_KEY);
    if (languageCode != null) {
      changeLocale(Locale(languageCode));
    }
  }

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
            home: CurrencyListPage(changeLocale: changeLocale),
            localizationsDelegates: L10n.localizationsDelegates,
            supportedLocales: L10n.supportedLocales,
            locale: locale,
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
              //TODO: error page
            },
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(color: Colors.amber,),
          ),
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
