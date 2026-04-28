import 'package:desenvolvimento_flutter_iniciante/dependencies/injector.dart';
import 'package:desenvolvimento_flutter_iniciante/models/pessoa.dart';
import 'package:desenvolvimento_flutter_iniciante/my_app.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/lista_pessoas.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/pessoa_listtile.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:desenvolvimento_flutter_iniciante/pages/home_page.dart';
import 'package:desenvolvimento_flutter_iniciante/routes/router.dart';
import 'package:desenvolvimento_flutter_iniciante/routes/routes.dart';
// void main() {
//   injector(); //injeção de dependencia.
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();// Para o sharedPreferences funcionar.
  await injector();
  runApp(const MyApp());
}





