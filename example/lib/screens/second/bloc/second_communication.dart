import 'package:bsev/bsev.dart';
import 'package:bsev/communication_base.dart';

class SecondCommunication extends CommunicationBase {
  var count = BehaviorSubjectCreate<int>();

  @override
  void dispose() {
    count.close();
    super.dispose();
  }
}
