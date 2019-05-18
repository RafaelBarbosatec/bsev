
import 'package:bsev_demo/home/HomeBloc.dart';
import 'package:bsev_demo/home/HomeStreams.dart';
import 'package:bsev_demo/home_second/SecondBloc.dart';
import 'package:bsev_demo/home_second/SecondStreams.dart';
import 'package:injector/injector.dart';

injectBloc(Injector injector){

  injector.registerDependency((i)=> HomeBloc(i.getDependency()));
  injector.registerDependency((i)=> HomeStreams());

  injector.registerDependency((i)=> SecondBloc());
  injector.registerDependency((i)=> SecondStreams());

}
