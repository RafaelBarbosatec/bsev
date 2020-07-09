import 'package:bsev/bsev.dart';

class SecondCommunication extends Communication {
  final count = BehaviorSubjectCreate<int>();

  @override
  void dispose() {
    count.close();
    super.dispose();
  }
}
