import 'package:bsev/bsev.dart';
import 'package:bsev/src/communication.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

typedef T BlocBuilder<T extends Bloc>(GetIt injector);
typedef T DependencyBuilder<T>(GetIt injector);
typedef T CommunicationBuilder<T extends Communication>();

registerBloc<B extends Bloc, C extends Communication>(
    BlocBuilder<B> blocBuilder, CommunicationBuilder communicationBuilder) {
  getIt.registerFactory<C>(() => communicationBuilder());
  getIt.registerFactory<B>(() => blocBuilder(getIt));
}

registerSingletonBloc<B extends Bloc, C extends Communication>(
    BlocBuilder<B> blocBuilder, CommunicationBuilder communicationBuilder) {
  getIt.registerLazySingleton<C>(
    () => communicationBuilder()..isSingleton = true,
  );
  getIt.registerLazySingleton<B>(() => blocBuilder(getIt));
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
