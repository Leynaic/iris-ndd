Class reservation.BO.Voiture Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoiture(pRequest As reservation.msg.creerVoitureDmde, Output pResponse As reservation.msg.creerVoitureRpse) As %Status
{
    
    set pResponse = ##class(reservation.msg.creerVoitureRpse).%New()
    set voiture = ##class(reservation.data.Voiture).%New()
    set voiture.nom = pRequest.nom
    set voiture.categorie = pRequest.categorie
    set voiture.plaque = pRequest.plaque
    set tsc = voiture.%Save()

    set pResponse.codeRetour = "OK"

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="reservation.msg.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
</MapItems>
}

}
