import pandas as pd
import numpy as np

from time import sleep

import os

print("="*30)
print(f"{"COMPARADOR DE PLANILHA":^30}")
print("="*30)

print("\nLEIA ANTES DE USAR O PROGRAMA\n")
print("Necessário: ")
print("- Duas planilhas dentro da pasta >>> arquivos/ <<<")
print("- Colunas com valores do mesmo tipo ")
print("- Excel, pandas, numpy e openpyxl baixado")
print("="*30)


nome_arquivo = input("Nome da primeira planilha: ")

try:
    # Carrega a primeira planilha excel
    df1 = pd.read_excel(rf"arquivos/{nome_arquivo}")

    print("Colunas: ")
    print(df1.columns)

    coluna1 = input('Qual coluna deseja comparar?: ')
except Exception as e:
    print("Erro ao carregar a Planilha 1")
    print("Mais detalhes: ")
    print(e)
else:
    print("Planilha 1 Carregada")

    nome_arquivo = input("Nome da segunda planilha: ")
    
    try:
        # Carrega a segunda planilha excel
        df2 = pd.read_excel(rf"arquivos/{nome_arquivo}")

        print("Colunas: ")
        print(df2.columns)

        coluna2 = input('Qual coluna deseja comparar?: ')
    except Exception as e:
        print("Erro ao carregar a Planilha 1")
        print("Mais detalhes: ")
        print(e)
    else:
        print("Planilha 2 Carregada")
        print("Iniciando comparação...")
        sleep(0.5)

        # Mescla os dataframes na coluna escolhida
        merged_df = pd.merge(
            df1,
            df2,
            left_on=coluna1,
            right_on=coluna2,
            how='inner'
        )
        
        if coluna1 != coluna2:
            merged_df = merged_df.drop(columns=[coluna2])

        print(merged_df)


        r = input("Deseja Enviar para Excel? (Digite 's' para sim): ")

        if r == 's'.lower().strip():
            try:
                pasta_destino = r"arquivos/consolidated"
                
                if not os.path.exists(pasta_destino):
                    os.makedirs(pasta_destino)
                    print(f"Diretório criado com sucesso: {pasta_destino}")
                
                print(f"Planilha final será salva em {pasta_destino}")
                nome_arquivo = input("Nome da nova planilha: ")
                caminho_completo = os.path.join(pasta_destino, nome_arquivo)
                merged_df.to_excel(caminho_completo, index=False)
            except Exception as e:
                print("Erro ao exportar para planilha...")
                print(e)
            else:
                print(f"Planilha exportada para {caminho_completo} com sucesso!")
finally:
    print("\nObrigado por usar este programa, volte sempre! :)")
    input('Aperte Qualquer Tecla para sair...')
