#---------------------------------------
# Building a image and running npm command
# FROM node:alpine
# WORKDIR /app
# COPY package.json .
# RUN npm install
# COPY . .
# CMD ["npm", "start"]
#---------------------------------------
# Building a multiple phase builds
# builder is a phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# COPy from 1 phase to another
COPY --from=builder /app/build /usr/share/nginx/html