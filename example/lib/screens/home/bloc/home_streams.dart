import 'package:bsev/bsev.dart';
import 'package:bsev_demo/repository/pokemon/model/pokemon.dart';

class HomeStreams extends StreamsBase {
  var pokemonList = BehaviorSubjectCreate<List<Pokemon>>();
  var showProgress = BehaviorSubjectCreate<bool>(initValue: false);

  @override
  void dispose() {
    pokemonList.close();
    showProgress.close();
  }
}
