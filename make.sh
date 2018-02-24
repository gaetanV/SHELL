docker build -t ubuntu .
docker run -it -v $PWD/:/share ubuntu /bin/bash 
