# Biblioteca de Recursos em Português

Esta pasta transforma os métodos do curso em templates prontos para copiar e referências compactas que você pode usar em um repositório real.

## Quando Usar

Comece aqui quando você quiser que Codex, Claude Code, ou outro coding agent trabalhe através de múltiplas sessões sem constantemente re-derivar setup, status e escopo.

É especialmente útil quando:

- o trabalho abrange múltiplas sessões
- features são numerosas e fáceis de deixar meio-acabadas
- agents tendem a declarar vitória muito cedo
- passos de startup são redescobertos toda vez

## Comece Aqui

Para um setup mínimo, comece com:

- instruções root: [`templates/AGENTS.md`](./templates/AGENTS.md) ou [`templates/CLAUDE.md`](./templates/CLAUDE.md)
- estado de feature: [`templates/feature_list.json`](./templates/feature_list.json)
- log de progresso: [`templates/claude-progress.md`](./templates/claude-progress.md)
- referência de script bootstrap: `docs/pt/resources/templates/init.sh`

Então adicione:

- handoff de sessão: [`templates/session-handoff.md`](./templates/session-handoff.md)
- checklist de saída limpa: [`templates/clean-state-checklist.md`](./templates/clean-state-checklist.md)
- rubrica de avaliador: [`templates/evaluator-rubric.md`](./templates/evaluator-rubric.md)

Se você quiser a estrutura de repositório completa no estilo OpenAI do artigo "Harness engineering", use o pacote avançado:

- [`openai-advanced/index.md`](./openai-advanced/index.md)

## Estrutura da Biblioteca

- [`templates/`](./templates/index.md): templates para copiar em um repo real
- [`reference/`](./reference/index.md): notas de método, fluxo de startup e mapas de modo de falha
- [`openai-advanced/`](./openai-advanced/index.md): esqueleto de repo avançado, docs system-of-record e templates de governança agent-first

## Pacote Mínimo Recomendado

- `AGENTS.md` ou `CLAUDE.md`
- `feature_list.json`
- `claude-progress.md`
- `init.sh`

Esses quatro arquivos são suficientes para tornar a maioria dos workflows de agent visivelmente mais estáveis.

Quando o repo cresce em um sistema de longa duração com múltiplos domínios, planos ativos, scoring de qualidade e políticas de confiabilidade, mude para o pacote [`openai-advanced/`](./openai-advanced/index.md) em vez de esticar o pacote mínimo demais.