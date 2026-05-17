[Versão em Inglês →](../../../en/projects/project-01-baseline-vs-minimal-harness/)

> Lectures relacionadas: [Lecture 01. Modelos fortes não significam execução confiável](./../../lectures/lecture-01-why-capable-agents-still-fail/index.md) · [Lecture 02. O que harness realmente significa](./../../lectures/lecture-02-what-a-harness-actually-is/index.md)
> Arquivos de template: [templates/](https://github.com/walkinglabs/learn-harness-engineering/blob/main/docs/pt/resources/templates/)

# Projeto 01. Prompt-Only vs. Rules-First: Quanta Diferença Faz

## O que Você Faz

Construa um shell mínimo de app knowledge-base em Electron — uma janela com uma lista de documentos à esquerda, um painel Q&A à direita, e um diretório de dados local. A tarefa em si não é complexa. O que é complexo é como você faz o agent completá-la.

Você executa duas vezes. Primeira vez: apenas um prompt, nenhuma preparação. Segunda vez: `AGENTS.md`, `init.sh`, `feature_list.json` pré-colocados no repo. Então compare.

O núcleo deste projeto não é escrever código — é descobrir quão grande é o gap entre "gastar 15 minutos preparando regras primeiro" e "apenas deixar o agent ir."

## Ferramentas

- Claude Code ou Codex (escolha um, use para ambas as execuções)
- Git (gerenciar branches e comparar)
- Node.js + Electron (stack do projeto)
- Um cronômetro (registrar duração de cada execução)

## Mecanismo de Harness

Harness mínimo: `AGENTS.md` + `init.sh` + `feature_list.json`

## Execução 1: Baseline (Prompt-Only)

1. Crie um repositório vazio
2. Dê ao agent apenas este prompt:
   ```
   Construa um app Electron simples de knowledge-base com:
   - Lista de documentos na sidebar esquerda
   - Painel Q&A principal à direita
   - Capacidade de adicionar/remover documentos
   - Interface básica de busca
   - Armazenamento local de dados
   ```
3. Registre:
   - Tempo total gasto
   - Quantas vezes você teve que intervir
   - Quantos erros/problemas ocorreram
   - Se o resultado final funciona

## Execução 2: Com Harness Mínimo

1. Crie um novo branch ou repositório
2. Primeiro, configure o harness:
   - Copie `AGENTS.md` dos templates e adapte para Electron
   - Crie `init.sh` com comandos npm/electron
   - Crie `feature_list.json` com as features listadas
3. Então dê ao agent o mesmo prompt
4. Registre as mesmas métricas

## Critérios de Sucesso

- **Execução 1**: App funciona, mas provavelmente com intervenção manual
- **Execução 2**: App funciona com menos intervenção, processo mais suave
- **Comparação**: Diferença mensurável em tempo, qualidade, ou esforço

## O que Você Aprenderá

- Impacto quantitativo de preparação mínima de harness
- Onde agents tipicamente ficam presos sem orientação
- Quais componentes de harness têm maior ROI
- Como medir melhoria de performance de agent

## Próximos Passos

Após completar ambas as execuções, documente suas descobertas e prossiga para o Projeto 02, onde você construirá um workspace mais sofisticado e agent-readable.