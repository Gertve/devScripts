$drive = "E:"
$apdDir="$drive\sakai\APD"
$tomcatLog="$apdDir\tomcat7\logs\catalina.out"

Get-Content -Path "$tomcatLog" -Wait

