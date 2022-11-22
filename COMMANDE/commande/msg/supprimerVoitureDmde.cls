Class commande.msg.supprimerVoitureDmde Extends Ens.Request
{

Property plaque As %String;

Storage Default
{
<Data name="supprimerVoitureDmdeDefaultData">
<Subscript>"supprimerVoitureDmde"</Subscript>
<Value name="1">
<Value>plaque</Value>
</Value>
</Data>
<DefaultData>supprimerVoitureDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
