 // This widget is the root of your application.
  import 'package:desenvolvimento_flutter_iniciante/controller/theme_controller.dart';
import 'package:desenvolvimento_flutter_iniciante/routes/router.dart';
import 'package:desenvolvimento_flutter_iniciante/routes/routes.dart';
import 'package:desenvolvimento_flutter_iniciante/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeController = GetIt.instance<ThemeController>();
  @override
  void initState() {//Criado para inicializar o getTheme do theme_controller para pegar o tema salvo.
    super.initState();
    themeController.getTheme();
  }
 Widget build(BuildContext context) {
  return ListenableBuilder(
      listenable: themeController,
      builder: (context, child) {
        return MaterialApp(
          initialRoute: Routes.initialRoute,
          routes: routes,
          title: 'Flutter Demo',
          theme: themeController.darkTheme == false ? lightTheme : darkTheme,
        );
      },
    );
  }
}

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     initialRoute: Routes.initialRoute, //Vai iniciar na rota que passar pega do router.dart
  //     routes: routes, //do arquivo router.dart
  //     title: 'Flutter Demo',
  //     theme: lightTheme, //Do arquivo theme.dart.
      // theme: ThemeData(
      //     useMaterial3: false,
       
      //   colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    //);
      
      
      
      
      
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text("Meu primeiro App."),
      //   ),
      //    body: ListaPessoas(),
        // body: PessoaListTile(
        //   pessoa: Pessoa(
        //     id:1,
        //     nome:"Max",
        //     altura:180,
        //     peso:79
        //   )
        // ),
      // ),
    //);
  //}
//}