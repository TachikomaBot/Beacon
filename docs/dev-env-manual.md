# Development & Environment Manual

### Getting Started

1. Clone repository
```
git clone https://github.com/UAlberta-CMPUT401/CS-and-Law.git
```

2. Install an IDE. Our recommendation is [Visual Studio Code](https://code.visualstudio.com/) because it has a built in terminal.

3. Install Docker

For Windows, on command prompt:
```
sudo curl -sSL https://get.docker.com/ | sh
sudo usermod -a -G docker $(whoami)
sudo service docker start 
```

For Mac, on terminal:
```
brew cask install docker
```

`NOTE:` If none of these instructions work, install [Docker Desktop](https://www.docker.com/products/docker-desktop) from your browser.

`Also NOTE:` Make sure docker is installed by running
```
docker --version
```

4. Build Docker Image from our provided [Dockerfile](https://github.com/UAlberta-CMPUT401/CS-and-Law/blob/master/Dockerfile)
```
docker build -t <IMAGE NAME> .
```

5. Run a container using your created Docker Image
```
docker run --name <CONTAINER NAME> <DOCKER IMAGE>
```

You should see something like this...
```
developer@8257f2a49092:~$ 
```

This will be your environment for development. Good Luck~