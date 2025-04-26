import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  /// Register your services here
  // serviceLocator.registerLazySingleton<YourService>(() => YourService());
}
