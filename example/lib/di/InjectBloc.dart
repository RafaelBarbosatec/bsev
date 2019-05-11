
import 'package:bsev_demo/home/HomeBloc.dart';
import 'package:injector/injector.dart';

injectBloc(Injector injector){

  injector.registerDependency((i)=> HomeBloc(i.getDependency()));

}
