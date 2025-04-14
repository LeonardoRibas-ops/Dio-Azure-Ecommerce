import pyodbc
import os

def conectar():
    conn = pyodbc.connect(
        f"DRIVER={{ODBC Driver 17 for SQL Server}};"
        f"SERVER={os.getenv('AZURE_SQL_SERVER')};"
        f"DATABASE={os.getenv('AZURE_SQL_DATABASE')};"
        f"UID={os.getenv('AZURE_SQL_USERNAME')};"
        f"PWD={os.getenv('AZURE_SQL_PASSWORD')}"
    )
    return conn

def inserir_produto(nome, preco, imagem_url):
    conn = conectar()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO produtos (nome, preco, imagem_url) VALUES (?, ?, ?)", nome, preco, imagem_url)
    conn.commit()
    conn.close()

