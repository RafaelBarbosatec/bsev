


import 'package:bsev_demo/repository/cripto_repository/CriptoRepository.dart';
import 'package:bsev_demo/support/conection/con.dart';
import 'package:simple_injector/simple_injector.dart';

class RepositoryModule extends ModuleInjector{

  RepositoryModule(){
    add(CriptoRepository, criptoRepositoryCreate);
    add(Con, conCreate, isSingleton: true);
  }

  CriptoRepository criptoRepositoryCreate(){
    return CriptoRepositoryImpl(inject());
  }

  Con conCreate(){

    String url;
    switch(flavor) {
      case Flavor.PROD: url = "https://api.coinmarketcap.com/v1/ticker/"; break;
      case Flavor.HOMOLOG: url = "https://api.coinmarketcap.com/v1/ticker/"; break;
      case Flavor.DEBUG: url = "https://api.coinmarketcap.com/v1/ticker/"; break;
    }
    return ConDioImpl(url);
  }
}