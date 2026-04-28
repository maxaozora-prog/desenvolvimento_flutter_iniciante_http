import 'package:desenvolvimento_flutter_iniciante/controller/pessoa_controller.dart';
import 'package:desenvolvimento_flutter_iniciante/controller/theme_controller.dart';
import 'package:desenvolvimento_flutter_iniciante/services/api_client.dart';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void injector() {
//   GetIt.instance.registerSingleton<PessoaController>(PessoaController());
// }

Future<void> injector() async { //Com o sharedPreferences.
  final i = GetIt.instance;

  // i.registerSingleton<PessoaController>(PessoaController());
   i.registerFactory(//Codigo aderido na aula de ajuste de injeção de dependencia.
      () => ApiClient(dio: Dio(), apiUrl: "http://localhost:3000"));

  i.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());//Codigo aderido na aula de ajuste de injeção de dependencia.

  i.registerSingleton<PessoaController>(//Codigo aderido na aula de ajuste de injeção de dependencia.
      PessoaController(apiClient: i<ApiClient>()));




  i.registerSingleton<ThemeController>(ThemeController(
    // sharedPreferences: await SharedPreferences.getInstance(),
    sharedPreferences: i(),//Codigo aderido na aula de ajuste de injeção de dependencia.
  ));
  
}