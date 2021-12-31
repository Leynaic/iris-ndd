Class commande.msg.getCatalogueRpse Extends (commande.msg.basic.reponse, %JSON.Adaptor)
{

Property listCatalogue As list Of commande.webObjet.wsCatalogue;

Storage Default
{
<Data name="creerVoitureRpseDefaultData">
<Subscript>"creerVoitureRpse"</Subscript>
<Value name="1">
<Value>catalogue</Value>
</Value>
<Value name="2">
<Value>listCatalogue</Value>
</Value>
</Data>
<DefaultData>creerVoitureRpseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
