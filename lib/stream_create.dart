import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class StreamCreate<T> {
  Stream<T> get;
  void set(T event);
  T value;
  void close() {}
}

class StreamControllerCreate<T> extends StreamCreate<T> {
  final StreamController<T> controller = StreamController<T>();

  Stream<T> get get => controller.stream;

  void set(T event) {
    if (!controller.isClosed) controller.sink.add(event);
  }

  void close() {
    controller.close();
  }
}

class PublishSubjectCreate<T> extends StreamCreate<T> {
  final subject = PublishSubject<T>();

  Stream<T> get get => subject.stream;

  void set(T event) {
    if (!subject.isClosed) subject.add(event);
  }

  void close() {
    subject.close();
  }
}

class BehaviorSubjectCreate<T> extends StreamCreate<T> {
  BehaviorSubject<T> subject;

  BehaviorSubjectCreate({T initValue}) {
    initValue == null
        ? subject = BehaviorSubject<T>()
        : subject = BehaviorSubject<T>()
      ..value = initValue;
  }

  Stream<T> get get => subject.stream;

  void set(T event) {
    if (!subject.isClosed) subject.add(event);
  }

  T get value => subject.value;

  void close() {
    subject.close();
  }
}

class ReplaySubjectCreate<T> extends StreamCreate<T> {
  final subject = ReplaySubject<T>();

  Stream<T> get get => subject.stream;

  void set(T event) {
    if (!subject.isClosed) subject.add(event);
  }

  List<T> get values => subject.values;

  void close() {
    subject.close();
  }
}
