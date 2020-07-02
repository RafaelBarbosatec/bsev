import 'package:bsev/bsev.dart';
import 'package:bsev_demo/repository/pokemon/model/pokemon.dart';
import 'package:bsev_demo/repository/pokemon/pokemon_repository.dart';
import 'package:bsev_demo/screens/home/bloc/bloc.dart';

class HomeBloc extends BlocBase<HomeCommunication> {
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

  void loadCrypto(bool isMore) {
    if (communication.showProgress.value) {
      return;
    }

    if (isMore) {
      _page++;
    } else {
      _page = 0;
    }

    communication.showProgress.set(true);

    api
        .getPokemons(page: _page, limit: limit)
        .then(isMore ? _addInList : _populateList)
        .whenComplete(() => communication.showProgress.set(false))
        .catchError(_resolveError);
  }

  _populateList(List<Pokemon> response) {
    _list = response;
    communication.pokemonList.set(_list);
  }

  _addInList(List<Pokemon> response) {
    _list.addAll(response);
    communication.pokemonList.set(_list);
  }

  _resolveError(onError) {
    dispatchView(
      HomeEventShowError("Unable conection to load information"),
    );
  }
}
