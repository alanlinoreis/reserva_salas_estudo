import 'package:flutter/material.dart';
import '../models/reserva.dart';
import '../utils/periodo.dart';

/// Tela de formulário usada tanto para cadastro quanto para edição
/// de uma reserva.
///
/// Se [reservaParaEditar] for fornecido, o formulário inicia com os
/// dados preenchidos e o título passa a ser "Editar reserva". Caso
/// contrário, é uma nova reserva.
///
/// Ao salvar, retorna via `Navigator.pop` um Map contendo os dados
/// do formulário. A criação/atualização efetiva no repositório é
/// responsabilidade da página que chamou este formulário.
class FormularioReservaPage extends StatefulWidget {
  final Reserva? reservaParaEditar;

  const FormularioReservaPage({super.key, this.reservaParaEditar});

  @override
  State<FormularioReservaPage> createState() => _FormularioReservaPageState();
}

class _FormularioReservaPageState extends State<FormularioReservaPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers dos campos de texto
  final _nomeController = TextEditingController();
  final _salaController = TextEditingController();
  final _quantidadeController = TextEditingController();

  // Estado dos campos não-textuais
  Periodo? _periodoSelecionado;
  bool _precisaMultimidia = false;

  bool get _ehEdicao => widget.reservaParaEditar != null;

  @override
  void initState() {
    super.initState();
    // Se for edição, pré-popula os campos com os dados existentes.
    final r = widget.reservaParaEditar;
    if (r != null) {
      _nomeController.text = r.nomeEstudante;
      _salaController.text = r.sala;
      _quantidadeController.text = r.quantidadeParticipantes.toString();
      _periodoSelecionado = r.periodo;
      _precisaMultimidia = r.precisaMultimidia;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _salaController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  // ───── Validadores ─────

  String? _validarObrigatorio(String? valor, String campo) {
    if (valor == null || valor.trim().isEmpty) {
      return '$campo é obrigatório.';
    }
    return null;
  }

  String? _validarQuantidade(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Quantidade é obrigatória.';
    }
    final n = int.tryParse(valor.trim());
    if (n == null) {
      return 'Digite um número válido.';
    }
    if (n < 1) {
      return 'Deve haver pelo menos 1 participante.';
    }
    if (n > 20) {
      return 'Máximo de 20 participantes por sala.';
    }
    return null;
  }

  // ───── Submissão ─────

  void _salvar() {
    // Dispara os validators de todos os campos
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Validação extra do dropdown (o Form não cobre o initialValue null)
    if (_periodoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione um período.')),
      );
      return;
    }

    // Monta o resultado e devolve para a tela anterior.
    final resultado = {
      'nomeEstudante': _nomeController.text.trim(),
      'sala': _salaController.text.trim(),
      'quantidadeParticipantes': int.parse(_quantidadeController.text.trim()),
      'periodo': _periodoSelecionado!,
      'precisaMultimidia': _precisaMultimidia,
    };

    Navigator.pop(context, resultado);
  }

  // ───── UI ─────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_ehEdicao ? 'Editar reserva' : 'Nova reserva'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Nome do estudante
                TextFormField(
                  controller: _nomeController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nome do estudante',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => _validarObrigatorio(v, 'Nome'),
                ),
                const SizedBox(height: 12),

                // Sala
                TextFormField(
                  controller: _salaController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Sala',
                    hintText: 'Ex: Sala 101',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => _validarObrigatorio(v, 'Sala'),
                ),
                const SizedBox(height: 12),

                // Quantidade de participantes (numérico)
                TextFormField(
                  controller: _quantidadeController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Quantidade de participantes',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validarQuantidade,
                ),
                const SizedBox(height: 12),

                // Período (Dropdown)
                DropdownButtonFormField<Periodo>(
                  initialValue: _periodoSelecionado,
                  decoration: const InputDecoration(
                    labelText: 'Período',
                    border: OutlineInputBorder(),
                  ),
                  items: Periodo.values
                      .map(
                        (p) => DropdownMenuItem<Periodo>(
                          value: p,
                          child: Text(p.label),
                        ),
                      )
                      .toList(),
                  onChanged: (valor) =>
                      setState(() => _periodoSelecionado = valor),
                  validator: (v) =>
                      v == null ? 'Selecione um período.' : null,
                ),
                const SizedBox(height: 12),

                // Multimídia (Switch)
                SwitchListTile(
                  title: const Text('Necessita equipamento multimídia'),
                  subtitle: const Text(
                    'Projetor, TV ou outros recursos audiovisuais',
                  ),
                  value: _precisaMultimidia,
                  onChanged: (valor) =>
                      setState(() => _precisaMultimidia = valor),
                  contentPadding: EdgeInsets.zero,
                ),

                const SizedBox(height: 20),

                // Botão de salvar
                FilledButton.icon(
                  onPressed: _salvar,
                  icon: const Icon(Icons.save),
                  label: Text(_ehEdicao ? 'Salvar alterações' : 'Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}