import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'core/network/network_info.dart';
import 'injection_container.config.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => sl.init();

@module
abstract class RegisterModule {
  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @LazySingleton(as: NetworkInfo)
  NetworkInfoImpl get networkInfo => NetworkInfoImpl(sl());
}

Future<void> init() async {
  // Offline persistence only needed for non-web platforms
  if (!kIsWeb) {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
  }
  await configureDependencies();
}