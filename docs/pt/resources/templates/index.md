# Guia de Templates

Estes templates estão prontos para copiar em seu próprio projeto. Cada um serve um propósito específico no workflow do agent. Edite o conteúdo para corresponder aos comandos, caminhos, nomes de features e passos de verificação do seu projeto.

## Como Começar

Copie estes quatro arquivos para a raiz do seu projeto primeiro:

1. `AGENTS.md` ou `CLAUDE.md`
2. `init.sh`
3. `claude-progress.md`
4. `feature_list.json`

Adicione os arquivos restantes conforme seu projeto cresce.

---

## AGENTS.md

O arquivo de instrução raiz. Esta é a primeira coisa que o agent lê quando inicia uma sessão. Define as regras operacionais: o que fazer antes de escrever código, como trabalhar e como finalizar.

**Como usar:**

- Copie para o diretório raiz do seu projeto
- Substitua os passos do workflow de startup pelos caminhos e comandos reais do seu projeto
- Ajuste as regras de trabalho para corresponder às convenções da sua equipe
- Mantenha a seção definition of done — é a parte mais importante

**O que faz para o agent:**

- Diz para ler progresso e estado de feature antes de começar o trabalho
- Força a trabalhar em uma feature por vez
- Requer evidência antes de marcar qualquer coisa como feita
- Define como é um final de sessão limpo

Use `AGENTS.md` para Codex ou outros agents. Use `CLAUDE.md` se estiver trabalhando com Claude Code — a estrutura é a mesma, apenas formatada para o estilo de instrução do Claude.

## init.sh

O script de startup. Executa instalação de dependências, verificação e imprime o comando de start — tudo de uma vez.

**Como usar:**

- Copie para a raiz do seu projeto
- Edite estas três variáveis no topo:
  - `INSTALL_CMD` — seu comando de instalação de dependências (ex: `npm install`, `pip install -r requirements.txt`)
  - `VERIFY_CMD` — seu comando básico de verificação (ex: `npm test`, `pytest`)
  - `START_CMD` — seu comando de start do dev server (ex: `npm run dev`)
- Torne executável: `chmod +x init.sh`

**O que faz:**

1. Imprime o diretório atual (para que você possa confirmar que está rodando no lugar certo)
2. Instala dependências
3. Executa o comando de verificação
4. Imprime o comando de start (ou o executa se `RUN_START_COMMAND=1` estiver definido)

Se a verificação falhar, o agent deve parar e corrigir a baseline antes de fazer qualquer outra coisa.

## claude-progress.md

O log de progresso. Toda sessão escreve neste arquivo, e toda nova sessão o lê primeiro.

**Como usar:**

- Copie para a raiz do seu projeto
- Preencha a seção "Current Verified State" com as informações do seu projeto
- Após cada sessão, atualize o registro da sessão

**O que cada campo significa:**

- **Current Verified State** — a única fonte de verdade para onde o projeto está
  - `Repository root directory` — onde o projeto vive
  - `Standard startup path` — o comando para fazer o projeto rodar
  - `Standard verification path` — o comando para executar testes
  - `Highest priority unfinished feature` — no que a próxima sessão deve trabalhar
  - `Current blocker` — qualquer coisa que esteja travada
- **Session Record** — uma entrada por sessão
  - `Goal` — o que você planejou fazer
  - `Completed` — o que realmente foi feito
  - `Verification run` — quais testes foram executados
  - `Evidence recorded` — que prova foi capturada
  - `Commits` — o que foi commitado
  - `Known risks` — o que pode estar quebrado
  - `Next best action` — onde a próxima sessão deve começar

## feature_list.json

O tracker de features. Uma lista legível por máquina de toda feature que o agent precisa implementar, junto com seu status, passos de verificação e evidência.

**Como usar:**

- Copie para a raiz do seu projeto
- Substitua as features de exemplo pelas suas próprias
- Cada feature precisa:
  - `id` — um identificador único curto
  - `priority` — inteiro, menor = prioridade maior
  - `area` — qual parte do app (ex: "chat", "import", "search")
  - `title` — descrição curta
  - `user_visible_behavior` — o que o usuário deve ver quando funciona
  - `status` — um de `not_started`, `in_progress`, `blocked`, `passing`
  - `verification` — instruções passo-a-passo para confirmar que funciona
  - `evidence` — prova registrada de que a verificação passou (preenchida pelo agent)
  - `notes` — qualquer contexto extra

**Regras de status:**

- `not_started` — não foi tocada
- `in_progress` — a única feature sendo trabalhada atualmente (apenas uma por vez)
- `blocked` — não pode prosseguir devido a um problema documentado
- `passing` — verificação passou e evidência está registrada

O agent deve ter apenas uma feature em `in_progress` por vez.

## session-handoff.md

Uma nota de handoff compacta entre sessões. Use quando uma sessão termina e você quer que a próxima pegue rapidamente.

**Como usar:**

