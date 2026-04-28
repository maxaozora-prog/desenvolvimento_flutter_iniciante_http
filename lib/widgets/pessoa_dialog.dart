import 'package:desenvolvimento_flutter_iniciante/controller/pessoa_controller.dart';
import 'package:desenvolvimento_flutter_iniciante/extensions/extensions.dart';
import 'package:desenvolvimento_flutter_iniciante/models/pessoa.dart';
import 'package:desenvolvimento_flutter_iniciante/routes/routes.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/default_dialog_container.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PessoaDialog extends StatelessWidget {
   //final void Function(Pessoa pessoa) onDeletePessoa;//Aula da lista. Para deletar uma lista.Somente essa linha
  final Pessoa pessoa;
  const PessoaDialog({
    super.key,
    required this.pessoa,
    //required this.onDeletePessoa,//Aula da lista. Para deletar uma lista. Somente essa linha.
  });

  @override
  Widget build(BuildContext context) {
    final pessoaController = GetIt.instance<PessoaController>();//injeção de dependencia.
    return AlertDialog(
       
      actions: [//Ao inves de colocar no final o actions permite que coloque no topo mas que os itens ficam no final.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              //style:
                 // ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                 
              onPressed: () async{
                //onDeletePessoa(pessoa); //Aula da lista. Para deletar uma lista. Somente essa linha.
                await pessoaController.removerPessoa(pessoa); //Injeção de dependencia. Substitui o codigo de cima.
                //Navigator.of(context).pop();
                if (context.mounted) Navigator.of(context).pop(); //Delete do http.Verifica se o contexto ainda está montado antes de tentar fechar o diálogo. Isso é importante para evitar erros caso o usuário tenha fechado a tela ou navegado para outra página antes da conclusão da operação de exclusão.
              },
              child: Text(
                //"Visualizar",
                  "Excluir", //Aula da lista. Para deletar uma lista. Somente essa linha.
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
               ElevatedButton(//Http put
              // style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                Navigator.of(context).pushNamed(
                  Routes.criarPessoaPage,
                  arguments: {
                    "pessoa": pessoa,
                  },
                );
                // await pessoaController.removerPessoa(pessoa);
                // if (context.mounted) Navigator.of(context).pop();
              },
              child: Text(
                "Editar",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Fechar",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
      content: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Informações do usuário"),
             Text(
              "Informações do usuário",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 8),
            DefaultDialogContainer(//Provem do default_dialog_container.dart
              child: Text("Id: ${pessoa.id}"),
            ),
            DefaultDialogContainer(
              child: Text("Nome: ${pessoa.nome}"),
            ),
            DefaultDialogContainer(
              child: Text("Peso: ${pessoa.peso.paraPeso()}"),//Atributo criado em extensions.dart
            ),
            DefaultDialogContainer(
              child: Text("altura: ${pessoa.altura.paraAltura()}"),
            ),
          ],
        ),
      ),
    );
  }
}