
import 'package:desenvolvimento_flutter_iniciante/models/criar_pessoa_dto.dart';
import 'package:desenvolvimento_flutter_iniciante/models/pessoa.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio();

  Future<List<Pessoa>> get() async {
    final request = await dio.get("http://localhost:3000/pessoas"); // não funciona o localhost, tem que ser o ip da maquina mais a rota da api.

    if (request.statusCode == 200) {
      final data = request.data;

      
      final pessoasJson = data as List; //Primeiro é uma lista e dentro da lista tem um map.

      // return pessoasJson
      //     .map((pessoaJson) => Pessoa(
      //       id: pessoaJson["id"],
      //       nome: pessoaJson["nome"],
      //       altura: pessoaJson["altura"],
      //       peso: pessoaJson["peso"]
      //     ),
      //     ).toList();

      return pessoasJson
          .map((pessoaJson) => Pessoa.fromJson(pessoaJson)) //fromjson está no model pessoa.dart. É um factory. Pessoa é uma classe do arquivo pessoa.dart.
          .toList();
    }

    throw Exception("Status Code inválido");
  }

  Future<Pessoa> post(CriarPessoaDto criarPessoa) async {
    final request = await dio.post(
      "http://localhost:3000/pessoas",
      data: criarPessoa.toJson(), //Criar pessoa é um objeto de CriarPessoaDto do criar_pessoa_dto.dart.
    );

    if (request.statusCode == 201) {
      return Pessoa.fromJson(request.data);
    }

    throw Exception("Status code inválido");//Menssagem se der erro.
  }


  Future<void> delete(Pessoa pessoa) async{
  final request= await dio.delete("http://localhost:3000/pessoas/${pessoa.id}");
  if (request.statusCode !=200) {
    throw Exception("Status code inválido");

  }
 }

 Future<Pessoa> put(Pessoa pessoa) async {
    final request = await dio.put(
      "http://localhost:3000/pessoas/${pessoa.id}",
      data: pessoa.toJson(),
    );
    if (request.statusCode == 200) {
      return Pessoa.fromJson(request.data);
    }
    throw Exception("Status code invalido");
  }
}
 
 