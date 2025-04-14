#!/bin/bash

# 💬 Nomes de recursos (modifique conforme seu projeto)
RG="rg-mercado-dio"
LOCATION="eastus"
STORAGE_NAME="mercadodiostorage$RANDOM"
CONTAINER_NAME="produtos"
SQL_SERVER_NAME="sqlmercadodio$RANDOM"
SQL_DB_NAME="mercado_dio"
ADMIN_USER="dioadmin"
ADMIN_PASS="SenhaSuperForte123!"  # Troque por uma senha segura

echo "🔧 Criando Resource Group..."
az group create --name $RG --location $LOCATION

echo "📦 Criando conta de armazenamento..."
az storage account create \
    --name $STORAGE_NAME \
    --resource-group $RG \
    --location $LOCATION \
    --sku Standard_LRS

echo "🪣 Criando container Blob..."
CONN_STRING=$(az storage account show-connection-string -g $RG -n $STORAGE_NAME --query connectionString -o tsv)
az storage container create \
    --name $CONTAINER_NAME \
    --account-name $STORAGE_NAME

echo "🧠 Criando servidor SQL..."
az sql server create \
    --name $SQL_SERVER_NAME \
    --resource-group $RG \
    --location $LOCATION \
    --admin-user $ADMIN_USER \
    --admin-password $ADMIN_PASS

echo "💾 Criando banco de dados SQL..."
az sql db create \
    --resource-group $RG \
    --server $SQL_SERVER_NAME \
    --name $SQL_DB_NAME \
    --service-objective S0

echo "🌐 Liberando firewall para IP atual..."
MY_IP=$(curl -s ifconfig.me)
az sql server firewall-rule create \
    --resource-group $RG \
    --server $SQL_SERVER_NAME \
    --name "AllowMyIP" \
    --start-ip-address $MY_IP \
    --end-ip-address $MY_IP

echo ""
echo "✅ Tudo pronto!"
echo ""
echo "📋 Copie essas variáveis para o seu .env:"
echo "-----------------------------------------"
echo "AZURE_STORAGE_CONNECTION_STRING=$CONN_STRING"
echo "AZURE_CONTAINER_NAME=$CONTAINER_NAME"
echo "AZURE_SQL_SERVER=$SQL_SERVER_NAME.database.windows.net"
echo "AZURE_SQL_DATABASE=$SQL_DB_NAME"
echo "AZURE_SQL_USERNAME=$ADMIN_USER"
echo "AZURE_SQL_PASSWORD=$ADMIN_PASS"
