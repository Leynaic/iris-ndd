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
        set pResponse.libErreur = "Impossible de créer la voiture : "_tsc
    }

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="commande.msg.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
</MapItems>
}

}
