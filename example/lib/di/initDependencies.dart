import 'package:bsev/bsev.dart';
import 'package:bsev/flavors.dart';
import 'package:bsev_demo/home/HomeBloc.dart';
import 'package:bsev_demo/home/HomeStreams.dart';
import 'package:bsev_demo/home_second/SecondBloc.dart';
import 'package:bsev_demo/home_second/SecondStreams.dart';
import 'package:bsev_demo/repository/cripto_repository/CriptoRepository.dart';
import 'package:bsev_demo/support/conection/con.dart';

initDependencies() {
  injectRepository();
  injectBloc();
}

injectBloc() {
  registerBloc<HomeBloc, HomeStreams>(
      (i) => HomeBloc(i.getDependency()), () => HomeStreams());
  registerBloc<SecondBloc, SecondStreams>(
      (i) => SecondBloc(), () => SecondStreams());
}

injectRepository() {
  registerDependency((i) => CryptoRepository(i.getDependency()));

  registerDependency<Con>((i) {
    String url;

    switch (Flavors().getFlavor()) {
      case Flavor.PROD:
        url = "https://api.coinmarketcap.com/v1/ticker/";
        break;
      case Flavor.HML:
        url = "https://api.coinmarketcap.com/v1/ticker/";
        break;
      case Flavor.DEBUG:
        url = "https://api.coinmarketcap.com/v1/ticker/";
        break;
    }

    return Con(url);
  });
}
