import 'package:flutter/material.dart';
import '../models/reserva.dart';

/// Card que representa visualmente uma reserva na listagem.
///
/// Recebe callbacks para edição e remoção, mantendo a lógica
/// de navegação e diálogo fora deste componente (separação
/// entre apresentação e comportamento).
class ReservaCard extends StatelessWidget {
  final Reserva reserva;
  final VoidCallback onEditar;
  final VoidCallback onRemover;

  const ReservaCard({
    super.key,
    required this.reserva,
    required this.onEditar,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Linha 1: nome do estudante + ações
            Row(
              children: [
                Expanded(
                  child: Text(
                    reserva.nomeEstudante,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  tooltip: 'Editar',
                  onPressed: onEditar,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Remover',
                  onPressed: onRemover,
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Linha 2: sala
            Row(
              children: [
                const Icon(Icons.meeting_room, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(reserva.sala),
              ],
            ),
            const SizedBox(height: 4),
            // Linha 3: participantes e período
            Row(
              children: [
                const Icon(Icons.people, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text('${reserva.quantidadeParticipantes} participante(s)'),
                const SizedBox(width: 16),
                const Icon(Icons.schedule, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(reserva.periodo.label),
              ],
            ),
            const SizedBox(height: 6),
            // Linha 4: chip de multimídia
            if (reserva.precisaMultimidia)
              const Chip(
                label: Text('Multimídia'),
                avatar: Icon(Icons.tv, size: 16),
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
      ),
    );
  }
}