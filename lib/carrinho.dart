import 'package:flutter/foundation.dart';

class ItemCarrinho {
  final String nome;
  final int dias;
  final int pessoas;
  final int total;

  ItemCarrinho({
    required this.nome,
    required this.dias,
    required this.pessoas,
    required this.total,
  });
}

/// Carrinho de compras (Provider) que guarda as viagens calculadas.
class Carrinho extends ChangeNotifier {
  final Map<String, ItemCarrinho> _itens = {};

  List<ItemCarrinho> get itens => _itens.values.toList();

  int get total => _itens.values.fold(0, (soma, i) => soma + i.total);

  /// Função calctotal: Total = (n_diarias * valord) + (n_pessoas * valorp)
  int calctotal({
    required String nome,
    required int nDiarias,
    required int valord,
    required int nPessoas,
    required int valorp,
  }) {
    final int totalViagem = (nDiarias * valord) + (nPessoas * valorp);
    if (totalViagem > 0) {
      _itens[nome] = ItemCarrinho(
        nome: nome,
        dias: nDiarias,
        pessoas: nPessoas,
        total: totalViagem,
      );
    } else {
      _itens.remove(nome);
    }
    notifyListeners();
    return totalViagem;
  }

  void remover(String nome) {
    _itens.remove(nome);
    notifyListeners();
  }

  void limpar() {
    _itens.clear();
    notifyListeners();
  }
}
