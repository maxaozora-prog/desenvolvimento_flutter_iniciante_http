import 'package:desenvolvimento_flutter_iniciante/models/pessoa.dart';
import 'package:desenvolvimento_flutter_iniciante/pages/home_page.dart';
import 'package:desenvolvimento_flutter_iniciante/pages/criar_pessoa_page.dart';
import 'package:desenvolvimento_flutter_iniciante/routes/routes.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Routes.initialRoute: (BuildContext context) => HomePage(), //È do arquivo home_page.dart
  //Routes.criarPessoaPage: (BuildContext context) => CriarPessoaPage(), //É do arquivo nova_pagina.dart

   Routes.criarPessoaPage: (BuildContext context) {//Http put
    final params =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final pessoa = params?["pessoa"] as Pessoa?;
    return CriarPessoaPage(
      pessoa: pessoa,
    );
  },
};