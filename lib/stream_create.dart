import 'package:rxdart/rxdart.dart';
import 'dart:async';

class StreamCreate<T> {
  final StreamController<T> controller = StreamController<T>();

  Stream<T> get get => controller.stream;

  Function(T) get set => controller.sink.add;

  void close() {
    controller.close();
  }
}

class PublishSubjectCreate<T> {
  final subject = PublishSubject<T>();

  Stream<T> get get => subject.stream;

  Function(T) get set => subject.add;

  void close() {
    subject.close();
  }
}

class BehaviorSubjectCreate<T> {
  BehaviorSubject<T> subject;

  BehaviorSubjectCreate({T initValue}) {
    initValue == null
        ? subject = BehaviorSubject<T>()
        : subject = BehaviorSubject<T>()
      ..value = initValue;
  }

  Stream<T> get get => subject.stream;

  Function(T) get set => subject.add;

  T get value => subject.value;

  void close() {
    subject.close();
  }
}

class ReplaySubjectCreate<T> {
  final subject = ReplaySubject<T>();

  Stream<T> get get => subject.stream;

  Function(T) get set => subject.add;

  List<T> get values => subject.values;

  void close() {
    subject.close();
  }
}
