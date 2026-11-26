ï»¿# skillmanager3x

<div align="center">
  <img src="capa/logo.svg" alt="Arckhé AI" height="48" />
  <p><strong>Arckhé AI</strong></p>
</div>


[![skillmanager3x ê¢â¬â skills de sessêÂ£o](guia/assets/banner.jpg)](https://linnoff88-dev.github.io/arckhe-/guia/)

**ê°Å¸â¡Â§ê°Å¸â¡Â· [PortuguêÂªs](README.md) êÂ· ê°Å¸â¡Âºê°Å¸â¡Â¸ [English](README.en.md) êÂ· ê°Å¸â¡Âªê°Å¸â¡Â¸ [EspaêÂ±ol](README.es.md)**

## O que êÂ©

O skillmanager3x êÂ© um conjunto de skills (instruêÂ§êÂµes prontas em arquivos de texto) para quem usa o Claude Code e trabalha em sessêÂµes longas. Elas resolvem o problema de perder o fio quando a conversa enche: o `session-handoff` grava o estado num arquivo, vocêÂª limpa com `/clear` e o `prime` retoma lendo esse arquivo. HêÂ¡ ainda um checkpoint rêÂ¡pido, uma auditoria da memêÂ³ria e uma barra de status. Para usar, basta copiar as pastas para `~/.claude/skills`.

Biblioteca de **skills de gestêÂ£o de sessêÂ£o** para o [Claude Code](https://claude.ai/code). Templates pequenos e disjuntos que ajudam a manter contexto, memêÂ³ria e transiêÂ§êÂµes entre sessêÂµes sob controle.

## ê°Å¸ââ Guia de uso

Guia completo (landing + passo a passo): **https://linnoff88-dev.github.io/arckhe-/guia/**

## ê¢Â­Â Troca de sessêÂ£o: handoff ê¢â â `/clear` ê¢â â `/prime`

Quando o contexto enche ou a sessêÂ£o jêÂ¡ compactou, nêÂ£o insista na mesma conversa:

1. **`/session-handoff`** grava o que foi feito, o que estêÂ¡ em andamento, a prêÂ³xima aêÂ§êÂ£o exata e o que depende de vocêÂª em `handoffs/history/<UTC>.md` (nunca sobrescreve) e atualiza `handoffs/latest.md`.
2. **`/clear`** zera a conversa (no Codex, abra uma sessêÂ£o nova). Nada se perde: o estado estêÂ¡ no arquivo.
3. **`/prime`** lêÂª `CLAUDE.md`/`AGENTS.md`, `context/`, `tasks/current.md` e `handoffs/latest.md` e devolve um briefing curto. SêÂ³ lêÂª; nêÂ£o retoma deploy, publicaêÂ§êÂ£o ou envio sozinho.

> **Existem duas `session-handoff`.** A versêÂ£o antiga deste repositêÂ³rio (e a que circula em outros kits) sêÂ³ mostrava o resumo no chat: ao dar `/clear` ele sumia e o `/prime` nêÂ£o tinha o que ler. A versêÂ£o atual, em `skill/pt` e `skill/en`, êÂ© a mesma do kit [agente-claude-codex](https://github.com/linnoff88-dev/agente-claude-codex) 1.5.2 e **grava em arquivo** pelo script `scripts/handoff-grava.py` (carimbo do relêÂ³gio da mêÂ¡quina, commit sêÂ³ do handoff, sem push). Desde a 1.4.1 o `handoffs/latest.md` êÂ© um **êÂ­ndice de trabalhos abertos por assunto** + cêÂ³pia do mais novo, e o `prime` lista todos os abertos; êÂ© o mesmo formato que o hook do ExecuêÂ§êÂ£o Longa lêÂª. Para conferir a sua: `grep -c "handoffs/history" ~/.claude/skills/session-handoff/SKILL.md` (0 = versêÂ£o sêÂ³ chat). Desde a 1.5.2 o handoff traz um **bloco de estado gravado pelo script** (commit + sha256 dos arquivos; `handoff-grava.py --conferir` diz se o handoff ficou velho), evidêÂªncia em cada `[confirmed]` e **5 perguntas-teste** que o `prime` responde pelos arquivos e pontua (N/5).

Para trabalho de horas ou dias, veja o **[ExecuêÂ§êÂ£o Longa](https://linnoff88-dev.github.io/arckhe-/guia/)** ([repo](https://github.com/linnoff88-dev/execucao-longa)): o hook que grava o handoff sozinho em ~70% e ~85% do contexto e depois de compactar, os arquivos de estado, o `/goal` e a pesquisa por trêÂ¡s das faixas de contexto.

NêÂ£o hêÂ¡ build, dependêÂªncias nem cêÂ³digo executêÂ¡vel: cada skill êÂ© uma pasta com um `SKILL.md` (markdown + frontmatter YAML) que o Claude Code carrega quando o usuêÂ¡rio fala um dos gatilhos.

## Estrutura

```
skill/
ê¢âÅê¢ââ¬ê¢ââ¬ en/                  versêÂµes em inglêÂªs  (+ README detalhado)
ê¢ââ   ê¢âÅê¢ââ¬ê¢ââ¬ session-handoff/SKILL.md  (+ scripts/handoff-grava.py)
ê¢ââ   ê¢âÅê¢ââ¬ê¢ââ¬ prime/SKILL.md
ê¢ââ   ê¢âÅê¢ââ¬ê¢ââ¬ session-statusline/SKILL.md
ê¢ââ   ê¢ââê¢ââ¬ê¢ââ¬ memory-audit/SKILL.md
ê¢ââê¢ââ¬ê¢ââ¬ pt/                  versêÂµes em portuguêÂªs (+ README detalhado)
    ê¢âÅê¢ââ¬ê¢ââ¬ session-handoff/SKILL.md  (+ scripts/handoff-grava.py)
    ê¢âÅê¢ââ¬ê¢ââ¬ prime/SKILL.md
    ê¢âÅê¢ââ¬ê¢ââ¬ session-statusline/SKILL.md
    ê¢ââê¢ââ¬ê¢ââ¬ memory-audit/SKILL.md

statusline-cmd/          barra de status do terminal (bash, opcional)
ê¢âÅê¢ââ¬ê¢ââ¬ statusline-command.sh   barra (com "ê¢â â projeto ativo")
ê¢âÅê¢ââ¬ê¢ââ¬ install.sh
ê¢âÅê¢ââ¬ê¢ââ¬ cc-projeto.sh           funêÂ§êÂ£o `cc <projeto>`: entra na pasta e abre o Claude
ê¢âÅê¢ââ¬ê¢ââ¬ cc.sh  cc.bat           lanêÂ§ador do Claude Code (Linux / Windows)
ê¢âÅê¢ââ¬ê¢ââ¬ cx.sh  cx.bat           lanêÂ§ador do Codex CLI (Linux / Windows)
ê¢ââê¢ââ¬ê¢ââ¬ README.md
```

Os READMEs em `skill/en/` e `skill/pt/` cobrem decisêÂµes de design, mudanêÂ§as vs. versêÂµes anteriores e dicas avanêÂ§adas. Este README do raiz êÂ© a porta de entrada.

## As skills

Cada uma tem **um trabalho sêÂ³** e gatilhos que nêÂ£o se sobrepêÂµem. Use a tabela abaixo pra escolher:

| Skill | Quando usar | Gatilhos têÂ­picos |
|---|---|---|
| `session-handoff` | fim de sessêÂ£o, antes de `/clear` ou troca de agente | "handoff", "vou dar /clear", "encerrar sessêÂ£o", "passar para outro agente", "wrap up", "resumo final antes de limpar" |
| `prime` | inêÂ­cio da sessêÂ£o nova, depois do `/clear` | "prime", "retoma", "continua de onde parou", "lêÂª o handoff" |
| `session-statusline` | checkpoint rêÂ¡pido **durante** o trabalho | "statusline", "checkpoint", "onde estamos", "como estêÂ¡ a sessêÂ£o", "prêÂ³ximos passos", "organiza/otimiza a sessêÂ£o" |
| `memory-audit` | revisar o que estêÂ¡/deveria estar em memêÂ³ria | "analise a memêÂ³ria", "analise CLAUDE.md", "o que foi guardado", "memêÂ³ria inchada", "limpa memêÂ³ria" |

Regra de bolso: **fim de sessêÂ£o ê¢â â handoff. SessêÂ£o nova ê¢â â prime. "Como estamos?" ê¢â â statusline. "O que tem na memêÂ³ria?" ê¢â â audit.**

---

### 1. `session-handoff` ê¢â¬â passar o bastêÂ£o antes de limpar contexto

Produz um resumo estruturado da sessêÂ£o para um agente futuro pegar de onde vocêÂª parou ê¢â¬â terso, com caminhos, IDs de processos em background, verificaêÂ§êÂ£o real e marcadores de confianêÂ§a (`[confirmed]`, `[unverified]`, `[?]`). Mostra no chat **e grava** em `handoffs/history/<UTC>.md` + `handoffs/latest.md` quando a raiz do projeto tem `handoffs/`, `AGENTS.md` ou `CLAUDE.md`.

**Quando invocar:**
- Antes de `/clear`.
- Antes de trocar de agente (ex: passar trabalho para um subagente em outra janela).
- Quando a conversa atinge >50 turns e vocêÂª quer recomeêÂ§ar enxuto.

**Exemplo de uso:**

```
UsuêÂ¡rio: vou dar /clear, faz handoff antes
```

O Claude mostra no chat e grava em `handoffs/history/2026-10-13T014500Z.md` (e copia para `handoffs/latest.md`), no formato:

```
# Handoff ê¢â¬â 2026-10-13 ê¢â¬â refatoraêÂ§êÂ£o do middleware de auth

## Projeto e escopo
~/projetos/api. Extrair a validaêÂ§êÂ£o de JWT do middleware monolêÂ­tico, mantendo tokens v1.

## Estado aceito
- [confirmed] auth/jwt_validator.py extraêÂ­do de middleware.py:45-180

## Proposto / tentado, nêÂ£o confirmado
- [unverified] cache de chaves pêÂºblicas com TTL de 5min ê¢â¬â cêÂ³digo pronto, sem teste
- [?] migraêÂ§êÂ£o v1ê¢â âv2 ê¢â¬â usuêÂ¡rio queria revisar antes de mergear

## VerificaêÂ§êÂ£o
- Rodado: `pytest tests/auth/ -v` ê¢â â 12 passed
- NêÂ£o rodado: teste de carga ê¢â¬â sem ambiente

## Estado em execuêÂ§êÂ£o
- Processos em segundo plano: shell_a3f ê¢â â pytest --watch (kill: KillShell shell_a3f)

## PrêÂ³xima aêÂ§êÂ£o exata
Revisar com o usuêÂ¡rio se a migraêÂ§êÂ£o v1ê¢â âv2 entra agora (precisa do ok dele).

## Mapa de retomada
- `auth/jwt_validator.py` ê¢â¬â nêÂºcleo da extraêÂ§êÂ£o

## Checagem de compartilhamento
- Sem segredos, tokens ou dados pessoais: sim
```

**Na sessêÂ£o nova**, depois do `/clear`, rode `/prime`: ele lêÂª `handoffs/latest.md` (e `CLAUDE.md`/`AGENTS.md`, `context/`, `tasks/current.md`) e devolve objetivo, regra principal com fonte, êÂºltima decisêÂ£o, prêÂ³xima aêÂ§êÂ£o e conflitos.

---

### 2. `session-statusline` ê¢â¬â checkpoint rêÂ¡pido durante o trabalho

Snapshot operacional curto: foco atual, contexto, decisêÂµes recentes, candidatos a memêÂ³ria e qual o prêÂ³ximo movimento (continuar, compactar, auditar, dar handoff ou limpar). Use quando quer ver o estado sem encerrar.

**Quando invocar:**
- SessêÂ£o comeêÂ§ou a parecer ruidosa e vocêÂª quer um norte.
- Acabou uma fase do trabalho e quer decidir se continua ou troca de têÂ¡tica.
- Quer saber o que o Claude jêÂ¡ guardou na memêÂ³ria **nesta sessêÂ£o**.

**Exemplo de uso:**

```
UsuêÂ¡rio: statusline
```

O Claude responde:

```
# Statusline

## Estado
- Foco atual: ajustar paginaêÂ§êÂ£o do endpoint /users
- Contexto: moderado
- Risco principal: ainda nêÂ£o rodamos teste de carga com >10k registros

## O que ficou guardado na memêÂ³ria
- Guardado confirmado: none
- Candidatos para memêÂ³ria: usuêÂ¡rio prefere keyset pagination sobre offset (decisêÂ£o dessa sessêÂ£o)
- NêÂ£o guardar: greps falhos no inêÂ­cio, tentativa descartada com cursor base64

## HistêÂ³rico curto
- Feito agora: implementado keyset em users_repo.py, ajustado schema da resposta
- DecisêÂµes recentes: descartado offset por instabilidade com inserts concorrentes
- Arquivos relevantes: /api/users.py, /repo/users_repo.py

## PrêÂ³ximos passos
1. Rodar teste com 50k registros e medir latêÂªncia
2. Atualizar OpenAPI schema
3. Decidir se vale guardar a preferêÂªncia por keyset na memêÂ³ria

## RecomendaêÂ§êÂ£o
continuar
```

A linha **RecomendaêÂ§êÂ£o** no fim te diz qual skill (ou nenhuma) faz sentido em seguida.

---

### 3. `memory-audit` ê¢â¬â revisar o que estêÂ¡ em memêÂ³ria

Auditoria do que estêÂ¡ (ou deveria estar) em `~/.claude/projects/<projeto>/memory/` e no `CLAUDE.md` do projeto. Distingue **fato durêÂ¡vel** (mantêÂ©m), **estado de curto prazo** (descarta) e **ruêÂ­do** (remove).

**Quando invocar:**
- MemêÂ³ria parece inchada ou contraditêÂ³ria.
- Vai comeêÂ§ar projeto novo e quer enxugar antes.
- Saiu uma sessêÂ£o grande e vocêÂª quer revisar o que ficou registrado.

**Exemplo de uso:**

```
UsuêÂ¡rio: analise a memêÂ³ria do projeto, têÂ¡ bagunêÂ§ada
```

O Claude responde com inventêÂ¡rio tipo:

```
# Memory Audit

## Manter (fatos durêÂ¡veis)
- user_role.md ê¢â â user êÂ© eng. backend Go, novo em React
- feedback_testing.md ê¢â â testes de integraêÂ§êÂ£o devem bater no Postgres real (incidente Q3/2025)

## Considerar mover pro CLAUDE.md
- project_auth_rewrite.md ê¢â â contexto de motivaêÂ§êÂ£o (compliance) ê¢â¬â vale na doc do projeto

## Remover (curto prazo / ruêÂ­do)
- session_2026-04-15.md ê¢â â estado de sessêÂ£o antiga, irrelevante
- bug_fix_recipe_xyz.md ê¢â â fix jêÂ¡ aplicado, cêÂ³digo fala por si

## Pontos de atenêÂ§êÂ£o
- DuplicaêÂ§êÂ£o: feedback_pr_size.md e feedback_review_style.md cobrem tema parecido
- Stale: reference_grafana.md aponta pra dashboard que mudou de URL
```

A saêÂ­da êÂ© **recomendaêÂ§êÂ£o, nêÂ£o execuêÂ§êÂ£o**. Se quiser que o Claude aplique os cortes, peêÂ§a em uma segunda etapa: "ok, aplica isso".

---

## InstalaêÂ§êÂ£o

Para o Claude Code reconhecer as skills, copie a pasta de cada skill para uma das pastas que o harness varre:

- **Global (todas as sessêÂµes):** `~/.claude/skills/<skill>/`
- **Por projeto:** `<projeto>/.claude/skills/<skill>/`

Exemplo (instalaêÂ§êÂ£o global das skills em portuguêÂªs):

```bash
mkdir -p ~/.claude/skills
cp -r skill/pt/session-handoff   ~/.claude/skills/
cp -r skill/pt/prime             ~/.claude/skills/
cp -r skill/pt/session-statusline ~/.claude/skills/
cp -r skill/pt/memory-audit       ~/.claude/skills/
```

> Cada pasta vai inteira, com o `SKILL.md` dentro ê¢â¬â nêÂ£o achate.

Para verificar que registrou, use `/skills` no Claude Code.

## BêÂ´nus: `statusline-cmd` ê¢â¬â a barra de status do terminal

AlêÂ©m das skills, o repo traz uma **statusline** para o Claude Code: a linha fixa que aparece abaixo do input, mostrando onde vocêÂª estêÂ¡, com qual modelo, quanto de contexto sobrou e quanto do seu limite jêÂ¡ foi.

```
nmaldaner@spark-922b:~/projetos/wifi ê¢â â portal Opus 5.5/medium ctx 24% 5h:30%ê¢â â03:59 w:62% F:1%ê¢â â19/10 20:59 d:28.8M
```

| Campo | Significado |
|---|---|
| `user@host:cwd` | usuêÂ¡rio, mêÂ¡quina e pasta onde a sessêÂ£o foi aberta (fica fixa) |
| `ê¢â â portal` | **projeto ativo**: em amarelo quando o Claude estêÂ¡ mexendo em outro projeto de `~/projetos` (sem gastar crêÂ©dito) |
| `Opus 5.5/medium` | modelo e nêÂ­vel de esforêÂ§o da sessêÂ£o (acompanha o `/model`) |
| `ctx 24%` | quanto da janela de contexto jêÂ¡ foi usado |
| `5h:30%ê¢â â03:59` | limite de 5 horas usado e hora do reset |
| `w:62%` | limite semanal geral usado |
| `F:1%ê¢â â19/10 20:59` | limite semanal **por modelo** (inicial do modelo) e reset |
| `d:28.8M` | tokens somados hoje, em todas as sessêÂµes locais |

Junto vêÂªm a funêÂ§êÂ£o **`cc <projeto>`** (entra na pasta do projeto e abre o Claude; aceita nome parcial) e os lanêÂ§adores **`cc.sh`/`cc.bat`** (Claude Code) e **`cx.sh`/`cx.bat`** (Codex CLI) para Linux e Windows.

**O comando:**

```bash
git clone https://github.com/linnoff88-dev/skillmanager3x
bash skillmanager3x/statusline-cmd/install.sh
```

O instalador copia o script para `~/.claude/statusline-command.sh`, registra o bloco `statusLine` no `~/.claude/settings.json` **preservando o resto do arquivo** (com backup `.bak`) e mostra uma prêÂ©via. A barra aparece no prêÂ³ximo render ê¢â¬â nêÂ£o precisa reiniciar sessêÂ£o.

Remover: `bash statusline-cmd/install.sh --uninstall`.

Requisitos: `jq`, `curl`, `python3` e o `date` do GNU. Os limites 5h/semanal vêÂªm do endpoint `api/oauth/usage` usando **as suas prêÂ³prias credenciais** (`~/.claude/.credentials.json`) ê¢â¬â nada de token vai no repo. Detalhes e personalizaêÂ§êÂ£o em [`statusline-cmd/README.md`](statusline-cmd/README.md).

> A skill `session-statusline` e a pasta `statusline-cmd` têÂªm nomes parecidos e propêÂ³sitos diferentes: a skill escreve um **checkpoint em texto** quando vocêÂª pede; a pasta instala a **barra fixa** do terminal.

## ConvenêÂ§êÂ£o en/pt

`skill/en/` e `skill/pt/` têÂªm a mesma estrutura. O `name` êÂ© igual nas duas; a `description` **inclui gatilhos em portuguêÂªs** quando aplicêÂ¡vel (`"vou dar /clear"`, `"encerrar sessêÂ£o"`, `"retoma"`, etc.). `session-handoff` e `prime` em `skill/pt/` sêÂ£o cêÂ³pia exata das versêÂµes do kit [agente-claude-codex](https://github.com/linnoff88-dev/agente-claude-codex) 1.5.2; as de `skill/en/` sêÂ£o a traduêÂ§êÂ£o fiel.

Ao editar uma skill, sincronize as duas versêÂµes.

---

<div align="center">
  <img src="capa/logo.svg" alt="Arckhé AI" height="32" />
  <p><strong>Arckhé AI</strong></p>
</div>