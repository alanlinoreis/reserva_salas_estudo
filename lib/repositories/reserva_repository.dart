import '../mocks/reservas_mock.dart';
import '../models/reserva.dart';
import '../utils/periodo.dart';

/// Repositório em memória responsável por todas as operações
/// de CRUD sobre reservas.
///
/// Implementado como singleton: existe uma única instância acessível
/// via `ReservaRepository.instance`. Toda a UI conversa com esse
/// objeto, nunca com a lista interna diretamente.
class ReservaRepository {
  // Construtor privado: impede que outras partes do código
  // criem novas instâncias com `ReservaRepository()`.
  ReservaRepository._internal() {
    // Inicializa a lista interna com cópias dos mocks.
    // Usamos List.from para que alterações no repositório
    // não afetem a lista original em reservas_mock.dart.
    _reservas = List<Reserva>.from(reservasMock);
  }

  /// Instância única do repositório.
  static final ReservaRepository instance = ReservaRepository._internal();

  late final List<Reserva> _reservas;

  /// Retorna uma cópia imutável da lista de reservas.
  ///
  /// É uma cópia para que a UI não consiga modificar a lista
  /// interna do repositório por engano.
  List<Reserva> listar() => List.unmodifiable(_reservas);

  /// Adiciona uma nova reserva e retorna o objeto criado.
  ///
  /// O ID é gerado automaticamente a partir do timestamp atual,
  /// garantindo unicidade sem precisar de bibliotecas externas.
  Reserva adicionar({
    required String nomeEstudante,
    required String sala,
    required int quantidadeParticipantes,
    required Periodo periodo,
    required bool precisaMultimidia,
  }) {
    final nova = Reserva(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nomeEstudante: nomeEstudante,
      sala: sala,
      quantidadeParticipantes: quantidadeParticipantes,
      periodo: periodo,
      precisaMultimidia: precisaMultimidia,
    );
    _reservas.add(nova);
    return nova;
  }

  /// Atualiza uma reserva existente, identificada pelo `id`.
  ///
  /// Retorna `true` se a reserva foi encontrada e atualizada;
  /// `false` caso contrário (não deve acontecer em uso normal).
  bool atualizar(Reserva reservaAtualizada) {
    final index = _reservas.indexWhere((r) => r.id == reservaAtualizada.id);
    if (index == -1) return false;
    _reservas[index] = reservaAtualizada;
    return true;
  }

  /// Remove uma reserva pelo `id`.
  ///
  /// Retorna `true` se removeu, `false` se não encontrou.
  bool remover(String id) {
    final tamanhoAnterior = _reservas.length;
    _reservas.removeWhere((r) => r.id == id);
    return _reservas.length < tamanhoAnterior;
  }

  /// Busca e filtra reservas conforme os critérios fornecidos.
  ///
  /// - [texto]: busca por nome do estudante OU sala (case-insensitive).
  /// - [periodo]: se informado, retorna apenas reservas desse período.
  /// - [apenasComMultimidia]: se `true`, retorna apenas reservas que
  ///   precisam de equipamento multimídia. Se `null`, ignora o filtro.
  ///
  /// Todos os critérios são combinados com AND.
  List<Reserva> buscarEFiltrar({
    String texto = '',
    Periodo? periodo,
    bool? apenasComMultimidia,
  }) {
    final textoNormalizado = texto.trim().toLowerCase();

    return _reservas.where((r) {
      // Filtro de texto: nome do estudante OU sala
      final correspondeTexto = textoNormalizado.isEmpty ||
          r.nomeEstudante.toLowerCase().contains(textoNormalizado) ||
          r.sala.toLowerCase().contains(textoNormalizado);

      // Filtro de período
      final correspondePeriodo = periodo == null || r.periodo == periodo;

      // Filtro de multimídia
      final correspondeMultimidia = apenasComMultimidia == null ||
          r.precisaMultimidia == apenasComMultimidia;

      return correspondeTexto && correspondePeriodo && correspondeMultimidia;
    }).toList();
  }
}