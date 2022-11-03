## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.


## Installation for development

Create your repository from template.

Connect to your GitHub account, go to this URL : https://github.com/MattCGI/MiageTP and choose "Use this template".
Select a name for your project and clic Create repository from template.

Clone/git pull YOUR repo (NOT THE TEMPLATE) into any local directory e.g. like it is shown below (here I show all the examples related to this repository, but I assume you have your own derived from the template):

```
$ git clone git@github.com:MattCGI/MiageNDD.git
```

Open the terminal in this directory and run the command below (Careful, if you are not on a Windows System, change the device value):

```
$ docker volume create --driver local --label com.docker.compose.project=install --label com.docker.compose.version=1.29.1 --label com.docker.compose.volume=databases-ndd  --opt type=none --opt device=C:\docker\volumes\databases\ndd --opt o=bind  databases-ndd

$ docker-compose up -d --build
```