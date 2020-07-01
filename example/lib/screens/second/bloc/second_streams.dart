import 'package:bsev/bsev.dart';
import 'package:bsev/communication_base.dart';

class SecondStreams extends CommunicationBase {
  var count = BehaviorSubjectCreate<int>();

  @override
  void dispose() {
    count.close();
  }
}
