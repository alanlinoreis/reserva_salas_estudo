# Etapa 02 — Modelagem da entidade Reserva

## Contexto
Era preciso criar a entidade principal da aplicação em `lib/models/`,
representando uma reserva de sala de estudo conforme descrito no enunciado.

## Prompt utilizado
> "feito" (continuação do roteiro alinhado no passo anterior — pedido implícito
> de avançar para o Passo 2: criar a entidade Reserva).

## Resposta resumida da IA
A IA sugeriu:
- Criar a classe `Reserva` em `lib/models/reserva.dart` com 6 campos:
  `id`, `nomeEstudante`, `sala`, `quantidadeParticipantes`, `periodo` e
  `precisaMultimidia`.
- Usar um `enum Periodo` em `lib/utils/periodo.dart` em vez de `String`,
  para garantir valores válidos e facilitar o uso no Dropdown e nos filtros.
- Implementar o método `copyWith` para permitir edição sem mutar a reserva
  original até a confirmação do salvamento.
- Manter o `id` como `final` (identificador imutável).

## Decisão tomada
- Aceitei o uso de enum para `Periodo` — concordo que reduz risco de strings
  inválidas e deixa filtros e dropdown mais limpos.
- Mantive o `copyWith` mesmo sem usá-lo ainda, porque será útil no formulário
  de edição (Passo 6).
- Optei por NÃO implementar `==`, `hashCode` ou `toString` agora, para evitar
  código não utilizado. Adicionaremos somente se houver necessidade real.

## Adaptações realizadas
Nenhuma adaptação significativa neste passo — apliquei o código como sugerido.

## Aprendizado
- Enum com construtor e campo (`label`) é um recurso do Dart 2.17+ que permite
  associar dados a cada valor do enum. Não conhecia esse padrão antes.
- O método `copyWith` é uma convenção idiomática em Dart/Flutter para
  imutabilidade parcial, muito usada em estados controlados.
- Separar enums em `utils/` e classes de domínio em `models/` deixa a
  responsabilidade de cada pasta mais clara.