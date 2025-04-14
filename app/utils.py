def formatar_preco(valor: float) -> str:
    """Formata o valor em R$ com duas casas decimais."""
    return f"R$ {valor:,.2f}".replace(",", "X").replace(".", ",").replace("X", ".")

def validar_nome(nome: str) -> bool:
    """Verifica se o nome do produto é válido."""
    return nome.strip() != "" and len(nome) > 2

