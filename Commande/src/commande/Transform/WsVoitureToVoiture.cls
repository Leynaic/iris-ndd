Class commande.Transform.WsVoitureToVoiture Extends Ens.DataTransformDTL [ DependsOn = (commande.webObjet.wsVoiture, commande.data.Voiture) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='commande.webObjet.wsVoiture' targetClass='commande.data.Voiture' create='new' language='objectscript' >
<assign value='source.marque' property='target.marque' action='set' />
<assign value='source.modele' property='target.modele' action='set' />
<assign value='source.categorie' property='target.categorie' action='set' />
<assign value='source.plaque' property='target.plaque' action='set' />
<assign value='source.couleur' property='target.couleur' action='set' />
<assign value='source.nbPlaces' property='target.nbPlaces' action='set' />
</transform>
}

}
