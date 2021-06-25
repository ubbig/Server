docker service create --name registry \
  --constraint node.hostname==gitlab \
  -e TZ=Asia/Seoul \
	-p 5000:5000 \
	--mount type=bind,source=/docker_data/registry,destination=/var/lib/registry \
	registry:2