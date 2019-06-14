import 'dart:math';

String generateId() {
  return "${DateTime.now().millisecondsSinceEpoch.toString()}${Random().nextInt(1000)}";
}
