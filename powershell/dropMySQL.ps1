$drive = "E:"
$apdDir="$drive\sakai\APD"

clear
$drive

cd $apdDir

docker-compose down
docker-compose up -d