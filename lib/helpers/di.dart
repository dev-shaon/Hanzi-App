import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

final locator = GetIt.instance;
final appData = locator.get<GetStorage>();

// Global RouteObserver — register in MaterialApp's navigatorObservers
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void diSetUp() {
  locator.registerSingleton<GetStorage>(GetStorage());
}
