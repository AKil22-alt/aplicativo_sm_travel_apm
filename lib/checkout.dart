import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrinho.dart';

enum FormaPagamento { pix, cartao, boleto }

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  FormaPagamento _forma = FormaPagamento.pix;

  @override
  Widget build(BuildContext context) {
    final carrinho = context.watch<Carrinho>();
    final int subtotal = carrinho.total;
    final bool pix = _forma == FormaPagamento.pix;
    final double desconto = pix ? subtotal * 0.10 : 0;
    final double totalFinal = subtotal - desconto;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: carrinho.itens.isEmpty
          ? const Center(child: Text('Seu carrinho está vazio'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      const Text(
                        'Resumo da viagem',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...carrinho.itens.map(
                        (i) => Card(
                          child: ListTile(
                            title: Text(i.nome),
                            subtitle: Text(
                              '${i.dias} diária(s) • ${i.pessoas} pessoa(s)',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('R\$ ${i.total}'),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => carrinho.remover(i.nome),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Forma de pagamento',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RadioGroup<FormaPagamento>(
                        groupValue: _forma,
                        onChanged: (v) =>
                            setState(() => _forma = v ?? FormaPagamento.pix),
                        child: const Column(
                          children: [
                            RadioListTile<FormaPagamento>(
                              title: Text('Pix (10% de desconto)'),
                              value: FormaPagamento.pix,
                            ),
                            RadioListTile<FormaPagamento>(
                              title: Text('Cartão de crédito'),
                              value: FormaPagamento.cartao,
                            ),
                            RadioListTile<FormaPagamento>(
                              title: Text('Boleto'),
                              value: FormaPagamento.boleto,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 6, color: Colors.black26),
                    ],
                  ),
                  child: Column(
                    children: [
                      _linha('Subtotal', 'R\$ ${subtotal.toStringAsFixed(2)}'),
                      if (pix)
                        _linha(
                          'Desconto Pix (10%)',
                          '- R\$ ${desconto.toStringAsFixed(2)}',
                          cor: Colors.green,
                        ),
                      const Divider(),
                      _linha(
                        'Total',
                        'R\$ ${totalFinal.toStringAsFixed(2)}',
                        negrito: true,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Pedido confirmado!'),
                                content: Text(
                                  'Total pago: R\$ ${totalFinal.toStringAsFixed(2)}',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      carrinho.limpar();
                                      Navigator.of(context)
                                        ..pop()
                                        ..pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text('Finalizar compra'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _linha(
    String rotulo,
    String valor, {
    Color? cor,
    bool negrito = false,
  }) {
    final estilo = TextStyle(
      fontSize: 16,
      color: cor,
      fontWeight: negrito ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rotulo, style: estilo),
          Text(valor, style: estilo),
        ],
      ),
    );
  }
}
