# OAS Docker LAMP Stack (php7+php5)

### USING *MAKE* TOOL
```
make config
```
 - Initial setup (it also runs the containers):
```
make build
```
 - Running containers:
```
make run
```
 - Stop containers:
```
make stop
```

### OR DOCKER *NATIVE* CMD
 - Prepare config:
```
cp docker-compose.yml.EXAMPLE docker-compose.yml
```

 - Run containers:
```
docker-compose up -d
```

 - Stop and remove containers
```
docker-compose down
```

 - Rebuild containers if any configs were changed:
```
docker-compose up -d --build
```

---------

### To login to main workspace container bash console:
```
make bash
```
or:
```
docker-compose exec web bash
```
or to Legacy Container:
```
docker-compose exec web bash
```
```
make lebash
```
or others:
```
make enter EC=$CONTAINERNAME
```

---------

### Restore databases:
you have to uncomment at `./docker-compose.yml`
```
# - ./dbname/temp:/mytemp
```
then place dbdump file(s) to `./dbname/temp` and login to needed container
and restore using CLI tool like `mongorestore` or `mysql`.

##### Example for MySQL:
Uncomment at `./docker-compose.yml`:
```
# - ./mysql/temp:/mytemp
```
Then place your `dump.sql` to `./mysql/temp` and login to mysql console:
```
docker-compose exec mysql bash
cd /mytemp
mysql -uroot -p dbname < dump.sql
```
Done. Your database is up and will be stored even after killed container,
because mysql data stored at host storage: `./mysql/data`
