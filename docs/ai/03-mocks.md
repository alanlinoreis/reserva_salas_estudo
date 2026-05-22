# Etapa 03 — Dados mockados iniciais

## Contexto
O enunciado exige uma lista inicial de dados simulados em `lib/mocks/`.
Precisava decidir quantos registros criar e como compô-los para que fossem
úteis nos testes de busca e filtros.

## Prompt utilizado
> "feito" (continuação do roteiro — pedido implícito de avançar para o
> Passo 3: criar a lista mockada de reservas).

## Resposta resumida da IA
A IA sugeriu:
- Criar 5 reservas com variação proposital: períodos diferentes (manhã, tarde,
  noite), valores diferentes para `precisaMultimidia`, salas que se repetem e
  quantidades de participantes variadas.
- Usar `final List<Reserva>` em vez de `const`, porque a classe `Reserva` tem
  campos mutáveis.
- Manter o mock isolado em `lib/mocks/` e consumi-lo apenas via repositório,
  para que a UI nunca dependa diretamente dos dados de exemplo.

## Decisão tomada
Aceitei a sugestão de 5 reservas com variação intencional. Concordo que esse
tamanho facilita testar busca (com "Sala 101" aparecendo duas vezes) e
ambos os filtros sem precisar cadastrar nada manualmente.

## Adaptações realizadas
Nomes dos estudantes e salas escolhidos manualmente — apenas valores
ilustrativos.

## Aprendizado
- Entendi a diferença prática entre `const` e `final` para listas em Dart:
  `const` exige que tudo dentro também seja imutável em tempo de compilação,
  o que não é o caso de classes com campos não-final.
- Reforcei a ideia de não acoplar a UI à camada de dados: o mock será
  consumido pelo repositório, não pelas páginas. Isso torna mais fácil
  substituir por um banco real no futuro.