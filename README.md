# Projeto PHP7-Mysql-docker
Este projeto visa disponibilizar uma imagem padrão para aplicações PHP7.

# Versões utilizadas na geração das imagens
Abaixo estão listadas, para fins de documentação, todas as versões utilizadas para a execução deste projeto, contudo acredito que você não tera problemas em executar esses passos com outras versões e distribuições linux.

## Docker
**Para descobrir a versão do docker, digite o comando abaixo:**
```
# docker --version
```
**O retorno do comando acima será algo como:**
```
Docker version 18.03.1-ce, build 9ee9f40
```

## Docker Compose
**Para descobrir a versão do docker, digite o comando abaixo:**
```
# docker-compose --version
```
**O retorno do comando acima será algo como:**
```
docker-compose version 1.21.2, build a133471
```

## Sistema Operacional 
**Para descobrir a versão do sistema operacional digite o comando**
```
# lsb_release -irc
```
ou 
```
# lsb_release -a
```
**O retorno será algo como o trecho abaixo:**
```
Distributor ID: Ubuntu
Release:        18.04
Codename:       bionic
```
**Caso não funcione, tente este outro comando**
```
# cat /etc/*-release | grep PRETTY
```
**O retorno será algo como o trecho abaixo:**
```
PRETTY_NAME="CentOS Linux 7 (Core)"
```


## MySQL
**A versão do MySQL utilizada foi a versão 5.6**

# Como instalar os pré-requisitos? 
## Instalando o git no CentOS7
**A instalação padrão do GIT via repositório do CentOS consiste em um simples comando 'yum'**
```
$ sudo yum install git -y
```

## Instalando o git no Ubuntu, Deepin e família Debian
**A instalação padrão do GIT via repositório do Ubuntu/Debian consiste em um simples comando 'apt-get'**
```
$ sudo apt-get update
$ sudo apt-get install git-core
```

**Para testar a versão instalada digite o comando `git --version` e tera algo como a saída abaixo (Qualquer Distribuição)**
```
git version 1.8.3.1
```

## Instalando o docker via repositório do Ubuntu
**A instalação padrão via repositório do Ubuntu consiste em um simples comando 'apt'**
```
$ sudo apt install docker.io
```
## Instalando o docker a partir do repositório oficial do docker
**Para iniciar a instalação via repositório oficial do docker, há a necessidade de instalar todos os pré-requisitos**
## Instalando no Ubuntu, Deepin e Familia Debian
```
$ sudo apt update
$ sudo apt install apt-transport-https ca-certificates curl software-properties-common
```
**Adicione o repositório docker ao repositório do seu sistema operacional. Para isso crie o arquivo '/etc/apt/sources.list.d/docker.list'. neste arquivo cole uma das seguintes linhas descritas abaixo:**
```
deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable
```
OR
```
deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic edge
```
OR
```
deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic nightly
```

**Agora adicione a chave GPG do docker e atualize as referencias do repositório**
```
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo apt update
$ sudo apt install docker-ce
```
**Para iniciar o docker digite o comando:**
```
$ sudo systemctl start docker
$ sudo systemctl enable docker
```

## Instalando no CentOS7
```
$ sudo yum update
$ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
$ sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
$ sudo yum install docker-ce
$ sudo usermod -aG docker $(whoami)
$ sudo systemctl enable docker.service
```

**Prontinho! Para testar se seu docker foi instalado com sucesso digite o comando do docker que retorna a versão instalada. veja abaixo o camando e a saída**
```
$ docker --version
Docker version 18.03.1-ce, build 9ee9f40
```

# Instalando o docker-compose
**Baixe a última versão do docker-compose**
## No Ubuntu, Deepin e família Debian
```
$ sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
```
**Aplique as permissoes de execução ao arquivo**
```
$ sudo chmod +x /usr/local/bin/docker-compose
```

## No CentOS, Mint e família RedHat
```
$ sudo yum install epel-release
$ sudo yum install -y python-pip
$ sudo pip install docker-compose
$ sudo yum upgrade python*
$ pip install --upgrade pip
```

**Pronto! Seu docker-compose já deve estar instalado. Valide a instalação com o comando abaixo:**
```
$ docker-compose --version

O retorno do comando acima será algo como:
docker-compose version 1.21.2, build a133471
```

# Inicializando a Aplicação neste projeto
**Agora seu sistema operacional já está com o docker e docker-compose instalado, entao basta clonar este repositório ou baixar os arquivos e colocar na para '/var/www/docker'(Este é apenas o caminho sugerido. Voce pode colocar onde quiser!) e mandar recompilar a imagem.**
__Para clonar o repositório digite:__
```
$ git clone https://github.com/alyssontkd/php7-mysql-docker.git
```
__Agora entre no diretório e rode o docker-compose:__

```
# cd /var/www/docker/app-docker
# docker-compose up -d
```

**Descompacte a Aplicação na raiz do diretório `/var/www/docker/app-docker` para que ele fique acessível**
**Depois deste comando a imagem será recompilada e ao fim a Aplicação podera ser acessado via URL: http://127.0.0.1**


# Dicas importantes
```
Nome do host de banco de dados: meu-db
Nome da base de dados: meu_banco
Nome do usuario: root
Senha de root: mysql2018
```
 
**Para verificar se os pods estão rodando:** 
``` 
$ docker ps -a
```
**A Saída para o comando acima será algo como:** 
``` 
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS              PORTS                                                              NAMES
107a862ffdca        alyssontkd/ambiente-php7   "docker-entrypoint..."   14 hours ago        Up 14 hours         0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp, 0.0.0.0:8888->8888/tcp   minha-app-web
659ec002ae99        mysql:5.7                  "docker-entrypoint..."   14 hours ago        Up 14 hours         0.0.0.0:3306->3306/tcp                                             meu-db

```

## Configurando o servidor WEB para permitir conexão via API de outro domínio. (caso necessário)
## APP Webserver

On your Application webserver, you need active the CORS.
Documentation about [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)

### Apache

```
Header set Access-Control-Allow-Origin "*"
Header set Access-Control-Allow-Methods "GET, POST, OPTIONS, PUT, DELETE"
Header set Access-Control-Allow-Credentials true
Header set Access-Control-Allow-Headers "X-Requested-With, Content-Type, Origin, Authorization, Accept, Client-Security-Token, Accept-Encoding, App-Token, Session-Token"
```

### NGINX

```
more_set_headers 'Access-Control-Allow-Origin: *';
more_set_headers 'Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE';
more_set_headers 'Access-Control-Allow-Credentials: true';
more_set_headers 'Access-Control-Allow-Headers: Origin,Content-Type,Accept,Authorization,App-Token,Session-Token';
```


