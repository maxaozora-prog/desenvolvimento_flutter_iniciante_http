import 'package:desenvolvimento_flutter_iniciante/states/messages_states.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  bool darkTheme = false;

  ThemeController({//Construtor da classe com o sharedPreferences.
    required this.sharedPreferences,
  });

  //ValueNotifier<String> mensagemNotifier = ValueNotifier("");
   ValueNotifier<MessagesStates> mensagemNotifier =ValueNotifier(IddleMessage());//Substitui o codigo de cima.

  void toggleTheme(bool value) async {
    // darkTheme = !darkTheme;
    // await sharedPreferences.setBool("theme", darkTheme);//Vai salvar o valor boleano. No caso vai salvar o darktheme com o nome da chave theme.
    //  mensagemNotifier.value = //ValueNotifier.
    //     "Tema mudado para ${darkTheme ? 'escuro' : 'claro'}."; 
    // notifyListeners();

     try {
      darkTheme = !darkTheme;
      await sharedPreferences.setBool("theme", darkTheme);
      // mensagemNotifier.value =
      //     "Tema mudado para ${darkTheme ? 'escuro' : 'claro'}.";
      mensagemNotifier.value = SuccessMessage(
          message: "Tema mudado para ${darkTheme ? 'escuro' : 'claro'}.");
      notifyListeners();
    } on Exception catch (error) {
      //mensagemNotifier.value = error.toString();
      mensagemNotifier.value = ErrorMessage(message: error.toString());
  }
  }

  Future<void> getTheme() async {//Algoritimo para buscar o valor do tema salvo no sharedPreferences.
    final theme = sharedPreferences.getBool("theme");//Buscando por theme

    if (theme != null) {
      darkTheme = theme;
      notifyListeners();
    }
  }
}