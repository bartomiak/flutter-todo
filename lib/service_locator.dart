import 'package:flutter_todo_app/api/app_rest_client.dart';
import 'package:get_it/get_it.dart';

import 'repository/todo_repository.dart';

final serviceLocator = GetIt.instance;

void setupServicesLocator() {
  // Registering AppRestClient as a lazy singleton
  serviceLocator.registerLazySingleton(() => AppRestClient());

  // Registering TodoRepository as a lazy singleton
  serviceLocator.registerLazySingleton(
      () => TodoRepository(client: serviceLocator<AppRestClient>()));
}
