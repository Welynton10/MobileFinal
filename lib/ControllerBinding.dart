import 'package:conectar_api/controllers/ClienteController.dart';
import 'package:conectar_api/controllers/PedidoController.dart';
import 'package:get/get.dart';

class ControllerBinding implements Bindings{
  @override
  void dependencies() {
      Get.lazyPut<PedidoController>(() => PedidoController());
      Get.lazyPut<ClienteController>(() => ClienteController());
  }

}