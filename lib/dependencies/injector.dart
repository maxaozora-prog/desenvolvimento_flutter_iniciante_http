import 'package:desenvolvimento_flutter_iniciante/controller/pessoa_controller.dart';
import 'package:desenvolvimento_flutter_iniciante/controller/theme_controller.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void injector() {
//   GetIt.instance.registerSingleton<PessoaController>(PessoaController());
// }

Future<void> injector() async { //Com o sharedPreferences.
  final i = GetIt.instance;

  i.registerSingleton<PessoaController>(PessoaController());
  i.registerSingleton<ThemeController>(ThemeController(
    sharedPreferences: await SharedPreferences.getInstance(),
  ));
  
}