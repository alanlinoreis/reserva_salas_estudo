import '../utils/periodo.dart';

/// Representa uma reserva de sala de estudo.
///
/// É a entidade principal da aplicação. Cada instância equivale a
/// um registro exibido na lista da tela inicial.
class Reserva {
  final String id;
  String nomeEstudante;
  String sala;
  int quantidadeParticipantes;
  Periodo periodo;
  bool precisaMultimidia;

  Reserva({
    required this.id,
    required this.nomeEstudante,
    required this.sala,
    required this.quantidadeParticipantes,
    required this.periodo,
    required this.precisaMultimidia,
  });

  /// Retorna uma cópia da reserva com os campos sobrescritos
  /// que forem passados. Útil para edição sem mutar o original
  /// até confirmarmos o salvamento.
  Reserva copyWith({
    String? nomeEstudante,
    String? sala,
    int? quantidadeParticipantes,
    Periodo? periodo,
    bool? precisaMultimidia,
  }) {
    return Reserva(
      id: id,
      nomeEstudante: nomeEstudante ?? this.nomeEstudante,
      sala: sala ?? this.sala,
      quantidadeParticipantes:
          quantidadeParticipantes ?? this.quantidadeParticipantes,
      periodo: periodo ?? this.periodo,
      precisaMultimidia: precisaMultimidia ?? this.precisaMultimidia,
    );
  }
}