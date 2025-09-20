# Etapa 1 - Build
FROM node:20-alpine AS builder

WORKDIR /app

# Copia package.json e package-lock.json primeiro (cache)
COPY package*.json ./

# Instala dependências (incluindo dev, necessárias para o build)
RUN npm install

# Copia o restante do código
COPY . .

# Build da aplicação NestJS
RUN npm run build

# Etapa 2 - Runtime
FROM node:20-alpine

WORKDIR /app

# Copia apenas o necessário para rodar
COPY package*.json ./
RUN npm install --only=production

# Copia os arquivos buildados da etapa anterior
COPY --from=builder /app/dist ./dist

# Se precisar de assets estáticos (ex: views, emails, etc)
# COPY --from=builder /app/public ./public

EXPOSE 3000

CMD ["node", "dist/main.js"]
