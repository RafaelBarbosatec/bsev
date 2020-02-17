import 'package:bsev/bsev.dart';
import 'package:bsev/stream_base.dart';

class SecondStreams extends StreamsBase {
  var count = BehaviorSubjectCreate<int>();

  @override
  void dispose() {
    count.close();
  }
}
