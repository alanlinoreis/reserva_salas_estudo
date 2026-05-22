import '../models/reserva.dart';
import '../utils/periodo.dart';

/// Lista inicial de reservas usada para popular o repositório
/// na inicialização da aplicação.
///
/// Como o projeto é em memória, esses dados servem apenas como
/// exemplo de uso. Eles não são persistidos: ao reiniciar o app,
/// a lista volta ao estado original.
final List<Reserva> reservasMock = [
  Reserva(
    id: '1',
    nomeEstudante: 'Ana Souza',
    sala: 'Sala 101',
    quantidadeParticipantes: 4,
    periodo: Periodo.manha,
    precisaMultimidia: true,
  ),
  Reserva(
    id: '2',
    nomeEstudante: 'Bruno Lima',
    sala: 'Sala 203',
    quantidadeParticipantes: 2,
    periodo: Periodo.tarde,
    precisaMultimidia: false,
  ),
  Reserva(
    id: '3',
    nomeEstudante: 'Carla Mendes',
    sala: 'Sala 305',
    quantidadeParticipantes: 6,
    periodo: Periodo.noite,
    precisaMultimidia: true,
  ),
  Reserva(
    id: '4',
    nomeEstudante: 'Diego Ribeiro',
    sala: 'Sala 101',
    quantidadeParticipantes: 1,
    periodo: Periodo.manha,
    precisaMultimidia: false,
  ),
  Reserva(
    id: '5',
    nomeEstudante: 'Eduarda Pinto',
    sala: 'Sala 204',
    quantidadeParticipantes: 3,
    periodo: Periodo.tarde,
    precisaMultimidia: true,
  ),
];