function InvokeAndCheckStdOut($cmd, $successString, $failString) {
    Write-Host "====> InvokeAndCheckStdOut"
    Write-Host "Command: $cmd"
    $fullCmd = "$cmd|Tee-Object -variable result"
 
    Invoke-Expression $fullCmd
    $found = $false
    $success = $false
    foreach ($line in $result) {
      if ($line -match $failString) {
       $found = $true
       $success = $false
       break
      }
      else {
       if ($line -match $successString) {
        $found = $true
        $success = $true
        #"[InvokeAndCheckStdOut] FOUND MATCH: $line"
        break
       }
       else {
        #"[InvokeAndCheckStdOut] $line"
       }
      }
    }
 
    if (! $success) {
      throw "Mvn command failed."
    }
 
    Write-Host "InvokeAndCheckStdOut <===="
}
 
function InvokeMvn($cmd) {
    InvokeAndCheckStdOut $cmd "BUILD SUCCESS" "BUILD FAILED"
}

$drive = e:
$sakaiDir="$drive\sakai\wits"
$workspaceDir="$sakaiDir\workspace\sakai-10.5"
$tomcatDir="E:\sakai\wits\tomcat7"

$deployCommand = "mvn clean install sakai:deploy -U -DskipTests=true -D'maven.tomcat.home=$tomcatDir'"
$buildCommand = "mvn clean install -DskipTests=true"

# Excluded packages
##    "skins" = ""; 
##    "witse-help" = ""; 
##    "scripts" = ""; 

$plugins = @{ 
    "assignments2" = "$deployCommand"; 
    "cmembers" = "$deployCommand"; 
    "coursecreator" = "$deployCommand"; 
    "courserollover" = "$deployCommand"; 
    "witse-entity-provider" = "$deployCommand"; 
    "gradebook2" = "$deployCommand"; 
    "witse-landing" = "$deployCommand"; 
    "presencemanager" = "$deployCommand"; 
    "sakai-turnitin-service" = "$deployCommand"; 
    "scorm" = "$deployCommand"; 
    "siteadmin" = "$deployCommand"; 
    "starthere" = "$deployCommand"; 
    "thememanager" = "$deployCommand"; 
    "turnitin-report-generator" = "$deployCommand"; 
    "witse-support" = "$deployCommand"; 
    "witsldap" = "$deployCommand" 
}

clear
$drive

#Build and deploy Sakai
Write-Host -ForegroundColor Green "Building Sakai base"
cd $workspaceDir 
InvokeMvn $deployCommand
Write-Host -ForegroundColor Green "Building Sakai Done"

foreach ($i in $plugins.GetEnumerator()) {
Write-Host
    $pluginName = $($i.Name)
    $mvnCommand = $($i.Value)
    Write-Host -ForegroundColor Green "Building $pluginName"
    cd $workspaceDir/$pluginName 
    InvokeMvn $mvnCommand
    Write-Host -ForegroundColor Green  "Done Building $pluginName"

}

#Move Home.war to webapps directory
Move-Item -Path E:\opt\cle\runtime\tomcat\webapps\home.war -Destination $tomcatDir\webapps

#copy skins to webapps
Copy-Item -Path $workspaceDir\skins\* -Destination $tomcatDir\webapps\library\skin -Force -Recurse




# Build Witse help
#Write-Host -ForegroundColor Green "Building witse-help"
#$witseHelpDir = "$workspaceDir\witse-help\deploy"
#cd $witseHelpDir

#(Get-Content $witseHelpDir\build.properties).replace("/opt/current/tomcat/","$tomcatDir\") | Set-Content $witseHelpDir\build.properties
#ant
#Write-Host -ForegroundColor Green  "Done Building witse-help"

Write-Host -ForegroundColor Green  "Done With Build"


