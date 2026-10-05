# Chat Offline

Aplicação de chat local em React + TypeScript + Vite para demonstrar uma conversa manual em uma única tela, sem backend, sem persistência e sem respostas automáticas.

## Visão geral

O projeto oferece uma interface de chat simples e responsiva em que a pessoa pode:

- escrever mensagens em um campo multilinha;
- alternar a autoria entre Usuário e Robô;
- enviar mensagens com botão ou teclado;
- visualizar o histórico em memória durante a sessão;
- manter o compositor fixo no rodapé da tela.

A conversa é totalmente local: todas as mensagens ficam só na memória do React e são apagadas ao recarregar a página.

## Funcionalidades

- Histórico em memória com lista ordenada por envio
- Mensagens do Usuário alinhadas à direita e do Robô à esquerda
- Identificação textual da autoria em cada bolha
- Preservação de quebras de linha no conteúdo exibido
- Compositor fixo no rodapé com textarea auto-resize
- Envio por Enter e quebra de linha por Shift + Enter
- Botão de envio desabilitado quando o texto está vazio ou só contém espaços
- Seletor de autoria acessível com destaque visual para o modo Robô
- Empty state quando ainda não há mensagens
- Auto-scroll para a última mensagem adicionada

## Stack

- React 19
- TypeScript
- Vite
- Tailwind CSS
- Oxlint

## Estrutura do projeto

```text
src/
  App.tsx
  components/
    ChatComposer.tsx
    ChatHistory.tsx
    MessageBubble.tsx
  types/
    message.ts
```

## Como executar

1. Instale as dependências:

```bash
npm install
```

2. Inicie o ambiente de desenvolvimento:

```bash
npm run dev
```

3. Acesse a aplicação no navegador utilizando a porta padrão do Vite.

## Scripts disponíveis

```bash
npm run dev
npm run build
npm run lint
npm run preview
```

## Comportamentos principais

- O campo de mensagem aceita múltiplas linhas e aumenta dinamicamente até um limite visual.
- Enter envia a mensagem quando o conteúdo não está vazio.
- Shift + Enter insere quebra de linha sem enviar.
- A autoria selecionada permanece ativa após o envio até ser alterada manualmente.
- Quando o modo Robô está ativo, o card do compositor recebe borda roxa.
- O histórico é rolável e mantém espaço para a última mensagem não ficar coberta pelo rodapé.

## Observações

Este projeto foi desenvolvido seguindo o PRD documentado em `.docs/prd.m`, com foco em uso local, simplicidade e acessibilidade. O escopo contempla interface visual, histórico em memória e interações de composição, sem backend ou persistência.
