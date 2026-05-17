# Skills

Este diretório contém as skills de agente de IA empacotadas que vêm com este curso. Skills são templates de prompt autocontidos que podem ser carregados por agentes de codificação de IA (Claude Code, Codex, Cursor, Windsurf, etc.) para realizar tarefas especializadas.

## harness-creator

Uma skill de harness engineering de nível de produção para agentes de codificação de IA. Ajuda você a criar, avaliar e melhorar os cinco subsistemas centrais do harness: instruções, estado, verificação, escopo e ciclo de vida da sessão.

### O que Faz

- **Criar harnesses do zero** — AGENTS.md, listas de features, workflows de verificação
- **Melhorar harnesses existentes** — Avaliação de cinco subsistemas com melhorias priorizadas
- **Projetar continuidade de sessão** — Persistência de memória, tracking de progresso, procedimentos de handoff
- **Aplicar padrões de produção** — Memória, context engineering, segurança de ferramentas, coordenação multi-agent

### Quick Start

Os arquivos da skill ficam no repositório em [`skills/harness-creator/`](https://github.com/walkinglabs/learn-harness-engineering/tree/main/skills/harness-creator).

Para usar com Claude Code, copie o diretório `harness-creator/` para o caminho de skill do seu projeto, ou aponte seu agent para o arquivo SKILL.md.

### Padrões de Referência

A skill inclui 6 documentos de referência de deep-dive:

| Padrão | Quando Usar |
|---------|-------------|
| Memory Persistence | Agent esquece entre sessões |
| Context Engineering | Gerenciamento de budget de contexto, carregamento JIT |
| Tool Registry | Segurança de ferramentas, controle de concorrência |
| Multi-Agent Coordination | Paralelismo, workflows de especialização |
| Lifecycle & Bootstrap | Hooks, tarefas de background, inicialização |
| Gotchas | 15 modos de falha não-óbvios com correções |

### Templates

A skill empacota templates prontos para usar:

- `agents.md` — Scaffold AGENTS.md com regras de trabalho
- `feature-list.json` — JSON Schema + exemplo de lista de features
- `init.sh` — Script de inicialização padrão
- `progress.md` — Template de log de progresso de sessão

### Como Esta Skill Foi Construída

`harness-creator` foi desenvolvida usando a metodologia **skill-creator** — a meta-skill oficial da Anthropic para criar, testar e iterar em skills de agent. O skill-creator fornece um workflow estruturado (draft → test → evaluate → iterate) com runners de eval integrados, graders e um visualizador de benchmark.

- **fonte do skill-creator**: [anthropics/skills — skill-creator](https://github.com/anthropics/skills/tree/main/skills/skill-creator)
- **docs de skills do Claude Code**: [anthropics/claude-code — plugin-dev/skills](https://github.com/anthropics/claude-code/tree/main/plugins/plugin-dev/skills)