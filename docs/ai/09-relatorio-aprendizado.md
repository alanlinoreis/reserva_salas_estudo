# Relatório final de aprendizado

Este documento sintetiza o que foi aprendido ao longo do desenvolvimento
do Sistema de Reservas de Salas de Estudo, com foco no uso da IA (Claude,
da Anthropic) como ferramenta de apoio.

## Sobre o uso da IA

A IA foi utilizada como **co-piloto didático** durante todo o projeto.
A cada etapa, a interação seguiu um padrão consistente: a IA propunha
um caminho técnico, eu avaliava se fazia sentido para o escopo do
trabalho e para o meu nível de conhecimento, e então aplicava com
adaptações quando necessário.

Nenhuma etapa foi feita "às cegas". Para cada bloco de código sugerido,
busquei entender:
- **O quê** o código faz (semântica).
- **Por quê** aquela abordagem foi escolhida (justificativa).
- **Como** ele se conecta com o restante do projeto (arquitetura).

Esse processo está documentado em detalhes nos arquivos numerados desta
pasta (`01-setup-inicial.md` até `08-readme.md`).

## Principais aprendizados técnicos

### 1. Separação de responsabilidades em camadas

Antes deste trabalho, eu tendia a colocar lógica de dados direto dentro
das telas. A organização sugerida — `models`, `mocks`, `repositories`,
`components`, `pages`, `utils` — deixou claro como cada parte do código
tem um papel bem definido. O `repository`, em especial, virou um
exemplo prático de como isolar o "como os dados são armazenados" do
"como os dados são mostrados".

### 2. Singleton e estado em memória

Aprendi o padrão singleton em Dart usando construtor privado
(`ClassName._internal()`) com uma `static final instance`. Em um app
sem gerenciamento de estado avançado (Provider, Riverpod), o singleton
foi suficiente para manter uma única fonte de verdade entre telas.

### 3. Imutabilidade parcial com `copyWith`

O método `copyWith` no modelo `Reserva` resolveu um problema prático:
preservar o `id` automaticamente durante a edição. Antes, eu provavelmente
teria criado um novo objeto manualmente e esquecido de copiar o ID em
algum momento. O padrão `copyWith` torna esse erro impossível por
construção.

### 4. Formulários reutilizáveis

A mesma `FormularioReservaPage` atende cadastro e edição. A chave foi
torná-la **agnóstica**: ela apenas coleta dados e devolve um `Map` via
`Navigator.pop`. Quem decide se aquilo vai virar uma reserva nova ou
substituir uma existente é a tela que chamou o formulário. Esse
desacoplamento foi um dos aprendizados mais valiosos do projeto.

### 5. Validações em camadas

Em vez de validar o formulário inteiro manualmente, aprendi a usar o
trio `Form` + `GlobalKey<FormState>` + `validator` por campo. Isso
deixa cada campo responsável pela própria validação, e o formulário
inteiro é validado com uma única chamada
`_formKey.currentState!.validate()`.

### 6. Tema centralizado com `ThemeData`

Quando precisei aplicar uma identidade visual azul, em vez de estilizar
cada widget individualmente, configurei tudo em `ThemeData` no
`main.dart`. Isso me ensinou na prática o princípio DRY aplicado a
estilos: uma alteração no `seedColor` muda o app inteiro de forma
coerente.

### 7. Design responsivo em Flutter

Aprendi sobre `ConstrainedBox` + `Center` ao perceber que o app esticava
desconfortavelmente quando rodado no Chrome em tela larga. Em telas
estreitas (mobile), os widgets não têm efeito; em telas largas, limitam
a largura do conteúdo. É o padrão recomendado para apps Flutter que
rodam tanto em mobile quanto em web.

## Correções e adaptações importantes

Nem tudo foi aceito como veio. Alguns pontos exigiram ajuste manual:

- **`deprecated_member_use` em `DropdownButtonFormField`**: a IA gerou
  código usando `value:`, mas a versão atual do Flutter exige
  `initialValue:`. Foi necessário rodar `flutter analyze` para detectar
  e corrigir. Aprendi que a IA pode usar APIs ligeiramente desatualizadas
  e que o analisador estático é uma rede de segurança essencial.

- **Erro de compilação por `Padding` sem `child:`**: durante uma edição
  incremental, acabei colando trechos de código em sequência e o
  parâmetro `child:` do `Padding` se perdeu. O compilador apontou
  o erro em uma linha diferente do problema real. Aprendi a confiar
  na mensagem do erro como pista, mas também a investigar o contexto
  ao redor.

- **Popup do dropdown ocupando a tela inteira no Chrome**: foi
  necessário entender que esse comportamento é correto para mobile
  (o popup acompanha a largura do campo), mas precisa de
  `ConstrainedBox` em layouts responsivos para desktop/web. Aprendi
  sobre design responsivo em Flutter na prática.

- **Sobreposição de labels nos dropdowns**: causada por `isDense: true`
  combinado com pouco espaço vertical. Aprendi que `isDense` é útil
  para compactar, mas pode comprometer a legibilidade do label.

- **Organização inicial confusa dos arquivos de documentação**: em um
  momento, coloquei um arquivo destinado à pasta `docs/ai/` na raiz do
  projeto por confusão entre o README principal e o arquivo que
  documenta a criação do README. Isso me ensinou a importância de
  manter clareza sobre o **propósito** de cada arquivo na estrutura
  do projeto, não só o nome.

## Conclusão

O uso da IA acelerou bastante o desenvolvimento, mas o aprendizado
real veio das duas pontas: das **explicações que a IA forneceu** e
dos **erros que precisei corrigir manualmente**. Os bugs e warnings
foram, paradoxalmente, os momentos mais didáticos — porque me
obrigaram a parar, ler o código e entender o que estava acontecendo
em vez de só copiar e colar.

Saio do projeto com uma noção muito mais clara de como estruturar
um app Flutter de médio porte, com camadas bem definidas,
formulários robustos, tema visual consistente e layout responsivo
para mobile e web.