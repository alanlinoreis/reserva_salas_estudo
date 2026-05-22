# Etapa 01 — Setup inicial e estrutura de pastas

## Contexto
Início do projeto. Precisava entender como organizar a estrutura de pastas
exigida pelo enunciado e qual seria o roteiro de desenvolvimento.

## Prompt utilizado
> "Preciso realizar um trabalho na faculdade que siga esses parâmetros [enunciado
> em PDF anexado], vamos fazendo passo a passo porque será necessário anotar
> todas as utilizações de IA no projeto."

## Resposta resumida da IA
A IA propôs um roteiro em 10 etapas (setup, modelo, mocks, repositório,
listagem, formulário, remoção, estado vazio, README, documentação de IA).
Sugeriu também a estrutura de pastas `models/`, `mocks/`, `repositories/`,
`components/`, `pages/`, `utils/` dentro de `lib/`, e uma pasta `docs/ai/`
com um arquivo por etapa.

## Decisão tomada
Aceitei o roteiro proposto pois cobre todos os 20 requisitos técnicos do
enunciado. Optei por documentar a IA em arquivos separados por etapa em vez
de um único arquivo gigante, para facilitar leitura e avaliação.

## Adaptações realizadas
- Nome do projeto: `reservas_salas_estudo` (snake_case obrigatório no Dart).
- Repositório do GitHub criado como público para facilitar avaliação.

## Aprendizado
- Reforcei que pacotes/projetos Dart exigem snake_case.
- Entendi a importância de separar `repositories` da camada de UI mesmo em
  projetos sem backend — facilita manutenção e troca futura por banco real.