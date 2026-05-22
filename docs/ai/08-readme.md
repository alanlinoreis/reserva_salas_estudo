# Etapa 08 — Criação do README.md

## Contexto
Era preciso criar um README.md de boa qualidade para o repositório,
explicando o objetivo, o problema resolvido, as funcionalidades, a
estrutura de pastas, os principais widgets utilizados, instruções de
execução e exibindo prints das telas — conforme exigido pelo enunciado.

## Prompt utilizado
> "feito" (continuação do roteiro — pedido para avançar para a criação
> do README, após confirmação de que os 20 requisitos técnicos estavam
> atendidos e o refinamento visual aplicado).

## Resposta resumida da IA
A IA sugeriu uma estrutura de README dividida em seções: objetivo,
problema resolvido, funcionalidades, telas (com prints), estrutura de
pastas, tabela de principais widgets, instruções de execução e link
para a documentação da IA.

Decisões de organização sugeridas:
- Usar 5 prints (listagem, busca, estado vazio, formulário, confirmação
  de remoção), nomeados de forma padronizada em `screenshots/`.
- Apresentar os widgets em uma tabela em vez de lista, para facilitar
  a leitura.
- Referenciar a pasta `docs/ai/` no README em vez de duplicar conteúdo,
  preservando uma única fonte de verdade para a documentação da IA.
- Incluir instruções de clone e execução, mesmo o projeto não tendo
  dependências externas além das padrão.
- Capturar os prints com a janela do Chrome estreita (~420px) para
  manter a estética mobile no README.

## Decisão tomada
- Aceitei a estrutura completa do README sugerida — todas as seções
  cobrem requisitos do enunciado.
- Aceitei a tabela de widgets — fica mais fácil de bater o olho do
  que um parágrafo descritivo.
- Optei por usar 5 prints conforme sugerido (havia opção de 3).
- Capturei os prints em modo mobile (janela estreita), o que ficou
  mais coerente com a natureza do app.

## Adaptações realizadas
- Confirmei o nome de autor e os dados pessoais antes de subir.
- Atualizei a tabela de widgets para incluir `ConstrainedBox + Center`,
  que foram adicionados na etapa de refinamento visual.
- Mencionei o tema visual na lista de funcionalidades.

## Aprendizado
- Um bom README não precisa ser longo, precisa ser **completo e
  navegável**: sumário no topo, seções bem nomeadas, exemplos e
  imagens onde fizerem sentido.
- Documentar a estrutura de pastas no README ajuda quem avalia o
  projeto a entender a arquitetura sem precisar abrir cada arquivo.
- Tabelas em Markdown são úteis para mapeamentos como
  "widget → onde é usado → propósito", evitando repetição.