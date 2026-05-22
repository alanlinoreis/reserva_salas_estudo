import 'package:flutter/material.dart';

/// Widget exibido quando uma busca/filtro não retorna resultados,
/// ou quando ainda não existe nenhuma reserva cadastrada.
///
/// Atende ao requisito 14 do enunciado.
class EstadoVazio extends StatelessWidget {
  final String mensagem;

  const EstadoVazio({
    super.key,
    this.mensagem = 'Nenhuma reserva encontrada.',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 72,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            mensagem,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}