import 'package:desenvolvimento_flutter_iniciante/models/pessoa.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/custom_tile.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/pessoa_dialog.dart';
import 'package:flutter/material.dart';

class CustomPersonTile extends StatelessWidget {
  //final void Function(Pessoa pessoa) onDeletePessoa; //Aula da lista. Para deletar uma lista. Somente essa linha
  final Pessoa pessoa;
  const CustomPersonTile({
    super.key,
    required this.pessoa,
     // required this.onDeletePessoa,//Aula da lista. Para deletar uma lista. Somente essa linha
  });

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      onTap: () { //Função onTap criado no arquiv custom_tile.dart
        showDialog(
          barrierDismissible: false,// Para quando clicar fora do dialog(modal) ele não fechar.Por padrão ele vem true.
          context: context,
          builder: (context) {
            return PessoaDialog( //Está no arquivo pessoa_dialog.dart
              pessoa: pessoa,
               //onDeletePessoa: onDeletePessoa, //Aula da lista. Para deletar uma lista. Somente essa linha
            );
          },
        );
      },
      // color: Colors.lightBlue,
      color: Theme.of(context).primaryColor,
      leading: Text("Id: ${pessoa.id}"),
      title: Text(
        pessoa.nome,
        style: TextStyle(fontSize: 20),
      ),
      subTitle: Text("Peso: ${pessoa.peso.toStringAsFixed(1)} Kg"),
      trailing: Text("Altura: ${pessoa.altura} cm"),
    );
  }
}