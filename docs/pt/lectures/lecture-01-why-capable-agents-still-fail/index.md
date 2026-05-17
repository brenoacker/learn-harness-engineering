[Versão em Inglês →](../../../en/lectures/lecture-01-why-capable-agents-still-fail/)

> Exemplos de código: [code/](https://github.com/walkinglabs/learn-harness-engineering/blob/main/docs/en/lectures/lecture-01-why-capable-agents-still-fail/code/)
> Projeto prático: [Projeto 01. Prompt-only vs. rules-first](./../../projects/project-01-baseline-vs-minimal-harness/index.md)

# Lecture 01. Modelos Fortes Não Significam Execução Confiável

Você se considera bem viajado no mundo da IA — assinatura Claude Pro, chave API GPT-4o, números do leaderboard SWE-bench memorizados. Um dia você finalmente entrega um projeto real para um agente de IA, transbordando de confiança. O resultado? Ele adiciona uma feature mas quebra os testes, corrige um bug mas introduz dois mais, roda por 20 minutos e orgulhosamente declara "pronto" — e você olha para o código e não é o que você pediu.

Seu primeiro instinto? "Este modelo não é bom o suficiente. Hora de fazer upgrade." Espere. Antes de pegar sua carteira, considere que o problema pode não ser o modelo.

Vamos olhar alguns números. No final de 2025, os agentes de codificação mais fortes no SWE-bench Verified alcançam aproximadamente 50-60%. E isso em tarefas cuidadosamente selecionadas com descrições claras de problemas e casos de teste existentes. Mova para seu ambiente de desenvolvimento diário — requisitos vagos, nenhum teste existente, regras de negócio implícitas espalhadas por toda parte — e esse número só diminui.

Mas por trás desses números está uma verdade contraintuitiva.

## Mesmo Cavalo, Destinos Diferentes

A Anthropic executou um experimento controlado. Mesmo prompt ("construa um criador de jogos retrô 2D"), mesmo modelo (Opus 4.5). Primeira execução: bare, sem suporte — 20 minutos, $9, as features centrais do jogo não funcionaram. Segunda execução: harness completo (arquitetura de três agentes: planejador + gerador + avaliador) — 6 horas, $200, o jogo estava jogável.

Eles não mudaram o modelo. Opus 4.5 ainda era Opus 4.5. O que mudou foi a sela.

O artigo de harness engineering da OpenAI de 2025 coloca claramente: Codex em um repositório bem-harnessed vai de "não confiável" para "confiável." Note a redação deles — não "um pouco melhor," mas uma mudança qualitativa. Como um puro-sangue: você pode montá-lo sem sela, mas não irá longe, não irá rápido, e cair não é surpresa. O harness é essa sela — **tudo na infraestrutura de engenharia fora dos pesos do modelo.**

## Onde Agents Realmente Ficam Presos

Então o que especificamente dá errado?

O mais comum: você nunca definiu claramente a tarefa. Você diz "adicione uma feature de busca," e o entendimento do agent é completamente diferente do seu — buscar o quê? Full-text ou estruturada? Paginação? Highlighting? Você não especificou, então o agent adivinha. Um palpite correto é sorte; um errado custa mais para corrigir do que ser específico teria custado em primeiro lugar. É como entrar em um restaurante e dizer ao chef "vou querer peixe" — se você vai receber braseado, no vapor, ou em uma panela quente é inteiramente por acaso.

Mesmo quando você especifica, o projeto tem convenções arquiteturais implícitas que o agent não conhece. Sua equipe padronizou na sintaxe SQLAlchemy 2.0, mas o agent escreve código 1.x por padrão. Todos os endpoints de API devem usar autenticação OAuth 2.0, mas essa regra só existe na sua cabeça e em uma mensagem do Slack de três meses atrás. O agent não consegue ver essas — não é que não quer cumprir, literalmente não sabe que essas regras existem.

O ambiente também é uma armadilha. Ambiente de dev incompleto, dependências faltando, versões erradas de ferramentas. O agent queima janela de contexto preciosa em falhas de `pip install` e incompatibilidades de versão do Node em vez de resolver sua tarefa real. Como contratar um carpinteiro habilidoso mas esquecer de fornecer martelo, pregos ou uma bancada nivelada — não importa quão talentoso, não consegue fazer o trabalho.

Ainda mais comum: simplesmente não há como verificar. Nenhum teste, nenhum lint, ou comandos de verificação nunca comunicados ao agent. O agent escreve código, olha para ele, decide que está bom, diz "pronto." É como pedir a um estudante para entregar lição de casa sem gabarito — eles acham que acertaram, mas quando você corrige há uma pilha de erros. A Anthropic também observou um fenômeno interessante: quando agents sentem que o contexto está acabando, eles se apressam para terminar, pulam verificação e escolhem uma solução simples sobre a ótima. Eles chamam de "ansiedade de contexto" — a mesma coisa que acontece quando você percebe que o tempo está quase acabando em um exame e começa a chutar aleatoriamente nas questões de múltipla escolha restantes.

Tarefas longas abrangendo sessões são ainda piores — todas as descobertas da sessão anterior são perdidas, e toda nova sessão tem que re-explorar a estrutura do projeto e re-entender a organização do código. Agents sem estado persistente veem taxas de falha dispararem drasticamente em tarefas excedendo 30 minutos.

## Terminologia-Chave

Com esses cenários em mente, esses conceitos não são mais apenas jargão:

- **Capability Gap**: O enorme abismo entre performance do modelo em benchmarks e performance em tarefas reais. Uma taxa de aprovação de 50-60% no SWE-bench Verified significa que quase metade dos problemas reais não podem ser resolvidos.
- **Harness**: Tudo fora do modelo — instruções, ferramentas, ambiente, gerenciamento de estado, feedback de verificação. Se não são pesos do modelo, é harness. O que temos chamado de "sela."
- **Harness-Induced Failure**: O modelo tem capacidade suficiente, mas o ambiente de execução tem defeitos estruturais. O experimento controlado da Anthropic já provou isso.
- **Verification Gap**: A lacuna entre a confiança do agent em seu output e correção real. O agent diz "terminei" quando não terminou — este é o modo de falha mais comum.
- **Diagnostic Loop**: Executar, observar falha, atribuir a uma camada específica do harness, corrigir essa camada, re-executar. Esta é a metodologia central da harness engineering.
- **Definition of Done**: Um conjunto de condições verificáveis por máquina — testes passam, lint está limpo, verificações de tipo passam. Sem uma definition of done explícita, o agent inventará a sua própria.

## Quando as Coisas Falham, Corrija o Harness Primeiro

Princípio central: **Quando as coisas falham, não troque o modelo primeiro — verifique o harness.** Se o mesmo modelo tem sucesso em tarefas similares e bem estruturadas, assuma que é um problema de harness. É como um carro quebrando — você não suspeita imediatamente do motor. Você verifica se está sem gasolina primeiro.

Passos concretos:

**Atribua toda falha a uma camada específica.** Não apenas diga "o modelo é ruim." Pergunte: a tarefa estava pouco clara? O contexto era insuficiente? Não havia métodos de verificação? Mapeie cada falha para uma das cinco camadas de falha (especificação de tarefa, provisão de contexto, ambiente de execução, feedback de verificação, gerenciamento de estado). Construa esse hábito, e você encontrará "o modelo não é bom o suficiente" aparecendo cada vez menos em seus logs.

**Escreva uma Definition of Done explícita para toda tarefa.** Não diga "adicione uma feature de busca." Diga:
```
Critérios de conclusão:
- Novo endpoint GET /api/search?q=xxx
- Suporta paginação, padrão 20 itens
- Resultados incluem snippets destacados
- Todo código novo passa pytest
- Verificação de tipo passa (mypy --strict)
```

**Crie um arquivo AGENTS.md.** Coloque na raiz do repo para dizer ao agent o tech stack do projeto, convenções arquiteturais e comandos de verificação. Este é o primeiro passo em harness engineering e o passo de maior ROI que você pode dar. Um arquivo `AGENTS.md` pode ser mais eficaz que fazer upgrade para um modelo mais caro — não estou brincando.

**Construa um diagnostic loop.** Não trate falhas como "o modelo sendo burro de novo." Trate-as como sinais de que seu harness tem um defeito. Cada falha, identifique a camada, corrija, nunca falhe desse jeito novamente. Após algumas rodadas, seu harness fica mais forte e a performance do agent se estabiliza. Como reparo de estrada — cada buraco que você preenche torna o próximo trecho mais suave.

**Quantifique melhorias.** Mantenha um log simples: cada tarefa teve sucesso ou falhou, e qual camada causou a falha. Após algumas rodadas você verá qual camada é o gargalo — foque sua energia lá.

## O Experimento de Um Milhão de Linhas

A OpenAI executou um experimento agressivo em 2025: usar Codex para construir um produto interno completo a partir de um repositório git vazio. Cinco meses depois, o repo tinha aproximadamente um milhão de linhas de código — lógica de aplicação, infraestrutura, ferramentas, documentação, ferramentas internas de dev — tudo gerado por agent. Três engenheiros dirigiram o Codex, abrindo e mergeando cerca de 1.500 PRs. Uma média de 3.5 PRs por pessoa por dia.

A restrição-chave: **humanos nunca escrevem código diretamente.** Isso não era uma pegadinha — foi projetado para forçar a equipe a descobrir o que muda quando o trabalho principal do engenheiro não é mais escrever código, mas projetar ambientes, expressar intenção e construir loops de feedback.

O progresso inicial foi mais lento que o esperado. Não porque o Codex não era capaz, mas porque o ambiente não estava completo o suficiente — o agent carecia de ferramentas, abstrações e estruturas internas necessárias para avançar objetivos de alto nível. O trabalho dos engenheiros se tornou: quebrar grandes objetivos em pequenos blocos de construção (design, código, revisão, teste), deixar o agent montá-los, então usar esses blocos para desbloquear tarefas mais complexas. Quando algo falhava, a correção quase nunca era "tente mais forte" — era "que capacidade o agent está perdendo, e como tornamos isso compreensível e executável?"

Este experimento prova diretamente a tese central desta lecture: **o mesmo modelo produz output fundamentalmente diferente em um ambiente bare versus um com harness completo.** O modelo não mudou. O ambiente mudou.

> Fonte: [OpenAI: Harness engineering: leveraging Codex in an agent-first world](https://openai.com/index/harness-engineering/)

## Um Exemplo Mais Pé-no-Chão

Uma equipe usou Claude Sonnet para adicionar um novo endpoint de API a uma aplicação web Python de tamanho médio (FastAPI + PostgreSQL + Redis, ~15.000 linhas de código).

Inicialmente eles deram apenas uma frase: "adicione endpoints de preferências de usuário sob `/api/v2/users`." O resultado? O agent gastou 40% de sua janela de contexto explorando a estrutura do repo, produziu código que parecia razoável mas não seguia os padrões de tratamento de erro do projeto, usou sintaxe SQLAlchemy antiga, e declarou conclusão enquanto o endpoint tinha erros de runtime. A próxima sessão teve que refazer todo o trabalho de descoberta.

Depois eles adicionaram `AGENTS.md` (descrevendo arquitetura do projeto e versões do tech stack), comandos de verificação explícitos (`pytest tests/api/v2/ && python -m mypy src/`), e registros de decisão arquitetural. O mesmo modelo teve sucesso em todas as três execuções independentes, com ~60% melhor eficiência de contexto.

Eles não mudaram o modelo. Mudaram o harness.

## Principais Takeaways

- Capacidade do modelo e confiabilidade de execução são coisas diferentes. Um puro-sangue ainda precisa de uma boa sela.
- Quando as coisas falham, verifique o harness primeiro, depois o modelo. Trocar modelos é a opção mais cara — e frequentemente nem é um problema de modelo.
- Toda falha é um sinal: seu harness tem um defeito estrutural. Encontre, corrija.
- Cinco camadas de defesa: especificação de tarefa, provisão de contexto, ambiente de execução, feedback de verificação, gerenciamento de estado. Verifique sistematicamente, como um médico descartando as causas mais comuns primeiro.
- Um arquivo `AGENTS.md` pode ser mais eficaz que fazer upgrade para um modelo mais caro. Sério.

## Leitura Adicional

- [OpenAI: Harness Engineering — Leveraging Codex in an Agent-First World](https://openai.com/index/harness-engineering/)
- [Anthropic: Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [HumanLayer: Skill Issue — Harness Engineering for Coding Agents](https://humanlayer.dev/articles/harness-engineering-for-coding-agents/)
- [SWE-bench Leaderboard](https://www.swebench.com/)
- [Thoughtworks Technology Radar: Harness Engineering](https://www.thoughtworks.com/radar)

## Exercícios

1. **Experimento de comparação**: Escolha um codebase que você conhece bem e uma tarefa de modificação não-trivial. Primeiro, execute o agent sem suporte de harness e registre falhas. Então adicione um `AGENTS.md` com comandos de verificação explícitos e execute novamente com o mesmo agent. Compare resultados, atribuindo cada falha a uma das cinco camadas de defesa.

2. **Medição de verification gap**: Escolha 5 tarefas de codificação. Após cada tarefa, registre se o agent reivindica conclusão, então verifique correção real com testes independentes. Calcule a proporção de vezes que o agent reivindica pronto quando na verdade não está pronto — esse é seu verification gap. Então pense: que comandos de verificação reduziriam essa proporção?

3. **Prática de diagnostic loop**: Encontre uma tarefa onde o agent repetidamente falha no seu projeto. Execute uma vez, registre a falha. Atribua a uma das cinco camadas. Corrija essa camada. Execute novamente. Repita três a cinco rodadas, registrando melhorias a cada vez.