# Use an official Node.js runtime as the base image
FROM node:18-alpine

# Set the working directory in the container
RUN npm install -g @angular/cli
RUN npm cache clean -f

WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Copy the rest of the application code to the working directory
COPY . .

#install app dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 4200

# build the code
RUN ng build

# Serve the app
CMD ["ng", "serve", "--host", "0.0.0.0"]
