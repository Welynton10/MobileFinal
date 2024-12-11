
import 'package:conectar_api/screens/CadastroClienteScreen.dart';
import 'package:conectar_api/screens/CadastroPedidoScreen.dart';
import 'package:conectar_api/screens/ListaScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MenuComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Cadastrar Pedido'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      CadastroPedidoScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Listar Pedidos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ListaScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Cadastrar Cliente'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      CadastroClienteScreen()),
                );
              },
            ),
          ],
        ),
      );
  }
}