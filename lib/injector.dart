import 'package:bsev/bsev.dart';
import 'package:injector/injector.dart';

typedef T BlocBuilder<T extends BlocBase>(Injector injector);
typedef T DependencyBuilder<T>(Injector injector);
typedef T BlocStreamBuilder<T extends StreamsBase>();

registerBlocFactory<T extends BlocBase, S extends StreamsBase>(
    BlocBuilder<T> blocBuilder, BlocStreamBuilder streamBuilder) {
  Injector.appInstance.registerDependency<S>((i) => streamBuilder());
  Injector.appInstance.registerDependency<T>(blocBuilder);
}

registerBlocSingleton<T extends BlocBase, S extends StreamsBase>(
    BlocBuilder<T> blocBuilder, BlocStreamBuilder streamBuilder) {
  Injector.appInstance
      .registerSingleton<S>((i) => streamBuilder()..disposable = false);
  Injector.appInstance.registerSingleton<T>(blocBuilder);
}

registerDependency<T>(DependencyBuilder<T> builder) {
  Injector.appInstance.registerDependency(builder);
}

registerSingleton<T>(DependencyBuilder<T> builder) {
  Injector.appInstance.registerSingleton(builder);
}
