# PRD: Chat offline

## 1. Visão geral

Construir uma interface de chat local, de tela única, em que a pessoa adiciona mensagens manualmente escolhendo se cada mensagem foi enviada pelo Usuário ou pelo Robô. O app é uma demonstração de conversa: não há backend, resposta automática nem persistência.

## 2. Objetivo

Entregar uma experiência de chat simples e utilizável em desktop e dispositivos móveis, com histórico em memória durante a sessão e um compositor fixo na parte inferior da tela.

### Fora de escopo

- Respostas ou comportamento autonomo do Robo.
- Comunicação com API, autenticação, múltiplas conversas ou anexos.
- Persistência em banco de dados, localStorage ou outro meio.
- Edição, exclusão, busca ou reações a mensagens.
- Exibição de horário ou data por mensagem.

## 3. Usuarios e fluxo principal

Uma pessoa usa a janela única para compor mensagens e alternar a autoria entre Usuário e Robô. As mensagens do Usuário aparecem alinhadas à direita; as do Robô, à esquerda.

1. A pessoa abre o chat vazio.
2. Digita uma mensagem no compositor inferior.
3. Opcionalmente alterna o autor entre Usuario e Robo.
4. Envia pelo botao ou pressiona Enter.
5. A mensagem aparece no historico no lado correspondente, o campo e limpo e o historico permanece atualizado.

Shift+Enter insere uma quebra de linha sem enviar. A autoria selecionada continua ativa depois do envio, até ser alterada.

## 4. Requisitos funcionais

### RF-1: Histórico em memória

- Manter as mensagens em um array de estado React, sem persistencia.
- Cada mensagem possui um identificador, um autor (`user` ou `robot`) e o conteudo textual.
- Ao recarregar a página, o histórico começa vazio.
- Preservar quebras de linha no conteudo exibido.

### RF-2: Compositor de mensagens

- Manter o compositor no rodapé da janela durante a rolagem do histórico.
- Usar um campo multilinha que aumenta de altura conforme o conteúdo, respeitando um limite razoável; acima desse limite, o campo pode rolar internamente.
- Enviar com Enter e inserir quebra de linha com Shift+Enter.
- O botão Enviar fica desabilitado quando o campo estiver vazio ou contiver apenas espaços em branco.
- Enviar limpa o campo. O modo de autoria permanece selecionado.
- O envio pelo teclado e pelo botao aplica a mesma validacao e cria uma unica mensagem por acao.

### RF-3: Seletor de autoria

- Disponibilizar no lado esquerdo do compositor um controle alternável entre Usuário e Robô.
- O controle deve deixar claro qual autoria está selecionada.
- No modo Robô, destacar o compositor com uma borda roxa.
- Cada mensagem criada recebe a autoria selecionada no momento do envio.

### RF-4: Apresentação e navegação do histórico

- Mostrar mensagens do Usuário à direita e do Robô à esquerda.
- Diferenciar visualmente as duas autorias, sem depender apenas da cor: apresentar tambem identificacao textual ou acessivel.
- Manter as mensagens em ordem de envio.
- Ao adicionar uma mensagem, rolar até a mais recente sem ocultar o compositor. O histórico deve continuar rolável para consultar mensagens anteriores.
- Quando vazio, mostrar a tela de chat sem mensagens ficticias.

## 5. Requisitos visuais e responsivos

- Fundo geral marrom claro.
- Conteúdo do chat, histórico e compositor em uma coluna centralizada com largura máxima equivalente a Tailwind `max-w-2xl` em telas maiores.
- O compositor é um card branco no rodapé, com altura adaptável ao texto e espaçamento suficiente para controles e foco.
- A borda roxa do compositor é exibida somente quando Robô estiver selecionado.
- Em telas estreitas, usar a largura disponível com margens seguras; controles não podem sobrepor o campo nem sair da viewport.
- Reservar espaço no histórico para que a última mensagem não fique encoberta pelo compositor.
- Estados de foco, hover, selecionado e desabilitado devem ser visualmente perceptiveis e ter contraste legivel.

## 6. Acessibilidade

- Usar elementos semânticos: formulário para composição, campo de texto multilinha e botão de envio.
- O seletor de autoria deve ser operável por teclado e expor seu estado e sua finalidade a tecnologias assistivas.
- O botão desabilitado deve usar o estado nativo de desabilitado; não comunicar estado apenas por cor.
- Garantir ordem de foco previsível, foco visível e nomes acessíveis para os controles.
- Mudanças no histórico devem ser anunciáveis sem mover o foco para fora do compositor.

## 7. Restricoes e diretrizes tecnicas

- Stack existente: Vite, React, TypeScript e Tailwind CSS já configurados.
- Definir os tipos de domínio em `src/types`, usando `type` e não `interface`.
- Manter componentes de interface em `src/components`.
- Manter o estado do histórico na memória do React; não adicionar armazenamento persistente.
- Reutilizar a configuração e dependências atuais. Não introduzir biblioteca de UI ou de estado sem necessidade.
- Organizar a implementacao em componentes focados, por exemplo: lista do historico, item de mensagem e compositor.
- Preservar os scripts existentes de lint e build (`npm run lint` e `npm run build`).

