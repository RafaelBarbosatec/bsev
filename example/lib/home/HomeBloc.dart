
import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home/HomeEvents.dart';
import 'package:bsev_demo/home/HomeStreams.dart';

class HomeBloc extends BlocBase<HomeStreams,HomeEvents>{

  @override
  void eventReceiver(HomeEvents event) {

  }

  @override
  void initState() {
    streams = HomeStreams();
  }

  @override
  void initView() {

  }

}