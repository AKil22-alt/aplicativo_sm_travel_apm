import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrinho.dart';

class Destino extends StatefulWidget {
  final String nome;
  final String img;
  final int valord;
  final int valorp;

  const Destino(this.nome, this.img, this.valord, this.valorp, {super.key});

  @override
  State<Destino> createState() => _DestinoState();
}

class _DestinoState extends State<Destino> {
  int nDiarias = 0;
  int nPessoas = 0;
  int total = 0;

  // B1 - incrementa o número de diárias
  void dias() {
    setState(() {
      nDiarias++;
    });
  }

  // B2 - incrementa o número de acompanhantes
  void pessoas() {
    setState(() {
      nPessoas++;
    });
  }

  // B3 - calcula o total usando o Provider (carrinho de compras)
  void calctotal() {
    final resultado = context.read<Carrinho>().calctotal(
      nome: widget.nome,
      nDiarias: nDiarias,
      valord: widget.valord,
      nPessoas: nPessoas,
      valorp: widget.valorp,
    );
    setState(() {
      total = resultado;
    });
  }

  // B4 - zera todos os campos calculados
  void limpar() {
    context.read<Carrinho>().remover(widget.nome);
    setState(() {
      nDiarias = 0;
      nPessoas = 0;
      total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.grey,
            width: 393,
            height: 250,
            child: Image.asset(
              widget.img,
              fit: BoxFit.fill,
              errorBuilder: (_, _, _) => const Center(
                child: Icon(Icons.image_not_supported, size: 48),
              ),
            ),
          ),
          Text(widget.nome, style: const TextStyle(fontSize: 30)),
          Text(
            'R\$ ${widget.valord}/dia - R\$ ${widget.valorp} /pessoa',
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
          const Text(
            '1 Quarto, banheiro, televisão, WiFi, ar-condicionado',
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantidade de dias: $nDiarias',
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(onPressed: dias, child: const Icon(Icons.add)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantidade de pessoas: $nPessoas',
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(onPressed: pessoas, child: const Icon(Icons.add)),
            ],
          ),
          Text('Valor total R\$: $total', style: const TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: calctotal,
                child: const Text('Calcular'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(onPressed: limpar, child: const Text('Limpar')),
            ],
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }
}
