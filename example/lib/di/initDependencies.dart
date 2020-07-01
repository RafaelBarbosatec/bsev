import 'package:bsev/bsev.dart';
import 'package:bsev/flavors.dart';
import 'package:bsev_demo/repository/pokemon/pokemon_repository.dart';
import 'package:bsev_demo/screens/home/bloc/bloc.dart';
import 'package:bsev_demo/screens/second/bloc/bloc.dart';
import 'package:bsev_demo/support/conection/con.dart';

initDependencies() {
  injectRepository();
  injectBloc();
}

injectBloc() {
  registerBloc<HomeBloc, HomeCommunication>(
      (i) => HomeBloc(i.get()), () => HomeCommunication());
  registerBloc<SecondBloc, SecondCommunication>(
      (i) => SecondBloc(), () => SecondCommunication());
}

injectRepository() {
  registerSingletonDependency((i) => PokemonRepository(i.get()));

  registerSingletonDependency<Con>((i) {
    String url;

    switch (Flavors().getFlavor()) {
      case Flavor.PROD:
        url = "http://104.131.18.84/";
        break;
      case Flavor.HML:
        url = "http://104.131.18.84/";
        break;
      case Flavor.DEBUG:
        url = "http://104.131.18.84/";
        break;
    }

    return Con(url);
  });
}
