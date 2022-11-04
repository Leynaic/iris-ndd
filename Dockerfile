ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

USER root

RUN apt-get update ; exit 0
RUN apt-get install -y git && git config --global http.sslverify false

#On crée un dossier où stocker les BDD. Les BDD auront un volume dédié.
RUN mkdir /databases
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_MGRUSER} /databases

#On crée le dossier pour mettre le code
RUN mkdir /opt/iriscode 
WORKDIR /opt/iriscode
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_MGRUSER} /opt/iriscode
RUN chmod -R 777 /opt/iriscode

#On crée le dossier où seront les éléments à importer
WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

RUN git config --global http.sslverify false
RUN export GIT_SSL_NO_VERIFY=1

COPY Installer* .
COPY Deployer* .
COPY WebApplications* .
COPY  RESERVATION/reservation ./code/RESERVATION/reservation
COPY  COMMANDE/commande ./code/COMMANDE/commande
COPY  COMMANDE/Init ./code/COMMANDE/Init
COPY zpm* ./zpm.xml
COPY Script* .
COPY iris.script /tmp/iris.script

# run iris and script
RUN iris start IRIS \
    && iris session IRIS -U %SYS < /tmp/iris.script \
    && iris stop IRIS quietly


# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
CMD [ "-l", "/usr/irissys/mgr/messages.log" ]
