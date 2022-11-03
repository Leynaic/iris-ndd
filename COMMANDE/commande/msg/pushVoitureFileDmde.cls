Class commande.msg.pushVoitureFileDmde Extends Ens.Request
{

Property voiture As commande.webObjet.wsVoiture;

Storage Default
{
<Data name="pushVoitureFileDmdeDefaultData">
<Subscript>"pushVoitureFileDmde"</Subscript>
<Value name="1">
<Value>voiture</Value>
</Value>
</Data>
<DefaultData>pushVoitureFileDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
