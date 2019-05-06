
import 'package:bsev_demo/home/HomeBloc.dart';
import 'package:simple_injector/simple_injector.dart';

class BlocModule extends ModuleInjector{

  BlocModule(){
    add(HomeBloc, homeBlocCreate);
  }

  HomeBloc homeBlocCreate(){
    return HomeBloc(
      inject()
    );
  }
}