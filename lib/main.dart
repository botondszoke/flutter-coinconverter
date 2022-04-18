import 'package:coin_converter/dio/cc_service.dart';
import 'package:coin_converter/ui/currency_list.dart';
import 'package:coin_converter/model/list_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dataSource = CCService();

  runApp(
      Provider<CCService>(
        create: (_) => dataSource,
        child: const CoinConverterApp(),
      ),
  );
}

class CoinConverterApp extends StatelessWidget {
  const CoinConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Converter',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const CurrencyListPage(),
    );
  }
}
