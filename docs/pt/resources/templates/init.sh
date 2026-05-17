#!/bin/bash

# Script de inicialização padrão
# Edite estas variáveis para corresponder ao seu projeto

INSTALL_CMD="npm install"  # ou "pip install -r requirements.txt", "yarn install", etc.
VERIFY_CMD="npm test"      # ou "pytest", "make test", etc.
START_CMD="npm run dev"    # ou "python app.py", "make serve", etc.

echo "=== Inicializando projeto ==="
echo "Diretório atual: $(pwd)"
echo

echo "=== Instalando dependências ==="
$INSTALL_CMD
if [ $? -ne 0 ]; then
    echo "❌ Falha na instalação de dependências"
    exit 1
fi
echo "✅ Dependências instaladas"
echo

echo "=== Executando verificação ==="
$VERIFY_CMD
if [ $? -ne 0 ]; then
    echo "❌ Verificação falhou - corrija antes de continuar"
    exit 1
fi
echo "✅ Verificação passou"
echo

echo "=== Pronto para começar ==="
echo "Para iniciar o servidor de desenvolvimento:"
echo "  $START_CMD"
echo

# Descomente a linha abaixo para iniciar automaticamente o servidor
# $START_CMD