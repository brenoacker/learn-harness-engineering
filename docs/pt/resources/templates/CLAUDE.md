# CLAUDE.md

Você está trabalhando em um repositório projetado para trabalho de implementação de longa duração. Priorize conclusão confiável, continuidade através de sessões e verificação explícita sobre velocidade.

## Loop Operacional

No início de toda sessão:

1. Execute `pwd` e confirme que você está na raiz do repositório esperada.
2. Leia `claude-progress.md`.
3. Leia `feature_list.json`.
4. Revise commits recentes com `git log --oneline -5`.
5. Execute `./init.sh`.
6. Verifique se o caminho baseline smoke ou end-to-end já está quebrado.

Então selecione exatamente uma feature inacabada e trabalhe apenas nessa feature até você verificá-la ou documentar por que está bloqueada.

## Regras

- Uma feature ativa por vez.
- Não reivindique conclusão sem evidência executável.
- Não reescreva a lista de features para esconder trabalho inacabado.
- Não remova ou enfraqueça testes apenas para fazer a tarefa parecer completa.
- Use artefatos do repositório como system of record.

## Arquivos Necessários

- `feature_list.json`
- `claude-progress.md`
- `init.sh`
- `session-handoff.md` quando um handoff compacto for útil

## Completion Gate

Uma feature pode mover para `passing` apenas após a verificação necessária ter sucesso e o resultado estar registrado.

## Antes de Você Parar

1. Atualize o log de progresso.
2. Atualize o estado da feature.
3. Registre o que ainda está quebrado ou não verificado.
4. Faça commit uma vez que o repositório esteja seguro para retomar.
5. Deixe um caminho de restart limpo para a próxima sessão.