import 'package:desenvolvimento_flutter_iniciante/models/criar_pessoa_dto.dart';
import 'package:desenvolvimento_flutter_iniciante/models/pessoa.dart';
import 'package:desenvolvimento_flutter_iniciante/services/api_client.dart';
import 'package:desenvolvimento_flutter_iniciante/states/messages_states.dart';
import 'package:flutter/material.dart';

class PessoaController extends ChangeNotifier{ //ChangeNotifier para injeção de dependencia
  List<Pessoa> _pessoas = [];
  List<Pessoa> get pessoas => _pessoas;
 // ValueNotifier<String> mensagemNotifier = ValueNotifier("");
  ValueNotifier<MessagesStates> mensagemNotifier =ValueNotifier(IddleMessage()); //substitui o codigo de cima.

// final apiClient = ApiClient();//Requisição http
final ApiClient apiClient;// Ajustando injeção de dependencia.
PessoaController({required this.apiClient});// Ajustando injeção de dependencia.

//Requisição http para listar pessoas.
bool _loading = false;
  bool get loading => _loading;
  void listarPessoas() async {
    _loading = true;
    notifyListeners();
    try {
      // await Future.delayed(Duration(seconds:1)); //Foi criado só para demorar a requisição e mostrar o circulo de carregamento. O circulo foi implementado em home_page.dart.
      final pessoas = await apiClient.get();
      _pessoas = pessoas;
    } on Exception catch (error) {
      //TODO: tratamento da excessão
      mensagemNotifier.value =//Foi introduzido na aula de ajuste de injeção de dependencia
          ErrorMessage(message: "ocorreu um erro ao buscar pessoas.");
      print("error: $error");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> adicionarPessoa(CriarPessoaDto criarPessoa) async {//CriarPessoaDto vem do criar_pessoa_dto.dart.
    // final pessoa = Pessoa(
    //   id: _pessoas.length + 1,
    //   nome: criarPessoa.nome,
    //   altura: criarPessoa.altura,
    //   peso: criarPessoa.peso,
    // );

    // _pessoas.add(pessoa);
    //  mensagemNotifier.value = "Pessoa adicionada com sucesso."; //ValueNotifier.
    // notifyListeners(); //Notifica os ouvintes que ouve uma mudança. Para atualizar a tela.

     try {
      // final pessoa = Pessoa(
      //   id: (_pessoas.length + 1).toString(),
      //   nome: criarPessoa.nome,
      //   altura: criarPessoa.altura,
      //   peso: criarPessoa.peso,
      // );

      //O objeto do parametro criarPessoa é o dado onde o usuário digita.
      final pessoa = await apiClient.post(criarPessoa); //Vai adicionar no servidor

           _pessoas.add(pessoa); //Vai adicionar na lista.
      mensagemNotifier.value =
          SuccessMessage(message: "Pessoa adicionada com sucesso.");
      notifyListeners();
    // } on Exception catch (error) {
     } on Exception catch (_) {//Foi adeirido na aula de ajuste de injeção de dependencia. error foi substituido porquenão está em uso.
      mensagemNotifier.value =
          ErrorMessage(message: "Ocorreu um erro ao adicionar pessoa");
    }
  }

  // void removerPessoa(Pessoa pessoa) {
  //   _pessoas.remove(pessoa);
  //   //mensagemNotifier.value = "Pessoa removida com sucesso."; //ValueNotifier.
  //    mensagemNotifier.value =
  //       SuccessMessage(message: "Pessoa removida com sucesso.");
  //    notifyListeners(); //Injeção de dependencia. Notifica os ouvintes que ouve uma mudança. Para atualizar a tela.
  // }
   Future<void> removerPessoa(Pessoa pessoa) async {
    try {
      await apiClient.delete(pessoa);
      _pessoas.remove(pessoa);
      mensagemNotifier.value =
          SuccessMessage(message: "Pessoa removida com sucesso.");
    // } on Exception catch (error) {
       } on Exception catch (_) {//Foi adeirido na aula de ajuste de injeção de dependencia. error foi substituido porquenão está em uso.
    } finally {
      notifyListeners();
    }
   }

   Future<void> atualizarPessoa(Pessoa criarPessoa) async {
    try {
      final pessoa = await apiClient.put(criarPessoa);

      final pessoaIndex = _pessoas.indexWhere((e) => e.id == pessoa.id);

      _pessoas[pessoaIndex] = pessoa;

      mensagemNotifier.value =
          SuccessMessage(message: "Pessoa atualizada com sucesso.");
    // } on Exception catch (error) {
       } on Exception catch (_) {//Foi adeirido na aula de ajuste de injeção de dependencia. error foi substituido porquenão está em uso.
      mensagemNotifier.value =
          ErrorMessage(message: "Ocorreu um erro ao atualizar pessoa");
    } finally {
      notifyListeners();
    }
  }
}