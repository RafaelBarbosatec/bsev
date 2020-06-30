import 'package:bsev/bsev.dart';

class HomeEventLoad extends EventsBase {
  final bool isMore;

  HomeEventLoad({this.isMore = false});
}

class HomeEventShowError extends EventsBase {
  final String msg;

  HomeEventShowError(this.msg);
}
