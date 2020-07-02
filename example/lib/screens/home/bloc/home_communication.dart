import 'package:bsev/bsev.dart';
import 'package:bsev_demo/repository/pokemon/model/pokemon.dart';

class HomeCommunication extends CommunicationBase {
  final pokemonList = BehaviorSubjectCreate<List<Pokemon>>();
  final showProgress = BehaviorSubjectCreate<bool>(initValue: false);

  @override
  void dispose() {
    pokemonList.close();
    showProgress.close();
    super.dispose();
  }
}