## 8. Criterios de aceite

- A aplicação inicia e apresenta uma única janela de chat com fundo marrom claro e coluna central limitada a `max-w-2xl`.
- O compositor permanece no rodapé e se adapta a mensagens multilinha sem cobrir o histórico.
- O envio é impedido para conteúdo vazio ou apenas com espaços; o botão reflete esse estado.
- Enter envia uma mensagem e Shift+Enter insere uma quebra de linha.
- Usuário aparece à direita e Robô à esquerda; autoria e conteúdo correspondem ao modo selecionado no envio.
- Selecionar Robô aplica borda roxa ao compositor; voltar a Usuário remove esse destaque.
- Após envio, o campo limpa, a autoria selecionada permanece e a nova mensagem fica visível.
- O histórico é mantido apenas durante a sessão e volta vazio após recarregar a página.
- Os fluxos principais funcionam por teclado e em viewport estreita, sem controles cortados ou sobreposição.
- `npm run lint` e `npm run build` concluem sem erros.

## 9. Plano de implementacao

As tarefas abaixo estão em ordem progressiva, alinhadas com a sequencia visual da imagem e com a entrega incremental do chat.

### Checklist de progresso

- [x] Fase 1 — Fundacao - tipos & layout base
- [x] Fase 2 — Histórico - bolhas, lista, empty state, auto-scroll
- [x] Fase 3 — Input - card fixo, textarea auto-resize, envio
- [x] Fase 4 — Toggles - componente, integração, borda roxa
- [x] Fase 5 — Polimento - ajustes visuais + lint/build

### Tarefa 1: Fundacao - tipos e layout base

- [x] Confirmar os pontos de entrada, estilos globais e integraçao Tailwind existentes.
- [x] Definir os tipos de domínio em `src/types` usando `type` para autoria e mensagem.
- [x] Montar a estrutura base da tela com fundo marrom claro, coluna central limitada e altura da viewport.
- [x] Preparar a separação entre histórico rolável e compositor fixo no rodapé.

**Pronto quando:** a aplicação renderiza a estrutura vazia de chat sem erros e o contrato de mensagem já está compartilhado entre componentes.

### Tarefa 2: Histórico - bolhas, lista, estado vazio e auto-scroll

- [x] Criar a lista de mensagens e os itens individuais em `src/components`.
- [x] Renderizar Usuário à direita e Robô à esquerda, com identificação textual e preservação de quebra de linha.
- [x] Exibir estado vazio sem mensagens fictícias e manter ordem de envio.
- [x] Rolar automaticamente até a mensagem mais recente após inserir nova mensagem.

**Pronto quando:** uma lista tipada de mensagens pode ser apresentada na ordem correta e a área de histórico continua navegável.

### Tarefa 3: Input - card fixo, textarea auto-resize e envio

- [x] Implementar o compositor em card branco no rodapé com altura adaptável ao texto.
- [x] Criar textarea multilinha com limite visual e crescimento conforme conteúdo.
- [x] Enviar com botão e Enter; Shift+Enter deve inserir quebra de linha sem mandar.
- [x] Desabilitar o botão quando o texto estiver vazio ou contiver apenas espaços.
- [x] Ao enviar, limpar o campo e manter a seleção de autoria ativa.

**Pronto quando:** o fluxo de composição e envio produz uma mensagem válida por ação e o campo fica consistente com as regras de teclado.

### Tarefa 4: Toggles - componente, integração e borda roxa

- [x] Adicionar o seletor de autoria em um controle acessível por teclado.
- [x] Manter a autoria atual no estado da tela e reaproveitar o valor durante o envio.
- [x] Destacar o compositor com borda roxa somente quando a autoria ativa for Robô.
- [x] Garantir feedback visível para seleção, foco e estados desabilitados.

**Pronto quando:** a alternância de Usuário/Robô funciona sem mouse e o destaque visual corresponde ao modo selecionado.

### Tarefa 5: Polimento - ajustes visuais e validação final

- [x] Revisar espaçamento, foco visível, contraste e responsividade em telas estreitas.
- [x] Confirmar que a última mensagem não fique encoberta pelo compositor e que o histórico continua rolável.
- [x] Executar `npm run lint` e `npm run build` para validar a base final.
- [x] Fazer verificação manual dos fluxos principais e do comportamento de recarga da página.

**Pronto quando:** todos os critérios de aceite foram atendidos e a aplicação fica compilável e utilizável sem erros.

### Ordem das fases

1. Fundacao - tipos & layout base
2. Histórico - bolhas, lista, empty state, auto-scroll
3. Input - card fixo, textarea auto-resize, envio
4. Toggles - componente, integração, borda roxa
5. Polimento - ajustes visuais + lint/build

Quer que o app comece a implementação seguindo esse fluxo.

## 10. Decisoes de escopo

- “Robô” representa uma autoria escolhida manualmente; não existe geração de resposta.
- O arquivo de histórico é mantido somente em memória e não é restaurado após recarga.
- A autoria permanece selecionada depois do envio para permitir mensagens consecutivas do mesmo perfil.
- O documento usa Markdown, mantendo o caminho solicitado `.docs/prd.m`.