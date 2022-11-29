Class commande.BO.VoitureFile Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoitureInFile(pRequest As commande.msg.pushVoitureFileDmde, Output pResponse As commande.msg.pushVoitureFileRpse) As %Status
{
    set pResponse = ##class(commande.msg.pushVoitureFileRpse).%New()

    set file = ##class(%Library.FileBinaryStream).%New()

    do file.Write(pRequest.voiture.marque_";"_pRequest.voiture.modele_";"_pRequest.voiture.categorie_";"_pRequest.voiture.plaque_";"_pRequest.voiture.couleur_";"_pRequest.voiture.nbPlaces)

    set tsc = ..Adapter.PutStream("fichierVoiture"_$TR($TR($ZDT($ZDTH($ZTS,-3),3,9),":/-","")," ","_")_".csv",file)
    
    if tsc {
        set pResponse.codeRetour = "OK"
    }
    else{
        set pResponse.codeRetour = "KO"
    }
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
