import streamlit as st
import pandas as pd

st.set_page_config(
    page_title="Comparador de Planilhas",
    page_icon="📊",
    layout="wide"
)

st.title("📊 Comparador de Planilhas")
st.markdown("""
Faça o upload de duas planilhas Excel, escolha as colunas que deseja comparar
e gere uma planilha consolidada.
""")

# Upload dos arquivos
arquivo1 = st.file_uploader(
    "Selecione a primeira planilha",
    type=["xlsx", "xls"],
    key="arquivo1"
)

arquivo2 = st.file_uploader(
    "Selecione a segunda planilha",
    type=["xlsx", "xls"],
    key="arquivo2"
)

if arquivo1 and arquivo2:

    try:
        preview1 = pd.read_excel(arquivo1, header=None, nrows=10)

        st.write("Prévia da planilha 1")
        st.dataframe(preview1)

        linha1 = st.number_input(
            "Em qual linha estão os cabeçalhos?",
            min_value=1,
            max_value=20,
            value=1
        )

        df1 = pd.read_excel(arquivo1, header=linha1)
        
        preview2 = pd.read_excel(arquivo2, header=None, nrows=10)

        st.write("Prévia da planilha 2")
        st.dataframe(preview2)

        linha2 = st.number_input(
            "Em qual linha estão os cabeçalhos?",
            min_value=0,
            max_value=20,
            value=1
        )

        df2 = pd.read_excel(arquivo2, header=linha2)

        col1, col2 = st.columns(2)

        with col1:
            st.subheader("Planilha 1")
            st.write(df1.head())

            coluna1 = st.selectbox(
                "Escolha a coluna da Planilha 1",
                df1.columns
            )

        with col2:
            st.subheader("Planilha 2")
            st.write(df2.head())

            coluna2 = st.selectbox(
                "Escolha a coluna da Planilha 2",
                df2.columns
            )

        if st.button("Comparar Planilhas", type="primary"):

            with st.spinner("Comparando..."):

                merged_df = pd.merge(
                    df1,
                    df2,
                    left_on=coluna1,
                    right_on=coluna2,
                    how="inner"
                )

                if coluna1 != coluna2:
                    merged_df = merged_df.drop(columns=[coluna2])

            st.success(f"Comparação concluída! {len(merged_df)} registros encontrados.")

            st.subheader("Resultado")

            st.dataframe(
                merged_df,
                use_container_width=True,
                height=500
            )

            excel = merged_df.to_excel(
                "temp.xlsx",
                index=False,
                engine="openpyxl"
            )

            with open("temp.xlsx", "rb") as file:
                st.download_button(
                    label="📥 Baixar Resultado",
                    data=file,
                    file_name="consolidado.xlsx",
                    mime="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                )

    except Exception as e:
        st.error(f"Ocorreu um erro: {e}")

else:
    st.info("Faça o upload das duas planilhas para iniciar.")
    
st.divider()

st.markdown(
    """
    <div style="
        text-align:center;
        color:#808080;
        font-size:12px;
        padding-top:10px;
    ">
        📊 Comparador de Planilhas<br>
        Desenvolvido por <b>João Henrique</b> • © 2026
    </div>
    """,
    unsafe_allow_html=True
)