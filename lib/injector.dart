import 'package:bsev/bsev.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

typedef T BlocBuilder<T extends BlocBase>(GetIt injector);
typedef T DependencyBuilder<T>(GetIt injector);
typedef T CommunicationBuilder<T extends CommunicationBase>();

registerBloc<T extends BlocBase, S extends CommunicationBase>(
    BlocBuilder<T> blocBuilder, CommunicationBuilder streamBuilder) {
  getIt.registerFactory<S>(() => streamBuilder());
  getIt.registerFactory<T>(() => blocBuilder(getIt));
}

registerDependency<T>(DependencyBuilder<T> builder, {String dependencyName}) {
  getIt.registerFactory(
    () => builder(getIt),
    instanceName: dependencyName,
  );
}

registerSingletonDependency<T>(DependencyBuilder<T> builder,
    {String dependencyName}) {
  getIt.registerLazySingleton(
    () => builder(getIt),
    instanceName: dependencyName,
  );
}

T getDependency<T>({String dependencyName}) {
  return getIt.get<T>(instanceName: dependencyName);
}
