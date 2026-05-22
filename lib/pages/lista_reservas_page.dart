import 'package:flutter/material.dart';
import '../components/estado_vazio.dart';
import '../components/reserva_card.dart';
import '../models/reserva.dart';
import '../repositories/reserva_repository.dart';
import '../utils/periodo.dart';
import 'formulario_reserva_page.dart';

/// Tela inicial da aplicação.
///
/// Exibe a lista de reservas, com campo de busca, dois filtros
/// (período e multimídia), botões para adicionar, editar e remover.
class ListaReservasPage extends StatefulWidget {
  const ListaReservasPage({super.key});

  @override
  State<ListaReservasPage> createState() => _ListaReservasPageState();
}

class _ListaReservasPageState extends State<ListaReservasPage> {
  final _repository = ReservaRepository.instance;
  final _buscaController = TextEditingController();

  // Estado dos filtros
  String _textoBusca = '';
  Periodo? _filtroPeriodo;          // null = todos os períodos
  bool? _filtroMultimidia;          // null = ignorar filtro

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  /// Aplica busca + filtros no repositório e devolve as reservas
  /// que devem ser exibidas na tela.
  List<Reserva> get _reservasVisiveis {
    return _repository.buscarEFiltrar(
      texto: _textoBusca,
      periodo: _filtroPeriodo,
      apenasComMultimidia: _filtroMultimidia,
    );
  }

  Future<void> _abrirFormulario({Reserva? reservaParaEditar}) async {
    final resultado = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioReservaPage(
          reservaParaEditar: reservaParaEditar,
        ),
      ),
    );

    if (resultado == null || !mounted) return;

    final ehEdicao = reservaParaEditar != null;

    setState(() {
      if (ehEdicao) {
        final atualizada = reservaParaEditar.copyWith(
          nomeEstudante: resultado['nomeEstudante'] as String,
          sala: resultado['sala'] as String,
          quantidadeParticipantes:
              resultado['quantidadeParticipantes'] as int,
          periodo: resultado['periodo'] as Periodo,
          precisaMultimidia: resultado['precisaMultimidia'] as bool,
        );
        _repository.atualizar(atualizada);
      } else {
        _repository.adicionar(
          nomeEstudante: resultado['nomeEstudante'] as String,
          sala: resultado['sala'] as String,
          quantidadeParticipantes:
              resultado['quantidadeParticipantes'] as int,
          periodo: resultado['periodo'] as Periodo,
          precisaMultimidia: resultado['precisaMultimidia'] as bool,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ehEdicao
              ? 'Reserva atualizada com sucesso.'
              : 'Reserva cadastrada com sucesso.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _confirmarRemocao(Reserva reserva) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remover reserva'),
        content: Text(
          'Deseja realmente remover a reserva de ${reserva.nomeEstudante}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remover'),
          ),
        ],
      ),
    );

    if (confirmou == true) {
      setState(() => _repository.remover(reserva.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reserva de ${reserva.nomeEstudante} removida.'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final reservas = _reservasVisiveis;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas de Salas'),
      ),
      body: Column(
        children: [
          // ───── Campo de busca ─────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
            child: TextField(
              controller: _buscaController,
              decoration: InputDecoration(
                hintText: 'Buscar por estudante ou sala...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _textoBusca.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _buscaController.clear();
                          setState(() => _textoBusca = '');
                        },
                      ),
              ),
              onChanged: (valor) => setState(() => _textoBusca = valor),
            ),
          ),

          // ───── Filtros ─────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                // Filtro de período
                Expanded(
                  child: DropdownButtonFormField<Periodo?>(
                    initialValue: _filtroPeriodo,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    decoration: const InputDecoration(
                      labelText: 'Período',
                    ),
                    items: [
                      const DropdownMenuItem<Periodo?>(
                        value: null,
                        child: Text('Todos'),
                      ),
                      ...Periodo.values.map(
                        (p) => DropdownMenuItem<Periodo?>(
                          value: p,
                          child: Text(p.label),
                        ),
                      ),
                    ],
                    onChanged: (valor) => setState(() => _filtroPeriodo = valor),
                  ),
                ),
                const SizedBox(width: 8),
                // Filtro de multimídia
                Expanded(
                  child: DropdownButtonFormField<bool?>(
                    initialValue: _filtroMultimidia,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    decoration: const InputDecoration(
                      labelText: 'Multimídia',
                    ),
                    items: const [
                      DropdownMenuItem<bool?>(
                        value: null,
                        child: Text('Todos'),
                      ),
                      DropdownMenuItem<bool?>(
                        value: true,
                        child: Text('Com'),
                      ),
                      DropdownMenuItem<bool?>(
                        value: false,
                        child: Text('Sem'),
                      ),
                    ],
                    onChanged: (valor) => setState(() => _filtroMultimidia = valor),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ───── Lista ─────
          Expanded(
            child: reservas.isEmpty
                ? const EstadoVazio()
                : ListView.builder(
                    itemCount: reservas.length,
                    itemBuilder: (context, index) {
                      final reserva = reservas[index];
                      return ReservaCard(
                        reserva: reserva,
                        onEditar: () =>
                            _abrirFormulario(reservaParaEditar: reserva),
                        onRemover: () => _confirmarRemocao(reserva),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(),
        tooltip: 'Nova reserva',
        child: const Icon(Icons.add),
      ),
    );
  }
}