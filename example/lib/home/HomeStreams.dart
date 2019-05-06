import 'package:bsev/bsev.dart';
import 'package:bsev_demo/repository/cripto_repository/model/Cripto.dart';

class HomeStreams extends StreamsBase{

  var criptos = BehaviorSubjectCreate<List<Cripto>>();
  var showProgress = BehaviorSubjectCreate<bool>(initValue: false);

  @override
  void dispose() {
    criptos.close();
    showProgress.close();
  }

}