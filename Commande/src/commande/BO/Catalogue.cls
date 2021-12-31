Class commande.BO.Catalogue Extends Ens.BusinessOperation
{

// HAHA

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method getCatalogue(pRequest As commande.msg.getCatalogueDmde, Output pResponse As commande.msg.getCatalogueRpse) As %Status
{

    set pResponse = ##class(commande.msg.getCatalogueRpse).%New()
    
    set sql = "select marque, modele, type , nbPlaces , prix from commande_data.Catalogue"

    set statement=##class(%SQL.Statement).%New() 
	do statement.%Prepare(sql)
	set SQLrequest = statement.%Execute()
    While SQLrequest.%Next(){
        set item = ##class(commande.webObjet.wsCatalogue).%New()
        set item.marque = SQLrequest.%Get("marque")
        set item.type = SQLrequest.%Get("type")
        set item.modele = SQLrequest.%Get("modele")
        set item.nbPlaces = SQLrequest.%Get("nbPlaces")
        set item.prix = SQLrequest.%Get("prix")
        do pResponse.listCatalogue.Insert(item)
    }
    set pResponse.codeRetour = "OK"

    Quit $$$OK
}

Method ajouterVoitureCatalogue(pRequest As commande.msg.ajouterVoitureCatalogueDmde, Output pResponse As commande.msg.ajouterVoitureCatalogueRpse) As %Status
{

    set pResponse = ##class(commande.msg.ajouterVoitureCatalogueRpse).%New()
    
    set voiture = ##class(commande.data.Catalogue).%New()
    do ##class(commande.Transform.WsCatalogueToCatalogue).Transform(pRequest.catalogue,.voiture)
    set tsc = voiture.%Save()
    if tsc {
        set pResponse.codeRetour = "OK"
    }
    else {
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "Impossible d'ajouter la voiture au catalogue"
    }

    Quit $$$OK
}

Method consulterVoitureCatalogue(pRequest As commande.msg.consulterVoitureCatalogueDmde, Output pResponse As commande.msg.consulterVoitureCatalogueRpse) As %Status
{

    set pResponse = ##class(commande.msg.consulterVoitureCatalogueRpse).%New()
    if (##class(commande.data.Catalogue).consulterParMarqueModeleExists(pRequest.marque, pRequest.modele, .idCatalogue)){
        set catalogue = ##class(commande.data.Catalogue).%OpenId(idCatalogue)
        do ##class(commande.Transform.CatalogueToWsCatalogue).Transform(catalogue,.wsCatalogue)
        set pResponse.catalogue = wsCatalogue
        set pResponse.codeRetour = "OK" 
    }
    else {
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "Voiture inexistante au catalogue"

    }
    Quit $$$OK
}

ClassMethod ajouterVoitureCatalogueInit(pRequest As commande.msg.ajouterVoitureCatalogueDmde, Output pResponse As commande.msg.ajouterVoitureCatalogueRpse) As %Status
{

    set pResponse = ##class(commande.msg.ajouterVoitureCatalogueRpse).%New()
    
    set voiture = ##class(commande.data.Catalogue).%New()
    do ##class(commande.Transform.WsCatalogueToCatalogue).Transform(pRequest.catalogue,.catalogue)
    set tsc = catalogue.%Save()

    set pResponse.codeRetour = tsc

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="commande.msg.getCatalogueDmde">
        <Method>getCatalogue</Method>
    </MapItem>
    <MapItem MessageType="commande.msg.ajouterVoitureCatalogueDmde">
        <Method>ajouterVoitureCatalogue</Method>
    </MapItem>
    <MapItem MessageType="commande.msg.consulterVoitureCatalogueDmde">
        <Method>consulterVoitureCatalogue</Method>
    </MapItem>
</MapItems>
}

}
