import streamlit as st
from app.azure_db import inserir_produto
from app.azure_blob import upload_imagem
import os
from dotenv import load_dotenv

load_dotenv()

st.set_page_config(page_title="Mercado-DIO", layout="centered")

st.title("🛒 Mercado DIO - Cadastro de Produtos")

nome = st.text_input("Nome do produto")
preco = st.number_input("Preço", min_value=0.0, format="%.2f")
imagem = st.file_uploader("Upload da imagem")

if st.button("Cadastrar Produto"):
    if nome and preco and imagem:
        blob_url = upload_imagem(imagem)
        inserir_produto(nome, preco, blob_url)
        st.success("Produto cadastrado com sucesso!")
    else:
        st.error("Preencha todos os campos")

