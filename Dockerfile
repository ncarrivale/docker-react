#Specify a base image
FROM node:alpine as builder

#setting the working directory inside the container
WORKDIR '/app'

#copy package separately to container, to not continuously install dependencies on every rebuild
COPY ./package.json ./

#install some dependencies
RUN npm install

#copy files to container
COPY . .

#buildea
RUN npm run build

#Run Phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html