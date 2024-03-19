#Use the official Ubuntu as a parent image
FROM ubuntu:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Install Node.js and npm
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs 
      

# Install Angular CLI globally
RUN npm install -g @angular/cli
RUN npm cache clean -f

# Copy package.json and package-lock.json
COPY package*.json ./

# Copy all files from the current directory to the working directory in the container
COPY . .

#install app dependencies
RUN npm install 

# Expose the port the app runs on
EXPOSE 4200

# build the code 
RUN ng build

# Serve the app
CMD ["ng", "serve", "--host", "0.0.0.0"]
