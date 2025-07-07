# Estágio 1: Usar uma imagem oficial do Python como imagem base.
# A versão 'alpine' resulta em uma imagem final menor.
# O readme.md sugere Python 3.10+, então 3.11 é uma ótima escolha estável.
FROM python:3.11-alpine

# Define variáveis de ambiente para otimizar a execução do Python em contêineres
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Esta camada só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código-fonte da aplicação para o contêiner
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Define o comando para executar a aplicação quando o contêiner iniciar.
# Usamos --host 0.0.0.0 para tornar o servidor acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
