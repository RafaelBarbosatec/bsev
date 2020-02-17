// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bsev_demo/screens/second_screen/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SecondBloc _secondBloc;
  SecondStreams _secondStreams;

  setUp(() {
    _secondStreams = SecondStreams();
    _secondBloc = SecondBloc()..streams = _secondStreams;
  });

  tearDown(() {
    _secondBloc?.dispose();
  });

  test('initial streams', () {
    expect(_secondStreams.count.value, null);
  });

  test('add value', () {
    _secondBloc.eventReceiver(SecondEventIncrement());
    expect(_secondStreams.count.value, 1);
  });

  test('add value 3 times', () {
    _secondBloc.eventReceiver(SecondEventIncrement());
    _secondBloc.eventReceiver(SecondEventIncrement());
    _secondBloc.eventReceiver(SecondEventIncrement());
    expect(_secondStreams.count.value, 3);
  });
}
