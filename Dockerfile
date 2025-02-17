# Usa uma imagem do Nginx como base
FROM nginx:alpine

# Define o diretório de trabalho
WORKDIR /usr/share/nginx/html

# Copia os arquivos do build para o diretório de publicação
COPY build/dist /usr/share/nginx/html

# Expõe a porta 80
EXPOSE 80

# Comando de entrada
CMD ["nginx", "-g", "daemon off;"]
