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
