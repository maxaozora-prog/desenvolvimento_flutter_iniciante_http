import 'package:desenvolvimento_flutter_iniciante/mock/gerar_pessoas.dart';
import 'package:desenvolvimento_flutter_iniciante/models/pessoa.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/custom_person_tile.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/pessoa_listtile.dart';

import 'package:flutter/material.dart';

class ListaPessoas extends StatelessWidget {
  //const ListaPessoas({super.key});
   final List<Pessoa> pessoas;//Aula da lista. Para deletar uma lista.
  //final void Function(Pessoa pessoa) onDeletePessoa;
  const ListaPessoas({
    super.key,
    required this.pessoas,
    //required this.onDeletePessoa,//Aula da lista. Para deletar uma lista.
  });

  @override
  Widget build(BuildContext context) {
    //final pessoas = gerarPessoas(20);
     if (pessoas.isEmpty) {//Aula da lista. Para cadastrar uma lista.
      return Center(
        child: Text(
          "Nenhuma pessoa cadastrada",
          style: TextStyle(fontSize: 20),//Aula da lista. Para cadastrar uma lista.
        ),
      );
    }

    return ListView.builder(
      itemCount: pessoas.length,
      itemBuilder: (context, index) {
        // return PessoaListTile(pessoa: pessoas[index]);
        //return CustomPersonTile(pessoa: pessoas[index]);
        
        return CustomPersonTile(//Aula da lista. Para deletar uma lista.
          pessoa: pessoas[index],
          //onDeletePessoa: onDeletePessoa,//Aula da lista. Para deletar uma lista.
        );
      },
    );
  }
}