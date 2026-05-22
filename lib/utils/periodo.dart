/// Períodos possíveis para uma reserva de sala de estudo.
///
/// Usado pelo DropdownButtonFormField no formulário e pelo filtro
/// de período na tela de listagem.
enum Periodo {
  manha('Manhã'),
  tarde('Tarde'),
  noite('Noite');

  /// Rótulo legível mostrado ao usuário na interface.
  final String label;

  const Periodo(this.label);
}