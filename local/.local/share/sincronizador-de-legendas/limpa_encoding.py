import sys

def main():
    if len(sys.argv) < 2:
        return
    
    arquivo = sys.argv[1]
    
    # Tenta ler como UTF-8 primeiro. Se passar, o arquivo já está perfeito.
    try:
        with open(arquivo, 'r', encoding='utf-8') as f:
            f.read()
    except UnicodeDecodeError:
        # Se infartar, é porque está em Latin-1/Windows-1252. 
        # Lemos no formato velho e reescrevemos no novo.
        print(f"[*] Limpando encoding jurássico de: {arquivo}")
        with open(arquivo, 'r', encoding='latin-1') as f:
            texto = f.read()
        with open(arquivo, 'w', encoding='utf-8') as f:
            f.write(texto)

if __name__ == "__main__":
    main()
