docker run -d -v /docker_data/shardingsphere/conf:/opt/sharding-proxy/conf \
  -e TZ=Asia/Seoul \
	-e PORT=3307 \
	-p 3308:3308 \
	apache/sharding-proxy:latest