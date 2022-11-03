Class reservation.Production.ProductionReservation Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="reservation.Production.ProductionReservation">
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="Voiture" 
        ClassName="reservation.BO.Voiture" 
        PoolSize="1" Enabled="true" Foreground="false" InactivityTimeout="0">
  </Item>
</Production>
}

}
