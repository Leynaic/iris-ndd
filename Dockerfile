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
RUN 

COPY Installer* .
COPY Deployer* .
COPY WebApplications* .
COPY  RESERVATION/reservation ./code/RESERVATION/reservation
COPY  COMMANDE/commande ./code/COMMANDE/commande
COPY  COMMANDE/Init ./code/COMMANDE/Init
COPY zpm* ./zpm.xml
COPY Script* .
COPY iris.script /tmp/iris.script
COPY irissession.sh /
#SHELL ["/irissession.sh"]


# run iris and script
RUN iris start IRIS \
    && iris session IRIS -U %SYS < /tmp/iris.script \
    && iris stop IRIS quietly


#RUN \
 # do $SYSTEM.OBJ.Load("InstallerCommande.cls", "ck") \
 #  do $SYSTEM.OBJ.Load("InstallerReservation.cls", "ck") \
 # set sc = ##class(App.InstallerCommande).setup() \
 # set sc = ##class(App.InstallerReservation).setup() \
 # zn "COMMANDE" \
 # do InsertData^Init.initData() \
 # set ^plaque = "AA-001-AA" \
 # zn "%SYS" \
 # write "Create web application ..." \
 # set webName = "/api/reservation" \
 # set webProperties("DispatchClass") = "BS.API" \
 # set webProperties("NameSpace") = "RESERVATION" \
 # set webProperties("Enabled") = 1 \
 # set webProperties("AutheEnabled") = 32 \
 # set sc = ##class(Security.Applications).Create(webName, .webProperties) \
 # write sc \
 # write "Web application "_webName_" has been created!" \
 # write "Create web application ..." \
 # set webName = "/api/commande" \
 # set webProperties("DispatchClass") = "BS.API" \
 # set webProperties("NameSpace") = "COMMANDE" \
 # set webProperties("Enabled") = 1 \
 # set webProperties("AutheEnabled") = 32 \
 # set sc = ##class(Security.Applications).Create(webName, .webProperties) \
 # write sc \
 # write "Web application "_webName_" has been created!" 

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]
CMD [ "-l", "/usr/irissys/mgr/messages.log" ]
