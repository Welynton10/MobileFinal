class PedidoModel {
  final String id;
  late final String descricao;
  double valor;
  String clienteId;

  PedidoModel({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.clienteId,

  });

  PedidoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        descricao = json['descricao'] ?? '',
        valor = (json['valor'] is num) ? json['valor'].toDouble() : 0.0,
        clienteId = json['clienteId'] ?? '';

  Map<String, dynamic> toJson() => {
    'id': id,
    'descricao': descricao,
    'valor': valor,
    'clienteId': clienteId,
  };
}
