import 'package:rxdart/rxdart.dart';
import 'dart:async';

class StreamCreate<T> {
  final StreamController<T> _controller = StreamController<T>();
  Stream<T> get get => _controller.stream;
  Function(T) get set => _controller.sink.add;

  void close() {
    _controller.close();
  }
}

class PublishSubjectCreate<T> {
  final _controller = PublishSubject<T>();
  Stream<T> get get => _controller.stream;
  Function(T) get set => _controller.add;
  void close() {
    _controller.close();
  }
}

class BehaviorSubjectCreate<T> {
  BehaviorSubject<T> _controller;

  BehaviorSubjectCreate({T initValue}) {
    initValue == null
        ? _controller = BehaviorSubject<T>()
        : _controller = BehaviorSubject<T>()
      ..value = initValue;
  }

  Stream<T> get get => _controller.stream;
  Function(T) get set => _controller.add;
  T get value => _controller.value;

  void close() {
    _controller.close();
  }
}

class ReplaySubjectCreate<T> {

  final _controller = ReplaySubject<T>();
  Stream<T> get get => _controller.stream;
  Function(T) get set => _controller.add;
  List<T> get values => _controller.values;
  void close() {
    _controller.close();
  }
}
