import pyodbc
import pandas as pd

df = pd.read_csv("arquivos/consolidated/movies_consolidado.csv") # Agora procura o consolidated

df.head()

df.columns

conn = pyodbc.connect(
    Driver = '{ODBC Driver 17 for SQL Server}', # Se acredita que o meu é o 17 e o seu é o 18? kkk
    Server = 'localhost, 1433', # Precisei adicionar o 1433 como porta, se não, não conecta
    Database = 'DbFilme',
    Encrypt = 'Yes',
    TrustServerCertificate = 'Yes',
    UID = 'SA',
    PWD = '{Senha}'# Coloque a senha que você definiu para o usuário SA
)

cursor = conn.cursor()

import time

block_size = 500 # quantidade de insert pra não explodir isso ai
c = 0

# Monte de coisa pra driblar erro
def safe_int(value):
    try:
        if pd.isna(value):
            return None
        return int(value)
    except:
        return None

def safe_float(value):
    try:
        if pd.isna(value):
            return None
        return float(value)
    except:
        return None

def safe_str(value):
    if pd.isna(value):
        return None
    return str(value)

def safe_date(value):
    if pd.isna(value):
        return None
    if value == '0000-00-00':
        return None
    return value

# A parte que insere os ngcs do filmes
for row in df.itertuples():
    try:
        cursor.execute('''
            INSERT INTO movies (
                movie_id, title, release_date, description,
                duration, tagline, metascore, metascore_count,
                userscore, userscore_count)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
            row.id,
            safe_str(row.title),
            safe_date(row.releaseDate),
            safe_str(row.description),
            safe_int(row.duration),
            safe_str(row.tagline),
            safe_int(row.metascore),
            safe_int(row.metascore_count),
            safe_int(row.userscore),
            safe_int(row.userscore_count)
        )
        c += 1
        if c % block_size == 0:
            conn.commit()
            time.sleep(0.1) # pausa para aliviar essa bomba
    except Exception as e:
        print(f"Erro ao inserir linha: {row}\n→ {e}")

conn.commit()

