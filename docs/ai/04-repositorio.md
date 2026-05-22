# Etapa 04 — Repositório em memória

## Contexto
Era preciso criar a camada de CRUD em `lib/repositories/`, centralizando
todas as operações sobre reservas. As telas (listagem e formulário) não
podem manipular listas diretamente — devem sempre passar pelo repositório.

## Prompt utilizado
> "feito" (continuação do roteiro — pedido implícito de avançar para o
> Passo 4: criar o repositório com CRUD completo, busca e filtros).

## Resposta resumida da IA
A IA sugeriu:
- Implementar `ReservaRepository` como singleton, acessado via
  `ReservaRepository.instance`. Justificativa: simplifica a navegação
  entre telas sem precisar de Provider/Riverpod e é coerente com o uso
  de `setState` exigido pelo enunciado.
- Inicializar a lista interna com `List.from(reservasMock)` para não
  mutar a lista mock original.
- Expor `listar()` retornando `List.unmodifiable` para impedir mutações
  externas.
- Gerar IDs via `DateTime.now().millisecondsSinceEpoch.toString()`,
  evitando dependência externa de `uuid`.
- Unificar busca e filtros em um único método `buscarEFiltrar`, com o
  filtro de multimídia usando `bool?` para representar três estados
  (todas / só com / só sem).

## Decisão tomada
- Aceitei o padrão singleton por simplicidade e por evitar prop drilling
  do repositório entre telas.
- Aceitei o método único `buscarEFiltrar` — concordo que aplicar três
  funções em cascata seria menos eficiente e mais verboso.
- Aceitei o uso de `bool?` para multimídia. Vai facilitar a UI com chips
  ou dropdown de três estados na próxima etapa.

## Adaptações realizadas
Nenhuma neste passo. O código foi aplicado conforme a sugestão.

## Aprendizado
- Construtor privado (`ClassName._internal()`) combinado com
  `static final instance` é o padrão idiomático de singleton em Dart.
- `List.unmodifiable` é uma forma simples de proteger estruturas de
  dados internas contra mutações indevidas em camadas externas.
- O padrão de filtros nullable (`bool?`, `Periodo?`) é uma forma elegante
  de representar "filtro desligado" sem precisar de flags booleanas
  separadas.
- A diferença entre "passar referência" e "passar cópia" de listas é
  sutil mas importante — atribuir uma lista a outra variável não cria
  cópia, apenas um novo nome para o mesmo objeto na memória.