- Copie para a raiz do seu projeto
- Preencha no final de cada sessão (ou faça o agent preencher)

**O que cada seção cobre:**

- **Currently verified** — o que está confirmado funcionando e que verificação foi executada
- **Changes this session** — que código ou infraestrutura mudou
- **Still broken or unverified** — problemas conhecidos e áreas arriscadas
- **Next best action** — o que a próxima sessão deve fazer, e o que não tocar
- **Commands** — comandos de startup, verificação e debug para referência rápida

Este arquivo é opcional para sessões pequenas. Torna-se importante quando sessões são longas ou quando o projeto tem múltiplas áreas ativas.

## clean-state-checklist.md

Um checklist para passar antes de terminar cada sessão. Garante que o repo esteja em bom estado para a próxima sessão começar limpa.

**Como usar:**

- Copie para a raiz do seu projeto
- Passe por ele antes de fechar uma sessão
- O agent também deve verificar estes itens como parte de sua rotina de fim de sessão

**O que verifica:**

- Startup padrão ainda funciona
- Verificação padrão ainda executa
- Log de progresso está atualizado
- Lista de features reflete estado real (nenhuma entrada `passing` falsa)
- Nenhum trabalho meio-acabado deixado sem registro
- Próxima sessão pode continuar sem correções manuais

## evaluator-rubric.md

Um scorecard para revisar qualidade de output do agent. Use após uma sessão ou em marcos do projeto para avaliar se o trabalho atende ao padrão.

**Como usar:**

- Copie para a raiz do seu projeto
- Após uma sessão (ou um conjunto de sessões), pontue o trabalho do agent através de seis dimensões
- Cada dimensão é pontuada 0-2

**As seis dimensões:**

1. **Correctness** — a implementação corresponde ao comportamento alvo?
2. **Verification** — as verificações necessárias foram realmente executadas, com evidência?
3. **Scope discipline** — o agent ficou dentro da feature selecionada?
4. **Reliability** — o resultado sobrevive a um restart ou re-run?
5. **Maintainability** — o código e documentação estão claros o suficiente para a próxima sessão?
6. **Handoff readiness** — uma nova sessão pode continuar usando apenas artefatos do repo?

**Opções de conclusão:**

- Accept — atende ao padrão
- Revise — precisa de correções antes de aceitar
- Block — problemas fundamentais que precisam ser resolvidos primeiro

**Importante: o evaluator precisa de tuning.** Fora da caixa, agents são auto-juízes ruins — identificam problemas então se convencem a aprovar. Você precisará iterar:

1. Execute o evaluator em um sprint completo.
2. Compare suas pontuações contra seu próprio julgamento humano.
3. Onde divergem, torne a rubrica mais específica sobre critérios de pass/fail.
4. Re-execute e verifique alinhamento.
5. Repita até o evaluator consistentemente corresponder à revisão humana.

Planeje 3-5 rodadas de tuning. Registre cada mudança para que possa rastrear o que melhorou o alinhamento.

## quality-document.md

Um snapshot de qualidade que classifica cada domínio de produto e camada arquitetural no seu projeto. Rastreia saúde do codebase ao longo do tempo, não apenas output de sessão individual.

**Como usar:**

- Copie para a raiz do seu projeto
- Antes de iniciar uma sessão: leia para entender onde o codebase está mais fraco
- Após uma sessão: atualize notas baseado no que mudou
- Ao longo do tempo: compare snapshots para ver quais mudanças de harness realmente melhoraram a saúde do codebase

**O que classifica:**

- **Domínios de produto** (ex: import de documento, fluxo Q&A, indexing): cada domínio recebe uma nota (A-D) através de status de verificação, legibilidade do agent, estabilidade de teste e gaps-chave
- **Camadas arquiteturais** (ex: processo principal, preload, renderer, services): cada camada recebe uma nota para enforcement de boundary e legibilidade do agent

**Por que importa:**

A rubrica do evaluator pontua outputs individuais do agent. O documento de qualidade pontua o próprio codebase. Respondem perguntas diferentes:

- Rubrica do evaluator: "O agent fez bom trabalho nesta sessão?"
- Documento de qualidade: "O projeto está ficando mais forte ou mais fraco ao longo do tempo?"

**Quando atualizar:**

- Após cada sessão significativa
- Antes de comparações de benchmark
- Após passes de limpeza ou simplificação
- Ao fazer onboarding de um novo agent ou modelo para o projeto

**Tie-in de simplificação de harness:**

O documento de qualidade também suporta simplificação de harness. Todo componente de harness codifica uma suposição sobre o que o modelo não consegue fazer. Conforme modelos melhoram, essas suposições ficam obsoletas. Para verificar se um componente ainda é necessário:

1. Tire um snapshot do documento de qualidade.
2. Remova um componente de harness.
3. Execute a suite de tarefas de benchmark.
4. Tire outro snapshot.
5. Compare — se as notas não caíram, o componente era overhead. Se caíram, restaure.