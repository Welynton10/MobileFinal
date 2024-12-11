import 'dart:convert';
import 'package:conectar_api/models/PedidoModel.dart';
import 'package:http/http.dart' as http;

class PedidoService {
  dynamic _response;

  String url = "http://localhost:8080/pedidos/salvar";

  Future<dynamic> salvaProduto(PedidoModel pedido) async {
    _response = await http.post(Uri.parse(url),
        body: json.encode(pedido.toJson()),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    if (_response.statusCode == 200 || _response.statusCode == 201) {
      return PedidoModel.fromJson(json.decode(_response.body));
    } else {
      return false;
    }
  }

  Future<List<PedidoModel>> listarPedidos() async {
    try {
      _response = await http.get(
        Uri.parse("http://localhost:8080/clientes/listar"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );

      if (_response.statusCode == 200) {
        List<dynamic> jsonListClientes = json.decode(utf8.decode(_response.bodyBytes));

        List<PedidoModel> pedidos = [];
        for (var cliente in jsonListClientes) {
          if (cliente['pedidos'] != null) {
            for (var pedido in cliente['pedidos']) {
              pedidos.add(PedidoModel.fromJson(pedido));
            }
          }
        }
        return pedidos;
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao listar pedidos: $e');
      return [];
    }
  }

  Future<dynamic> editarPedido(String id, PedidoModel pedido) async {
    final url = "http://localhost:8080/pedidos/editar/$id";

    _response = await http.put(Uri.parse(url),
        body: json.encode(pedido.toJson()),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    if (_response.statusCode == 200) {
      return PedidoModel.fromJson(json.decode(_response.body));
    } else {
      return false;
    }
  }

  Future<bool> deletarPedido(String id) async {
    final url = "http://localhost:8080/pedidos/deletar/$id";

    _response = await http.delete(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    if (_response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
