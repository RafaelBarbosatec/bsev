import 'package:bsev/bsev.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

typedef T BlocBuilder<T extends BlocBase>(GetIt injector);
typedef T DependencyBuilder<T>(GetIt injector);
typedef T BlocStreamBuilder<T extends StreamsBase>();

registerBloc<T extends BlocBase, S extends StreamsBase>(
    BlocBuilder<T> blocBuilder, BlocStreamBuilder streamBuilder) {
  getIt.registerFactory<S>(() => streamBuilder());
  getIt.registerFactory<T>(() => blocBuilder(getIt));
}

registerSingletonBloc<T extends BlocBase, S extends StreamsBase>(
    BlocBuilder<T> blocBuilder, BlocStreamBuilder streamBuilder) {
  getIt.registerLazySingleton<S>(() => streamBuilder());
  getIt.registerLazySingleton<T>(() => blocBuilder(getIt));
}

registerDependency<T>(DependencyBuilder<T> builder, {String dependencyName}) {
  getIt.registerFactory(
    () => builder(getIt),
    instanceName: dependencyName,
  );
}

registerSingleton<T>(DependencyBuilder<T> builder, {String dependencyName}) {
  getIt.registerLazySingleton(
    () => builder(getIt),
    instanceName: dependencyName,
  );
}

T getDependency<T>({String dependencyName}) {
  return getIt.get<T>(instanceName: dependencyName);
}
