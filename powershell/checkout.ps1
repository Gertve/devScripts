$drive="e:"
$workspaceDir="$drive\sakai\wits\workspace"

$sakaiVersion="sakai-10.5"
$ocClient="wits"

$sakaiSVN="https://source.sakaiproject.org/svn/sakai/tags"
$witsSVN="http://gforge.wits.ac.za/svn"

$plugins = @{ "assignments2" = "wits_sakai/assignment/trunk"; 
    "cmembers" = "wits_sakai/cmembers/trunk"; 
    "coursecreator" = "wits_sakai/coursecreator/trunk"; 
    "courserollover" = "wits_sakai/courserollover/trunk"; 
    "witse-entity-provider" = "wits_sakai/entity-provider/trunk"; 
    "gradebook2" = "wits_sakai/gradebook/trunk"; 
    "witse-help " = "wits_sakai/help/trunk"; 
    "witse-landing" = "wits_sakai/landing/trunk"; 
    "presencemanager" = "wits_sakai/presencemanager/trunk"; 
    "sakai-turnitin-service" = "wits_sakai/sakai-turnitin-service/trunk"; 
    "scorm" = "wits_sakai/scorm/trunk"; 
    "scripts" = "wits_sakai/scripts/trunk"; 
    "siteadmin" = "wits_sakai/siteadmin/trunk"; 
    "skins" = "wits_sakai/skins/trunk"; 
    "starthere" = "wits_sakai/starthere/trunk"; 
    "thememanager" = "wits_sakai/thememanager/trunk"; 
    "turnitin-report-generator" = "wits_sakai/turnitin-report-generator/trunk"; 
    "witse-support" = "wits_sakai/support/trunk"; 
    "witsldap" = "wits_sakai/witsldap/trunk" }

clear

$drive

cd $workspaceDir
svn co $sakaiSVN/$sakaiVersion $sakaiVersion

cd $workspaceDir/$sakaiVersion

foreach ($h in $plugins.GetEnumerator()) {
    $name = $($h.Name)
    $url = "$witsSVN/$($h.Value)"
    svn co $url $name
}
