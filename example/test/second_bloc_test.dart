// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bsev_demo/screens/second/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SecondBloc _secondBloc;
  SecondCommunication _secondCommunication;

  setUp(() {
    _secondCommunication = SecondCommunication();
    _secondBloc = SecondBloc()..setCommunication(_secondCommunication);
  });

  tearDown(() {
    _secondBloc?.dispose();
  });

  test('initial streams', () {
    expect(_secondCommunication.count.value, null);
  });

  test('add value', () {
    _secondCommunication.dispatcher(SecondEventIncrement());
    expect(_secondCommunication.count.value, 1);
  });

  test('add value 3 times', () {
    _secondCommunication.dispatcher(SecondEventIncrement());
    _secondCommunication.dispatcher(SecondEventIncrement());
    _secondCommunication.dispatcher(SecondEventIncrement());
    expect(_secondCommunication.count.value, 3);
  });
}
