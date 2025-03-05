# Usar a última versão do Node.js como imagem base
FROM node:22.14.0-alpine

# Cria o esquema de pastas
RUN mkdir -p /home/lealsoftwares/apps/microservices/node_modules && chown -R node:node /home/lealsoftwares/apps/microservices

# Configura o diretório de trabalho dentro do contêiner
WORKDIR /home/lealsoftwares/apps/microservices

# Copia o package.json e package-lock.json
COPY package*.json ./

# Copia o arquivo .env, para uso em produção
COPY ./.env.production ./.env

# Instala as dependências de produção
RUN npm install --quiet --no-optional --no-fund --loglevel=error --omit=dev --unsafe-perm

# Copia o restante do código da aplicação
COPY . .

# Instale o dockerize
RUN wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz \
  && rm dockerize-linux-amd64-v0.6.1.tar.gz

# Gera o Prisma Client dentro do contêiner Docker
RUN rm -rf node_modules/.prisma
RUN npx prisma generate

# Compila o código TypeScript para a pasta dist
RUN npm run build

# Executa as migrations
RUN npx prisma migrate deploy

# Expõe a porta da aplicação
EXPOSE 3000

# Comando para iniciar a aplicação (substituído pelo docker-compose.yml)
# Comando para iniciar a aplicação
CMD ["npm", "run", "start:prod"]
