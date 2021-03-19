#!/bin/bash

docker run -d --name nginx -p 50000:80 nginx

bash -c "cat >> test_connection.sh << EOF
#!/bin/bash

while :
do
        echo 'call curl'
        curl --trace-ascii --trace-time --connect-timeout 1 http://localhost:50000
        sleep 0.1
done
EOF"

