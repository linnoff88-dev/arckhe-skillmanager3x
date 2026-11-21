# skillmanager3x

<div align="center">
  <img src="capa/logo.svg" alt="Arckhé AI" height="48" />
  <p><strong>Arckhé AI</strong></p>
</div>


[![skillmanager3x â€” skills de sessÃ£o](guia/assets/banner.jpg)](https://inematds.github.io/skillmanager3x/guia/)

**ðŸ‡§ðŸ‡· [PortuguÃªs](README.md) Â· ðŸ‡ºðŸ‡¸ [English](README.en.md) Â· ðŸ‡ªðŸ‡¸ [EspaÃ±ol](README.es.md)**

## O que Ã©

O skillmanager3x Ã© um conjunto de skills (instruÃ§Ãµes prontas em arquivos de texto) para quem usa o Claude Code e trabalha em sessÃµes longas. Elas resolvem o problema de perder o fio quando a conversa enche: o `session-handoff` grava o estado num arquivo, vocÃª limpa com `/clear` e o `prime` retoma lendo esse arquivo. HÃ¡ ainda um checkpoint rÃ¡pido, uma auditoria da memÃ³ria e uma barra de status. Para usar, basta copiar as pastas para `~/.claude/skills`.

Biblioteca de **skills de gestÃ£o de sessÃ£o** para o [Claude Code](https://claude.ai/code). Templates pequenos e disjuntos que ajudam a manter contexto, memÃ³ria e transiÃ§Ãµes entre sessÃµes sob controle.

## ðŸ“– Guia de uso

Guia completo (landing + passo a passo): **https://inematds.github.io/skillmanager3x/guia/**

## â­ Troca de sessÃ£o: handoff â†’ `/clear` â†’ `/prime`

Quando o contexto enche ou a sessÃ£o jÃ¡ compactou, nÃ£o insista na mesma conversa:

1. **`/session-handoff`** grava o que foi feito, o que estÃ¡ em andamento, a prÃ³xima aÃ§Ã£o exata e o que depende de vocÃª em `handoffs/history/<UTC>.md` (nunca sobrescreve) e atualiza `handoffs/latest.md`.
2. **`/clear`** zera a conversa (no Codex, abra uma sessÃ£o nova). Nada se perde: o estado estÃ¡ no arquivo.
3. **`/prime`** lÃª `CLAUDE.md`/`AGENTS.md`, `context/`, `tasks/current.md` e `handoffs/latest.md` e devolve um briefing curto. SÃ³ lÃª; nÃ£o retoma deploy, publicaÃ§Ã£o ou envio sozinho.

> **Existem duas `session-handoff`.** A versÃ£o antiga deste repositÃ³rio (e a que circula em outros kits) sÃ³ mostrava o resumo no chat: ao dar `/clear` ele sumia e o `/prime` nÃ£o tinha o que ler. A versÃ£o atual, em `skill/pt` e `skill/en`, Ã© a mesma do kit [agente-claude-codex](https://github.com/inematds/agente-claude-codex) 1.5.2 e **grava em arquivo** pelo script `scripts/handoff-grava.py` (carimbo do relÃ³gio da mÃ¡quina, commit sÃ³ do handoff, sem push). Desde a 1.4.1 o `handoffs/latest.md` Ã© um **Ã­ndice de trabalhos abertos por assunto** + cÃ³pia do mais novo, e o `prime` lista todos os abertos; Ã© o mesmo formato que o hook do ExecuÃ§Ã£o Longa lÃª. Para conferir a sua: `grep -c "handoffs/history" ~/.claude/skills/session-handoff/SKILL.md` (0 = versÃ£o sÃ³ chat). Desde a 1.5.2 o handoff traz um **bloco de estado gravado pelo script** (commit + sha256 dos arquivos; `handoff-grava.py --conferir` diz se o handoff ficou velho), evidÃªncia em cada `[confirmed]` e **5 perguntas-teste** que o `prime` responde pelos arquivos e pontua (N/5).

Para trabalho de horas ou dias, veja o **[ExecuÃ§Ã£o Longa](https://inematds.github.io/execucao-longa/guia/)** ([repo](https://github.com/inematds/execucao-longa)): o hook que grava o handoff sozinho em ~70% e ~85% do contexto e depois de compactar, os arquivos de estado, o `/goal` e a pesquisa por trÃ¡s das faixas de contexto.

NÃ£o hÃ¡ build, dependÃªncias nem cÃ³digo executÃ¡vel: cada skill Ã© uma pasta com um `SKILL.md` (markdown + frontmatter YAML) que o Claude Code carrega quando o usuÃ¡rio fala um dos gatilhos.

## Estrutura

```
skill/
â”œâ”€â”€ en/                  versÃµes em inglÃªs  (+ README detalhado)
â”‚   â”œâ”€â”€ session-handoff/SKILL.md  (+ scripts/handoff-grava.py)
â”‚   â”œâ”€â”€ prime/SKILL.md
â”‚   â”œâ”€â”€ session-statusline/SKILL.md
â”‚   â””â”€â”€ memory-audit/SKILL.md
â””â”€â”€ pt/                  versÃµes em portuguÃªs (+ README detalhado)
    â”œâ”€â”€ session-handoff/SKILL.md  (+ scripts/handoff-grava.py)
    â”œâ”€â”€ prime/SKILL.md
    â”œâ”€â”€ session-statusline/SKILL.md
    â””â”€â”€ memory-audit/SKILL.md

statusline-cmd/          barra de status do terminal (bash, opcional)
â”œâ”€â”€ statusline-command.sh   barra (com "â†’ projeto ativo")
â”œâ”€â”€ install.sh
â”œâ”€â”€ cc-projeto.sh           funÃ§Ã£o `cc <projeto>`: entra na pasta e abre o Claude
â”œâ”€â”€ cc.sh  cc.bat           lanÃ§ador do Claude Code (Linux / Windows)
â”œâ”€â”€ cx.sh  cx.bat           lanÃ§ador do Codex CLI (Linux / Windows)
â””â”€â”€ README.md
```

Os READMEs em `skill/en/` e `skill/pt/` cobrem decisÃµes de design, mudanÃ§as vs. versÃµes anteriores e dicas avanÃ§adas. Este README do raiz Ã© a porta de entrada.

## As skills

Cada uma tem **um trabalho sÃ³** e gatilhos que nÃ£o se sobrepÃµem. Use a tabela abaixo pra escolher:

| Skill | Quando usar | Gatilhos tÃ­picos |
|---|---|---|
| `session-handoff` | fim de sessÃ£o, antes de `/clear` ou troca de agente | "handoff", "vou dar /clear", "encerrar sessÃ£o", "passar para outro agente", "wrap up", "resumo final antes de limpar" |
| `prime` | inÃ­cio da sessÃ£o nova, depois do `/clear` | "prime", "retoma", "continua de onde parou", "lÃª o handoff" |
| `session-statusline` | checkpoint rÃ¡pido **durante** o trabalho | "statusline", "checkpoint", "onde estamos", "como estÃ¡ a sessÃ£o", "prÃ³ximos passos", "organiza/otimiza a sessÃ£o" |
| `memory-audit` | revisar o que estÃ¡/deveria estar em memÃ³ria | "analise a memÃ³ria", "analise CLAUDE.md", "o que foi guardado", "memÃ³ria inchada", "limpa memÃ³ria" |

Regra de bolso: **fim de sessÃ£o â†’ handoff. SessÃ£o nova â†’ prime. "Como estamos?" â†’ statusline. "O que tem na memÃ³ria?" â†’ audit.**

---

### 1. `session-handoff` â€” passar o bastÃ£o antes de limpar contexto

Produz um resumo estruturado da sessÃ£o para um agente futuro pegar de onde vocÃª parou â€” terso, com caminhos, IDs de processos em background, verificaÃ§Ã£o real e marcadores de confianÃ§a (`[confirmed]`, `[unverified]`, `[?]`). Mostra no chat **e grava** em `handoffs/history/<UTC>.md` + `handoffs/latest.md` quando a raiz do projeto tem `handoffs/`, `AGENTS.md` ou `CLAUDE.md`.

**Quando invocar:**
- Antes de `/clear`.
- Antes de trocar de agente (ex: passar trabalho para um subagente em outra janela).
- Quando a conversa atinge >50 turns e vocÃª quer recomeÃ§ar enxuto.

**Exemplo de uso:**

```
UsuÃ¡rio: vou dar /clear, faz handoff antes
```

O Claude mostra no chat e grava em `handoffs/history/2026-10-13T014500Z.md` (e copia para `handoffs/latest.md`), no formato:

```
# Handoff â€” 2026-10-13 â€” refatoraÃ§Ã£o do middleware de auth

## Projeto e escopo
~/projetos/api. Extrair a validaÃ§Ã£o de JWT do middleware monolÃ­tico, mantendo tokens v1.

## Estado aceito
- [confirmed] auth/jwt_validator.py extraÃ­do de middleware.py:45-180

## Proposto / tentado, nÃ£o confirmado
- [unverified] cache de chaves pÃºblicas com TTL de 5min â€” cÃ³digo pronto, sem teste
- [?] migraÃ§Ã£o v1â†’v2 â€” usuÃ¡rio queria revisar antes de mergear

## VerificaÃ§Ã£o
- Rodado: `pytest tests/auth/ -v` â†’ 12 passed
- NÃ£o rodado: teste de carga â€” sem ambiente

## Estado em execuÃ§Ã£o
- Processos em segundo plano: shell_a3f â†’ pytest --watch (kill: KillShell shell_a3f)

## PrÃ³xima aÃ§Ã£o exata
Revisar com o usuÃ¡rio se a migraÃ§Ã£o v1â†’v2 entra agora (precisa do ok dele).

## Mapa de retomada
- `auth/jwt_validator.py` â€” nÃºcleo da extraÃ§Ã£o

## Checagem de compartilhamento
- Sem segredos, tokens ou dados pessoais: sim
```

**Na sessÃ£o nova**, depois do `/clear`, rode `/prime`: ele lÃª `handoffs/latest.md` (e `CLAUDE.md`/`AGENTS.md`, `context/`, `tasks/current.md`) e devolve objetivo, regra principal com fonte, Ãºltima decisÃ£o, prÃ³xima aÃ§Ã£o e conflitos.

---

### 2. `session-statusline` â€” checkpoint rÃ¡pido durante o trabalho

Snapshot operacional curto: foco atual, contexto, decisÃµes recentes, candidatos a memÃ³ria e qual o prÃ³ximo movimento (continuar, compactar, auditar, dar handoff ou limpar). Use quando quer ver o estado sem encerrar.

**Quando invocar:**
- SessÃ£o comeÃ§ou a parecer ruidosa e vocÃª quer um norte.
- Acabou uma fase do trabalho e quer decidir se continua ou troca de tÃ¡tica.
- Quer saber o que o Claude jÃ¡ guardou na memÃ³ria **nesta sessÃ£o**.

**Exemplo de uso:**

```
UsuÃ¡rio: statusline
```

O Claude responde:

```
# Statusline

## Estado
- Foco atual: ajustar paginaÃ§Ã£o do endpoint /users
- Contexto: moderado
- Risco principal: ainda nÃ£o rodamos teste de carga com >10k registros

## O que ficou guardado na memÃ³ria
- Guardado confirmado: none
- Candidatos para memÃ³ria: usuÃ¡rio prefere keyset pagination sobre offset (decisÃ£o dessa sessÃ£o)
- NÃ£o guardar: greps falhos no inÃ­cio, tentativa descartada com cursor base64

## HistÃ³rico curto
- Feito agora: implementado keyset em users_repo.py, ajustado schema da resposta
- DecisÃµes recentes: descartado offset por instabilidade com inserts concorrentes
- Arquivos relevantes: /api/users.py, /repo/users_repo.py

## PrÃ³ximos passos
1. Rodar teste com 50k registros e medir latÃªncia
2. Atualizar OpenAPI schema
3. Decidir se vale guardar a preferÃªncia por keyset na memÃ³ria

## RecomendaÃ§Ã£o
continuar
```

A linha **RecomendaÃ§Ã£o** no fim te diz qual skill (ou nenhuma) faz sentido em seguida.

---

### 3. `memory-audit` â€” revisar o que estÃ¡ em memÃ³ria

Auditoria do que estÃ¡ (ou deveria estar) em `~/.claude/projects/<projeto>/memory/` e no `CLAUDE.md` do projeto. Distingue **fato durÃ¡vel** (mantÃ©m), **estado de curto prazo** (descarta) e **ruÃ­do** (remove).

**Quando invocar:**
- MemÃ³ria parece inchada ou contraditÃ³ria.
- Vai comeÃ§ar projeto novo e quer enxugar antes.
- Saiu uma sessÃ£o grande e vocÃª quer revisar o que ficou registrado.

**Exemplo de uso:**

```
UsuÃ¡rio: analise a memÃ³ria do projeto, tÃ¡ bagunÃ§ada
```

O Claude responde com inventÃ¡rio tipo:

```
# Memory Audit

## Manter (fatos durÃ¡veis)
- user_role.md â†’ user Ã© eng. backend Go, novo em React
- feedback_testing.md â†’ testes de integraÃ§Ã£o devem bater no Postgres real (incidente Q3/2025)

## Considerar mover pro CLAUDE.md
- project_auth_rewrite.md â†’ contexto de motivaÃ§Ã£o (compliance) â€” vale na doc do projeto

## Remover (curto prazo / ruÃ­do)
- session_2026-04-15.md â†’ estado de sessÃ£o antiga, irrelevante
- bug_fix_recipe_xyz.md â†’ fix jÃ¡ aplicado, cÃ³digo fala por si

## Pontos de atenÃ§Ã£o
- DuplicaÃ§Ã£o: feedback_pr_size.md e feedback_review_style.md cobrem tema parecido
- Stale: reference_grafana.md aponta pra dashboard que mudou de URL
```

A saÃ­da Ã© **recomendaÃ§Ã£o, nÃ£o execuÃ§Ã£o**. Se quiser que o Claude aplique os cortes, peÃ§a em uma segunda etapa: "ok, aplica isso".

---

## InstalaÃ§Ã£o

Para o Claude Code reconhecer as skills, copie a pasta de cada skill para uma das pastas que o harness varre:

- **Global (todas as sessÃµes):** `~/.claude/skills/<skill>/`
- **Por projeto:** `<projeto>/.claude/skills/<skill>/`

Exemplo (instalaÃ§Ã£o global das skills em portuguÃªs):

```bash
mkdir -p ~/.claude/skills
cp -r skill/pt/session-handoff   ~/.claude/skills/
cp -r skill/pt/prime             ~/.claude/skills/
cp -r skill/pt/session-statusline ~/.claude/skills/
cp -r skill/pt/memory-audit       ~/.claude/skills/
```

> Cada pasta vai inteira, com o `SKILL.md` dentro â€” nÃ£o achate.

Para verificar que registrou, use `/skills` no Claude Code.

## BÃ´nus: `statusline-cmd` â€” a barra de status do terminal

AlÃ©m das skills, o repo traz uma **statusline** para o Claude Code: a linha fixa que aparece abaixo do input, mostrando onde vocÃª estÃ¡, com qual modelo, quanto de contexto sobrou e quanto do seu limite jÃ¡ foi.

```
nmaldaner@spark-922b:~/projetos/wifi â†’ portal Opus 5.5/medium ctx 24% 5h:30%â†’03:59 w:62% F:1%â†’19/10 20:59 d:28.8M
```

| Campo | Significado |
|---|---|
| `user@host:cwd` | usuÃ¡rio, mÃ¡quina e pasta onde a sessÃ£o foi aberta (fica fixa) |
| `â†’ portal` | **projeto ativo**: em amarelo quando o Claude estÃ¡ mexendo em outro projeto de `~/projetos` (sem gastar crÃ©dito) |
| `Opus 5.5/medium` | modelo e nÃ­vel de esforÃ§o da sessÃ£o (acompanha o `/model`) |
| `ctx 24%` | quanto da janela de contexto jÃ¡ foi usado |
| `5h:30%â†’03:59` | limite de 5 horas usado e hora do reset |
| `w:62%` | limite semanal geral usado |
| `F:1%â†’19/10 20:59` | limite semanal **por modelo** (inicial do modelo) e reset |
| `d:28.8M` | tokens somados hoje, em todas as sessÃµes locais |

Junto vÃªm a funÃ§Ã£o **`cc <projeto>`** (entra na pasta do projeto e abre o Claude; aceita nome parcial) e os lanÃ§adores **`cc.sh`/`cc.bat`** (Claude Code) e **`cx.sh`/`cx.bat`** (Codex CLI) para Linux e Windows.

**O comando:**

```bash
git clone https://github.com/inematds/skillmanager3x
bash skillmanager3x/statusline-cmd/install.sh
```

O instalador copia o script para `~/.claude/statusline-command.sh`, registra o bloco `statusLine` no `~/.claude/settings.json` **preservando o resto do arquivo** (com backup `.bak`) e mostra uma prÃ©via. A barra aparece no prÃ³ximo render â€” nÃ£o precisa reiniciar sessÃ£o.

Remover: `bash statusline-cmd/install.sh --uninstall`.

Requisitos: `jq`, `curl`, `python3` e o `date` do GNU. Os limites 5h/semanal vÃªm do endpoint `api/oauth/usage` usando **as suas prÃ³prias credenciais** (`~/.claude/.credentials.json`) â€” nada de token vai no repo. Detalhes e personalizaÃ§Ã£o em [`statusline-cmd/README.md`](statusline-cmd/README.md).

> A skill `session-statusline` e a pasta `statusline-cmd` tÃªm nomes parecidos e propÃ³sitos diferentes: a skill escreve um **checkpoint em texto** quando vocÃª pede; a pasta instala a **barra fixa** do terminal.

## ConvenÃ§Ã£o en/pt

`skill/en/` e `skill/pt/` tÃªm a mesma estrutura. O `name` Ã© igual nas duas; a `description` **inclui gatilhos em portuguÃªs** quando aplicÃ¡vel (`"vou dar /clear"`, `"encerrar sessÃ£o"`, `"retoma"`, etc.). `session-handoff` e `prime` em `skill/pt/` sÃ£o cÃ³pia exata das versÃµes do kit [agente-claude-codex](https://github.com/inematds/agente-claude-codex) 1.5.2; as de `skill/en/` sÃ£o a traduÃ§Ã£o fiel.

Ao editar uma skill, sincronize as duas versÃµes.

---

<div align="center">
  <img src="capa/logo.svg" alt="Arckhé AI" height="32" />
  <p><strong>Arckhé AI</strong></p>
</div>