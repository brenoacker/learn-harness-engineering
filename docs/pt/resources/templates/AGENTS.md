# AGENTS.md

Este repositório é projetado para trabalho de coding-agent de longa duração. O objetivo não é maximizar output bruto de código. O objetivo é deixar o repo em um estado onde a próxima sessão possa continuar sem adivinhar.

## Workflow de Startup

Antes de escrever código:

1. Confirme o diretório de trabalho com `pwd`.
2. Leia `claude-progress.md` para o último estado verificado e próximo passo.
3. Leia `feature_list.json` e escolha a feature inacabada de maior prioridade.
4. Revise commits recentes com `git log --oneline -5`.
5. Execute `./init.sh`.
6. Execute a verificação smoke ou end-to-end necessária antes de começar novo trabalho.

Se a verificação baseline já estiver falhando, corrija isso primeiro. Não empilhe novo trabalho de feature em cima de um estado inicial quebrado.

## Regras de Trabalho

- Trabalhe em uma feature por vez.
- Não marque uma feature como completa apenas porque código foi adicionado.
- Mantenha mudanças dentro do escopo da feature selecionada a menos que um blocker force uma correção de suporte restrita.
- Não mude silenciosamente regras de verificação durante implementação.
- Prefira artefatos duráveis do repo sobre resumos de chat.

## Artefatos Necessários

- `feature_list.json`: fonte de verdade para estado de feature
- `claude-progress.md`: log de sessão e status verificado atual
- `init.sh`: caminho padrão de startup e verificação
- `session-handoff.md`: handoff compacto opcional para sessões maiores

## Definition Of Done

Uma feature está feita apenas quando todos os seguintes são verdadeiros:

- o comportamento alvo está implementado
- a verificação necessária realmente executou
- evidência está registrada em `feature_list.json` ou `claude-progress.md`
- o repositório permanece reiniciável a partir do caminho padrão de startup

## End Of Session

Antes de terminar uma sessão:

1. Atualize `claude-progress.md`.
2. Atualize `feature_list.json`.
3. Registre qualquer risco não resolvido ou blocker.
4. Faça commit com uma mensagem descritiva uma vez que o trabalho esteja em estado seguro.
5. Deixe o repo limpo o suficiente para a próxima sessão executar `./init.sh` imediatamente.