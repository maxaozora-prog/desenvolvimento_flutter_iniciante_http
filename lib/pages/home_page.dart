import 'package:desenvolvimento_flutter_iniciante/controller/pessoa_controller.dart';
import 'package:desenvolvimento_flutter_iniciante/controller/theme_controller.dart';
import 'package:desenvolvimento_flutter_iniciante/extensions/extensions.dart';
import 'package:desenvolvimento_flutter_iniciante/models/criar_pessoa_dto.dart';
import 'package:desenvolvimento_flutter_iniciante/models/pessoa.dart';
import 'package:desenvolvimento_flutter_iniciante/pages/criar_pessoa_page.dart';
import 'package:desenvolvimento_flutter_iniciante/routes/routes.dart';
import 'package:desenvolvimento_flutter_iniciante/states/messages_states.dart';
import 'package:desenvolvimento_flutter_iniciante/widgets/lista_pessoas.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

@override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  
  //List<Pessoa> pessoas = [];//Aula da lista. Para cadastrar uma lista.
  //final PessoaController pessoaController = PessoaController(); //Substituido o codigo de cima pelo controlador. Em pessoa_controller.dart.
    final pessoaController = GetIt.instance<PessoaController>();//Injeção de dependencia.
    final ThemeController themeController = GetIt.instance<ThemeController>();
  @override
  void initState() {//Injeção de dependencia.
  pessoaController.listarPessoas();//Requisição http
   themeController.mensagemNotifier.addListener(_onThemeMensagem);//ValueNotifier.
   pessoaController.mensagemNotifier.addListener(_onPessoaMensagem);//ValueNotifier.
    pessoaController.addListener(() {
      setState(() {});
    });
    super.initState();//Injeção de dependencia.
  }
  
  void _onPessoaMensagem() {//ValueNotifier.
    print(pessoaController.mensagemNotifier.value);

    //Snackbar.
    //  ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.green,
    //     content: Text(pessoaController.mensagemNotifier.value),
    //   ),
    // );
    final value = pessoaController.mensagemNotifier.value;

    if (value is SuccessMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(value.message),
        ),
      );
    } else if (value is ErrorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(value.message),
        ),
      );
    }
  }

  void _onThemeMensagem() {//ValueNotifier.
    print(themeController.mensagemNotifier.value);

    //Snackbar.
    //  ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.green,
    //     content: Text(themeController.mensagemNotifier.value),
    //   ),
    // );
        final value = themeController.mensagemNotifier.value;
    if (value is SuccessMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(value.message),
        ),
      );
    } else if (value is ErrorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(value.message),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: themeController.darkTheme,
              onChanged: (value) {
                themeController.toggleTheme(value);
              },
            ),
            Text("Tema escuro")
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Meu primeiro App."),
      ),
         body: ListenableBuilder(//Para ourvir as mudanças.Injeção de dependencia. Ele apaga os valores da memoria automaticamente.
        listenable: pessoaController,
        builder: (context, child) {
              if (pessoaController.loading) {//Carregamento
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListaPessoas(
            pessoas: pessoaController.pessoas,
          );
        },
      //body: ListaPessoas( //Aula da lista. Para cadastrar uma lista.
        //pessoas: pessoas,
        //pessoas: pessoaController.pessoas,//Substituido o codigo de cima pelo controlador. Em pessoa_controller.
        // onDeletePessoa: (pessoa) {
        //   //pessoas.remove(pessoa);
        //   pessoaController.removerPessoa(pessoa);//Substituido o codigo de cima pelo controlador. Em pessoa_controller.
        //   setState(() {});//Aula da lista. Para cadastrar uma lista.
        // },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
         onPressed: () {
          Navigator.of(context).pushNamed(Routes.criarPessoaPage);},
        //  onPressed: () async {//Aula da lista. Para cadastrar uma lista.
        //   final result =
        //       await Navigator.of(context).pushNamed(Routes.criarPessoaPage);

        //   if (result != null) {
        //     // final pessoaDto = result as CriarPessoaDto;

        //     // final pessoa = Pessoa(
        //     //   id: pessoas.length + 1,
        //     //   nome: pessoaDto.nome,
        //     //   altura: pessoaDto.altura,
        //     //   peso: pessoaDto.peso,
        //     // );

        //     // pessoas.add(pessoa);
        //     // setState(() {});
        //      final pessoaDto = result as CriarPessoaDto;//Substituido o codigo de cima pelo controlador. Em pessoa_controller.
        //     pessoaController.adicionarPessoa(pessoaDto);
        //     setState(() {});
        //   }

        //   print("resultado: $result");//Aula da lista. Para cadastrar uma lista.
        //   // context.pushNamed(Routes.criarPessoaPage);
        //   //Navigator.pushNamed(context, Routes.novaPagina); //As 3 linhas são a mesma coisa.
        //   // Navigator.of(context).pushNamed(Routes.novaPagina);
        //   //context.pushNamed(Routes.criarPessoaPage); //Pega a rota do router.dart. Essa linha de codigo foi diminuida por causa do extension criado em extensions.dart.

        //   // Navigator.of(context).pushAndRemoveUntil( //O pushAndRemoveUntil remove a rota de navegação, não deixa pilha, não tem como dar um navigator.pop e voltar nele.
        //   //   MaterialPageRoute(
        //   //     builder: (context) {
        //   //       return NovaPagina();
        //   //     },
        //   //   ),
        //   //   (route) => false,
        //   // );
        // },
        child: Icon(Icons.navigate_next),
      ),
    );
  }

  void dispose() {
    super.dispose();
      pessoaController.mensagemNotifier.removeListener(_onPessoaMensagem);//ValueNotifier.
    themeController.mensagemNotifier.removeListener(_onThemeMensagem);//ValueNotifier.
  }
}