Class commande.BO.VoitureFile Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoitureInFile(pRequest As commande.msg.pushVoitureFileDmde, Output pResponse As commande.msg.pushVoitureFileRpse) As %Status
{
    set pResponse = ##class(commande.msg.pushVoitureFileRpse).%New()
    set voiture = ##class(commande.data.Voiture).%New()

    set stream = ##class(%Library.FileBinaryStream).%New()
    do stream.Write(pRequest.voiture.marque)
    
    do ..Adapter.PutStream("voitures.csv", stream)

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="commande.msg.pushVoitureFileDmde">
        <Method>creerVoitureInFile</Method>
    </MapItem>
</MapItems>
}

}
