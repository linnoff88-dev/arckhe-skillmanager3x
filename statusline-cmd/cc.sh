#!/usr/bin/env bash
# Abre o Claude Code na pasta atual com as flags do INEMA. Argumentos extras passam adiante (ex.: cc.sh -c).
# ATENÇêO: --dangerously-skip-permissions roda tudo sem pedir permissêo — use só em máquina sua.
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=64000
claude --chrome --dangerously-skip-permissions --exclude-dynamic-system-prompt-sections "$@"
