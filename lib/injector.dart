import 'package:bsev/bsev.dart';
import 'package:injector/injector.dart';

typedef T BlocBuilder<T extends BlocBase>(Injector injector);
typedef T DependencyBuilder<T>(Injector injector);
typedef T BlocStreamBuilder<T extends StreamsBase>();

registerBloc<T extends BlocBase, S extends StreamsBase>(
    BlocBuilder<T> blocBuilder, BlocStreamBuilder streamBuilder) {
  Injector.appInstance.registerDependency<S>((i) => streamBuilder());
  Injector.appInstance.registerDependency<T>(blocBuilder);
}

registerDependency<T>(DependencyBuilder<T> builder,
    {bool override = false, String dependencyName = ""}) {
  Injector.appInstance.registerDependency(builder,
      override: override, dependencyName: dependencyName);
}

registerSingleton<T>(DependencyBuilder<T> builder,
    {bool override = false, String dependencyName = ""}) {
  Injector.appInstance.registerSingleton(builder,
      override: override, dependencyName: dependencyName);
}

T getDependency<T>({String dependencyName = ""}) {
  return Injector.appInstance.getDependency<T>(dependencyName: dependencyName);
}
