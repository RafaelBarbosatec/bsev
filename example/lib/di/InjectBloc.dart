import 'package:bsev/flavors.dart';
import 'package:bsev_demo/home/HomeBloc.dart';
import 'package:bsev_demo/home/HomeStreams.dart';
import 'package:bsev_demo/home_second/SecondBloc.dart';
import 'package:bsev_demo/home_second/SecondStreams.dart';
import 'package:bsev_demo/repository/cripto_repository/CriptoRepository.dart';
import 'package:bsev_demo/support/conection/con.dart';
import 'package:injector/injector.dart';

initDependencies(Injector injector) {
  injectBloc(injector);
  injectRepository(injector);
}

injectBloc(Injector injector) {
  injector.registerDependency((i) => HomeBloc(i.getDependency()));
  injector.registerDependency((i) => HomeStreams());

  injector.registerDependency((i) => SecondBloc());
  injector.registerDependency((i) => SecondStreams());
}

injectRepository(Injector injector) {
  injector.registerDependency((i) => CryptoRepository(i.getDependency()));

  injector.registerDependency<Con>((i) {
    String url;

    switch (Flavors().getFlavor()) {
      case Flavor.PROD:
        url = "https://api.coinmarketcap.com/v1/ticker/";
        break;
      case Flavor.HOMOLOG:
        url = "https://api.coinmarketcap.com/v1/ticker/";
        break;
      case Flavor.DEBUG:
        url = "https://api.coinmarketcap.com/v1/ticker/";
        break;
    }

    return Con(url);
  });
}
