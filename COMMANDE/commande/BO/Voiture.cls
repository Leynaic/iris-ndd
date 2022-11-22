Class commande.BO.Voiture Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoiture(pRequest As commande.msg.creerVoitureDmde, Output pResponse As commande.msg.creerVoitureRpse) As %Status
{
    
    set pResponse = ##class(commande.msg.creerVoitureRpse).%New()
    set voiture = ##class(commande.data.Voiture).%New()
    do ##class(commande.Transform.WsVoitureToVoiture).Transform(pRequest.voiture,.voiture)
    set tsc = voiture.%Save()
    if tsc {
        set pResponse.codeRetour = "OK"
    }
    else{
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "Impossible de cr?er la voiture : "_tsc
    }

    Quit $$$OK
}

Method supprimerVoiture(pRequest As commande.msg.supprimerVoitureDmde, Output pResponse As commande.msg.supprimerVoitureRpse) As %Status
{
    
    set pResponse = ##class(commande.msg.supprimerVoitureRpse).%New()
    set tsc = ##class(commande.data.Voiture).consulterParPlaqueExists(pRequest.plaque, .voitureId)
    if tsc {
        set tsc = ##class(commande.data.Voiture).%DeleteId(voitureId)
        if tsc {
            set pResponse.codeRetour = "OK"
        }
        else{
            set pResponse.codeRetour = "KO"
            set pResponse.libErreur = "Impossible de supprimer la voiture : "_tsc
        }
    } else{
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "Impossible de supprimer la voiture : "_tsc
    }


    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="commande.msg.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
    <MapItem MessageType="commande.msg.supprimerVoitureDmde">
        <Method>supprimerVoiture</Method>
    </MapItem>
</MapItems>
}

}
