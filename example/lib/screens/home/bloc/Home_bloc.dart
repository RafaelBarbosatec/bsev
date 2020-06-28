import 'package:bsev/bsev.dart';
import 'package:bsev_demo/repository/pokemon/model/pokemon.dart';
import 'package:bsev_demo/repository/pokemon/pokemon_repository.dart';
import 'package:bsev_demo/screens/home/bloc/bloc.dart';

class HomeBloc extends BlocBase<HomeStreams> {
  final PokemonRepository api;

  int _page = 0;
  List<Pokemon> _list = List();
  static const limit = 20;

  HomeBloc(this.api);

  @override
  void initView() {
    loadCrypto(false);
  }

  @override
  void eventReceiver(EventsBase event) {
    if (event is HomeEventLoad) {
      loadCrypto(event.isMore);
    }
  }

  void loadCrypto(bool isMore) async {
    if (streams.showProgress.value) {
      return;
    }

    if (isMore) {
      _page++;
    } else {
      _page = 0;
    }

    try {
      streams.showProgress.set(true);
      final response = await api.getPokemons(page: _page, limit: limit);
      if (isMore) {
        _list.addAll(response);
      } else {
        _list = response;
      }
      streams.pokemonList.set(_list);
      streams.showProgress.set(false);
    } catch (e) {
      streams.showProgress.set(false);
      dispatchView(
        HomeEventShowError()..msg = "Unable conection to load information",
      );
    }
  }
}
