Class commande.Production.ProductionCommande Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="commande.Production.ProductionCommande" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Catalogue" Category="" ClassName="commande.BO.Catalogue" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Voiture" Category="" ClassName="commande.BO.Voiture" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ServiceCatalogue" Category="" ClassName="commande.BS.ServiceCatalogue" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
</Production>
}

}
