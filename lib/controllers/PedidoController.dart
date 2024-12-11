import 'dart:convert';

import 'package:get/get.dart';
import '../models/PedidoModel.dart';
import '../services/PedidoService.dart';
import 'ClienteController.dart';

class PedidoController extends GetxController {
  PedidoService _pedidoService = PedidoService();

  var isLoading = false.obs;
  var pedido = <PedidoModel>[].obs;

  static PedidoController get pedidoController => Get.find();

  get http => null;


  Future<void> listarPedidos() async {
    isLoading.value = true;
    try {
      var lista = await _pedidoService.listarPedidos();
      if (lista.isNotEmpty) {
        pedido.assignAll(lista);
      } else {
        pedido.clear();
      }
    } catch (e) {
      pedido.clear();
      print('Erro ao listar pedidos: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<bool> salvar(PedidoModel pedidoModel) async {
    isLoading.value = true;
    try {
      var resposta = await _pedidoService.salvaProduto(pedidoModel);
      if (resposta != null) {
        pedido.add(resposta);
        return true;
      }
      return false;
    } catch (e) {
      print('Erro ao salvar pedido: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }


  String? obterNomeCliente(String clienteId) {
    final clienteController = ClienteController.clienteController;
    final cliente = clienteController.obterClientePorId(clienteId);
    return cliente?.nome;
  }

  Future<void> atualizarPedido(PedidoModel pedido) async {
    isLoading.value = true;
    var url = "http://localhost:8080/pedidos/editar/${pedido.id}";
    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(pedido.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        listarPedidos();
      } else {
        print('Erro ao editar pedido');
      }
    } catch (e) {
      print('Erro ao editar pedido: $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<bool> deletarPedido(String id) async {
    isLoading.value = true;
    try {
      var resposta = await _pedidoService.deletarPedido(id);
      if (resposta) {
        pedido.removeWhere((pedido) => pedido.id == id);
        return true;
      }
      return false;
    } catch (e) {
      print('Erro ao deletar pedido: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
