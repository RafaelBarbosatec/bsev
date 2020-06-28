import 'package:bsev_demo/repository/pokemon/model/pokemon.dart';
import 'package:bsev_demo/support/conection/con.dart';

class PokemonRepository {
  final Con _con;

  PokemonRepository(this._con);

  Future<List<Pokemon>> getPokemons({int page = 0, int limit}) {
    String paramLimit = '';
    if (limit != null) paramLimit = '&limit=$limit';

    return _con.get('pokemon?page=$page$paramLimit').then((response) =>
        response['data']
            .map<Pokemon>((item) => Pokemon.fromJson(item))
            .toList());
  }
}
