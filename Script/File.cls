Class App.File
{

ClassMethod installNamespaces(listeNS As %ListOfDataTypes, srcFolder As %String) As %Status
{
    set next = 0
    while $LISTNEXT(listeNS,next,value) '= 0 {
        do ##class(%SYSTEM.Process).CurrentDirectory(srcFolder)
        // On charge les Installer
        do $SYSTEM.OBJ.Load("Installer"_value_".cls", "ck")
        set ^zCRInstall(value,"installNamespaces","LoadInstaller") = 1

        // On lance l'installer
        // les - ne sont pas accepter dans les noms de classes, du coup si le namespaces en contient, on les enlèves du nom de la classe INSTALLER
        set tsc = $CLASSMETHOD("App.Installer"_$REPLACE(value,"-",""),"setup")
        set ^zCRInstall(value,"installNamespaces","LaunchInstaller") = tsc
    }
    
    return $$$OK
}

ClassMethod deployNamespaces(listeNS As %ListOfDataTypes, srcFolder As %String) As %Status
{
    set next = 0
    while $LISTNEXT(listeNS,next,value) '= 0 {
        do ##class(%SYSTEM.Process).CurrentDirectory(srcFolder)
        // On charge les deployer
        do $SYSTEM.OBJ.Load("Deployer"_value_".cls", "ck")
        set ^zCRInstall(value,"deployNamespaces","LoadDeployer") = 1
        // On lance le deployer
        // les - ne sont pas accepter dans les noms de classes, du coup si le namespaces en contient, on les enlèves du nom de la classe DEPLOYER
        do $CLASSMETHOD("App.Deployer"_$REPLACE(value,"-",""),"setup")
        set ^zCRInstall(value,"deployNamespaces","LaunchDeployer") = 1

    }
    
    return $$$OK
}

ClassMethod installGitNamespace(name As %String, listePackage As %ListOfDataTypes) As %Status
{
    NEW $NAMESPACE
	SET $NAMESPACE=name
    
    zpm "install git-for-iris"
    do ##class(SourceControl.Git.Utils).AddDefaultSettings()

    set nextPackage = 0
    while $LISTNEXT(listePackage,nextPackage,package)'=0{
        do ##class(SourceControl.Git.Utils).AddPackageToSourceControl(package,name)
    }
    
    do ##class(SourceControl.Git.Utils).SetSourceControlStatus(1)
    set ^oddStudioMenu("00-SourceControlClass") = "SourceControl.Git.Git"

    ///Super Important de se remettre dans le namespace %SYS à la fin
    NEW $NAMESPACE
	SET $NAMESPACE="%SYS"

    return $$$OK
}

ClassMethod installGit() As %Status
{
    NEW $NAMESPACE
	SET $NAMESPACE="%SYS"
    
    zpm "load https://github.com/MattCGI/git-for-iris.git"

    return $$$OK
}

ClassMethod installDefaultSettingsNamespace(name As %String, srcFolder As %String) As %Status
{
    NEW $NAMESPACE
	SET $NAMESPACE=name
    
    do ##class(%SYSTEM.Process).CurrentDirectory(srcFolder)
    set ^zCRInstall(name,"InstallDefaultSettings") = "In progress"
    set tsc = ##class(Ens.Config.DefaultSettings).%Import("DefaultSettings"_name_".xml")
    
    set ^zCRInstall(name,"InstallDefaultSettings") = "Done : "_tsc

    ///Super Important de se remettre dans le namespace %SYS à la fin
    NEW $NAMESPACE
	SET $NAMESPACE="%SYS"

    return $$$OK
}

ClassMethod installWebApplications(name As %String, srcFolder As %String) As %Status
{

    do ##class(%SYSTEM.Process).CurrentDirectory(srcFolder)
    //On déploie les applications Web
    set tsc = ##class(Security.Applications).Import(name_"WebApps.xml")
    set ^zCRInstall(name,"installNamespaces","InstallWebApplications") = tsc
    
    return $$$OK
}

}
