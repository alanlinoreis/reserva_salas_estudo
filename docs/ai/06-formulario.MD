# Etapa 06 — Formulário de cadastro e edição

## Contexto
Era preciso construir o formulário que cobre cadastro e edição usando o
mesmo widget, com Form, GlobalKey<FormState>, TextEditingController,
TextFormField, DropdownButtonFormField, SwitchListTile, validações
(inclusive numérica) e retorno via Navigator.pop.

## Prompt utilizado
> "feito" (continuação do roteiro — pedido implícito de avançar para o
> Passo 6: tela de formulário).

## Resposta resumida da IA
A IA sugeriu:
- Criar `FormularioReservaPage` recebendo `Reserva? reservaParaEditar`
  opcional. Quando nulo, é cadastro; quando preenchido, é edição.
- Pré-popular os controllers no `initState` apenas se for edição.
- Retornar um `Map<String, dynamic>` em vez de um objeto `Reserva`
  pronto, pois o formulário não tem (e não deve ter) responsabilidade
  sobre gerar IDs nem decidir entre criação e atualização.
- Validar quantidade de participantes com limites razoáveis (1 a 20),
  além da obrigatoriedade e do tipo numérico.
- Manter dupla validação no Dropdown (validator + checagem no `_salvar`)
  por segurança.
- Adicionar `SingleChildScrollView` no body para não cortar campos
  quando o teclado abrir.
- Atualizar `_abrirFormulario` na tela de listagem para tratar tanto
  cadastro quanto edição usando `copyWith` para a edição (preserva o
  id original).

## Decisão tomada
- Aceitei a estratégia de devolver um `Map`. Pensei em criar uma classe
  `DadosFormulario` para tipar melhor, mas isso adicionaria um arquivo
  só para isso, sem ganho prático no escopo do projeto.
- Aceitei os limites 1–20 para participantes — atende ao requisito de
  validação numérica e demonstra preocupação com regras de negócio.
- Aceitei a separação de responsabilidades: formulário coleta dados,
  página decide o que fazer com eles via repositório.

## Adaptações realizadas
Nenhuma adaptação estrutural — código aplicado conforme sugerido.

## Aprendizado
- A separação entre "quem coleta dados" e "quem persiste dados" deixa
  o formulário totalmente reutilizável. Se um dia houvesse mais um lugar
  no app onde a mesma estrutura fosse necessária (por exemplo, duplicar
  uma reserva), o formulário não precisaria ser alterado.
- O método `copyWith` mostrou seu valor real aqui: na edição, ele
  preserva o ID automaticamente, evitando o bug clássico de "perdi o
  ID ao editar".
- Validators em Flutter retornam String? — null significa válido,
  qualquer string é a mensagem de erro mostrada no campo.
- `textInputAction: TextInputAction.next` é um detalhe de UX simples
  mas que melhora bastante a experiência em mobile.