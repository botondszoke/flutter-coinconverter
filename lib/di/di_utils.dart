import 'package:get_it/get_it.dart';

import '../bloc/details/currency_details_bloc.dart';
import '../bloc/list/currency_list_bloc.dart';
import '../dio/cc_api.dart';
import '../dio/cc_network_data_source.dart';
import '../dio/cc_service.dart';
import '../domain/interactor/currency_interactor.dart';

final injector = GetIt.instance;

void initDependencies() {
  injector.registerSingleton<CCApi>(CCService());

  injector.registerSingleton(
    CCNetworkDataSource(injector<CCApi>()),
  );

  injector.registerSingletonAsync(
        () async {
      return CurrencyInteractor(
        injector<CCNetworkDataSource>(),
      );
    },
  );

  injector.registerFactory(
        () => CurrencyListBloc(
      injector<CurrencyInteractor>(),
    ),
  );

  injector.registerFactory(
        () => CurrencyDetailsBloc(
      injector<CurrencyInteractor>(),
    ),
  );
}