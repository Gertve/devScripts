$drive = "E:"
$apdDir="$drive\sakai\APD"
$tomcatDir="$apdDir\tomcat7"

$env:CATALINA_HOME = $tomcatDir
$env:path += $env:CATALINA_HOME+"\bin"

clear
$drive

cd $tomcatDir\bin 

.\startup.bat

cd $apdDir