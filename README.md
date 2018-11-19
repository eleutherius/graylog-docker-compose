Installing GRAYLOG Documentation 
----
 
It's simply graylog installation instruction for to install graylog in the docker container. 

Docker-compose.yml file for graylog
```custom_gelf_log.sh``` - custom script  for transfer log data vía GELF protocol.

## Mysql Server logining tools 

Mysql logining via script :
https://github.com/arikogan/mysql-gelf


For Docker container we need to add this lines in docker-compose.yml


```
    logging:
      driver: "gelf"
      options:
        gelf-address: "udp://192.168.100.137:12201"
        tag: "sidekiq"

```

## Docker composer autostart

```
# /etc/systemd/system/docker-compose-app.service

[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/srv/docker
ExecStart=/usr/local/bin/docker-compose up -d --force-recreate
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target

```
Change the ```WorkingDirectory``` parameter with your dockerized project path. And enable the service to start automatically:

```systemctl enable docker-compose-app```
