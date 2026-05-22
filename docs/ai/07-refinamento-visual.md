# Etapa 07 — Refinamento visual e correções de UI

## Contexto
Após implementar o CRUD completo e antes de finalizar o README, foram
identificados três problemas visuais ao testar o app:
1. Labels dos dropdowns na tela de listagem ficavam apertados e
   sobrepostos pela borda do campo.
2. O menu suspenso do dropdown de período (no formulário) abria com
   cantos retos e ocupava a tela inteira.
3. O tema padrão estava genérico — havia interesse em aplicar uma
   identidade visual azul mais coesa.

## Prompt utilizado
> "Gostaria que colocasse um tema mais bonito, pode fazer em paleta de
> cores azuis. Vou te mandar 2 prints de algumas coisas que ficaram
> parecendo que estão se sobrepondo na tela inicial. E na tela de
> criação/edição de reservas, a barra de seleção de período ficou muito
> grande, não tem como deixar ela com umas bordas para não ocupar a
> tela inteira?"

(Foram anexados dois prints mostrando os problemas.)

## Resposta resumida da IA
A IA identificou cada problema individualmente:
- O label sobreposto era causado por `isDense: true` combinado com
  altura apertada — solução: remover `isDense` e deixar respirar.
- O menu do dropdown abrindo "quadrado e enorme" era comportamento
  padrão do Material 3, resolvido com a propriedade `borderRadius`
  diretamente no `DropdownButtonFormField`.
- Para o tema, sugeriu centralizar todos os estilos em `ThemeData`
  dentro de `main.dart`, definindo: `ColorScheme.fromSeed` com azul
  Material 800, `appBarTheme`, `cardTheme`, `inputDecorationTheme`,
  `filledButtonTheme`, `snackBarTheme` e `floatingActionButtonTheme`.
- Mais tarde, identificou que no Chrome o popup ainda ocupava a tela
  toda — solução com `ConstrainedBox` + `Center` para limitar largura
  em telas grandes.

Justificativa central: centralizar o tema evita estilos inline
espalhados pelas telas e facilita manutenção.

## Decisão tomada
- Aceitei centralizar tudo no `ThemeData`. Faz sentido — qualquer
  alteração futura de paleta vai mexer em apenas um arquivo.
- Aceitei a propriedade `borderRadius` no dropdown, que arredonda o
  popup também.
- Aceitei `isExpanded: true` nos dropdowns para garantir largura
  estável dentro de `Expanded`.
- Aceitei `ConstrainedBox` para o layout responsivo em web/desktop.

## Adaptações realizadas
- Durante a aplicação do código, surgiu um erro de compilação em
  `Padding` por falta do parâmetro `child:` (problema causado por
  edição incremental). Foi corrigido manualmente após análise da
  mensagem do compilador.
- Remoção dos `border: OutlineInputBorder()` individuais nos
  `TextFormField`, já que o tema global passou a definir as bordas.

## Aprendizado
- Entendi a diferença prática entre estilizar widget por widget vs.
  configurar `ThemeData` uma vez: o tema é "DRY visual" e cobre
  até elementos que aparecem dinamicamente (como o SnackBar).
- `ColorScheme.fromSeed` é uma forma rápida de gerar uma paleta
  harmônica completa a partir de uma única cor.
- A propriedade `borderRadius` em `DropdownButtonFormField` arredonda
  o menu suspenso, não o campo em si.
- Apps Flutter rodando em web/desktop precisam de `ConstrainedBox`
  para limitar a largura — caso contrário, conteúdos esticam
  desconfortavelmente em telas largas.
- Mensagens de erro do compilador Dart podem apontar uma linha
  diferente do problema real; vale investigar o contexto ao redor.