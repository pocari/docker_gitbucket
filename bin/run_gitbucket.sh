docker build -t gitbucket:v1 .
docker ps | grep gitbucket > /dev/null
if [ "$?" -eq 0 ]
then
  docker kill gitbucket
fi

docker ps -a | grep gitbucket > /dev/null

if [ "$?" -eq 0 ]
then
  docker rm -f gitbucket
fi

docker run -d \
    -p 80:80 \
    -p 29418:29418 \
    --name gitbucket \
    gitbucket:v1
