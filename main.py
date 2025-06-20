# Código no Terminal para instalar a biblioteca "pandas"
# pip install pandas

# Importar a biblioteca "pandas"
import pandas as pd

import os

# Carrega o primeiro arquivo CSV
df = pd.read_csv(r"arquivos/movies.csv")

# Mostra os primeiros 10 registros
# print(df.head(10))

# Exibe o nome de todas as colunas
# print(df.columns)

# Armazena todas as colunas do Datasets
colunas = ['id', 'title', 'releaseDate', 'rating', 'genres', 'description',
       'duration', 'tagline', 'metascore', 'metascore_count',
       'metascore_sentiment', 'userscore', 'userscore_count',
       'userscore_sentiment', 'production_companies', 'director', 'writer',
       'top_cast']

for col in colunas:
    # Recebendo a soma de dados nulos na coluna
    nulos = df[col].isnull().sum()
    print(f"A coluna '{col}' possui {nulos} valores nulos.")

    if nulos > 0:
        # Substituindo os valores nulos
        df[col] = df[col].fillna('Não informado')

        print(f"A coluna '{col}' foi arrumada.")

# Localizando e armazenando os registros com o releaseDate igual a 2021
df_2021 = df.loc[df['releaseDate'].str.startswith('2021')]
print(df_2021)

# Localizando e armazenando os registros com o releaseDate igual a 2022
df_2022 = df.loc[df['releaseDate'].str.startswith('2022')]
print(df_2022)

# Localizando e armazenando os registros com o releaseDate igual a 2023
df_2023 = df.loc[df['releaseDate'].str.startswith('2023')]
print(df_2023)

pasta_destino = r"arquivos/datas"

nome_arquivo = "movies_2021.xlsx"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
df_2021.to_excel(caminho_completo, index=False)

nome_arquivo = "movies_2022.xlsx"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
df_2022.to_excel(caminho_completo, index=False)

nome_arquivo = "movies_2023.xlsx"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
df_2023.to_excel(caminho_completo, index=False)

dados = []

for arquivo in os.listdir(pasta_destino):
  if arquivo.endswith(".xlsx"):
    caminho_arquivo = os.path.join(pasta_destino, arquivo)
    df = pd.read_excel(caminho_arquivo)
    dados.append(df)

consolidado = pd.concat(dados)

pasta_destino = r"arquivos/consolidated"

nome_arquivo =  "movies_consolidado.xlsx"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
consolidado.to_excel(caminho_completo, index=False)

nome_arquivo =  "movies_consolidado.csv"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
consolidado.to_csv(caminho_completo, index=False, sep=",")

nome_arquivo =  "movies_consolidado.txt"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
consolidado.to_csv(caminho_completo, index=False, sep=",")

# ------------------------------------------------------------------------------------------- #

# Carrega o segundo arquivo CSV
df = pd.read_csv(r"arquivos/movies_reviews.csv")

# Exibe o nome de todas as colunas
print(df.columns)

# Armazena todas as colunas do Datasets
colunas = ['id', 'title', 'quote', 'score', 'date', 'author', 'publicationName',
       'review_type']

for col in colunas:
    # Recebendo a soma de dados nulos na coluna
    nulos = df[col].isnull().sum()
    print(f"A coluna '{col}' possui {nulos} valores nulos.")

    if nulos > 0:
        # Substituindo os valores nulos
        df[col] = df[col].fillna('Não informado')

        print(f"A coluna '{col}' foi arrumada.")

# Localizando e armazenando os registros com o date igual a 2021
df_2021 = df.loc[df['date'].str.startswith('2021')]
print(df_2021)

# Localizando e armazenando os registros com o date igual a 2022
df_2022 = df.loc[df['date'].str.startswith('2022')]
print(df_2022)

# Localizando e armazenando os registros com o date igual a 2023
df_2023 = df.loc[df['date'].str.startswith('2023')]
print(df_2023)

pasta_destino = r"arquivos/datas"

nome_arquivo = "movies_reviews_2021.xlsx"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
df_2021.to_excel(caminho_completo, index=False)

nome_arquivo = "movies_reviews_2022.xlsx"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
df_2022.to_excel(caminho_completo, index=False)

nome_arquivo = "movies_reviews_2023.xlsx"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
df_2023.to_excel(caminho_completo, index=False)

dados = []

for arquivo in os.listdir(pasta_destino):
  if arquivo.endswith(".xlsx"):
    caminho_arquivo = os.path.join(pasta_destino, arquivo)
    df = pd.read_excel(caminho_arquivo)
    dados.append(df)

consolidado = pd.concat(dados)

pasta_destino = r"arquivos/consolidated"

nome_arquivo =  "movies_reviews_consolidado.xlsx"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
consolidado.to_excel(caminho_completo, index=False)

nome_arquivo =  "movies_reviews_consolidado.csv"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
consolidado.to_csv(caminho_completo, index=False, sep=",")

nome_arquivo =  "movies_reviews_consolidado.txt"
caminho_completo = os.path.join(pasta_destino, nome_arquivo)
consolidado.to_csv(caminho_completo, index=False, sep=",")