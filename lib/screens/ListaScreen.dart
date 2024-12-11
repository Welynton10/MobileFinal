import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conectar_api/controllers/PedidoController.dart';

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  var controller = PedidoController.pedidoController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.listarPedidos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar de Pedidos'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Obx(() {

          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.pedido.isEmpty) {
            return Center(child: Text('Nenhum pedido encontrado.'));
          } else {
            return ListView.builder(
              itemCount: controller.pedido.length,
              itemBuilder: (context, index) {
                var pedido = controller.pedido[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  child: ListTile(
                    title: Text(pedido.descricao),
                    subtitle: Text('Valor: R\$ ${pedido.valor.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
