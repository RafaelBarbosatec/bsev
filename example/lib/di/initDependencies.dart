import 'package:bsev/bsev.dart';
import 'package:bsev/flavors.dart';
import 'package:bsev_demo/repository/cripto_repository/CriptoRepository.dart';
import 'package:bsev_demo/screens/home/bloc/bloc.dart';
import 'package:bsev_demo/screens/second/bloc/bloc.dart';
import 'package:bsev_demo/support/conection/con.dart';

initDependencies() {
  injectRepository();
  injectBloc();
}

injectBloc() {
  registerBloc<HomeBloc, HomeStreams>(
      (i) => HomeBloc(i.get()), () => HomeStreams());
  registerSingletonBloc<SecondBloc, SecondStreams>(
      (i) => SecondBloc(), () => SecondStreams());
}

injectRepository() {
  registerSingletonDependency((i) => CryptoRepository(i.get()));

  registerSingletonDependency<Con>((i) {
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
