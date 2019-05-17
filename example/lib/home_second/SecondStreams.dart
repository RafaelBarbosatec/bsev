import 'package:bsev/bsev.dart';
import 'package:bsev/stream_base.dart';

class SecondStreams extends StreamsBase{

  var msg = BehaviorSubjectCreate<String>();

  @override
  void dispose() {
    msg.close();
  }

}