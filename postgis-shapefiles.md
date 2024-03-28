# I want to load shapefiles of geographic regions (countries, regions, provinces, municipalities etc.)


## Italy
For Italy, a possible data source is Istat: https://www.istat.it/it/archivio/222527

Following this guide:
https://postgis.net/workshops/postgis-intro/loading_data.html

You will the shp2pgsql tool, which comes with postgis when you install it.  
You will also need a tool to execute SQL scripts on your database

Or just use a docker image

### Using a docker image
Create a local `Dockerfile` with this content:
```
FROM postgis/postgis
RUN apt -y update
RUN apt install -y postgis wget unzip
ENTRYPOINT bash
WORKDIR /shp
```
then run it as an interactive console:
```
docker run --rm -v  -it $(docker build -q .)
```

### Convert the shapefile to Postgres SQL
```bash
# download and extract the shapefile zip. If you want to load other files, you can also do this outside docker first and mount as volume
wget https://www.istat.it/storage/cartografia/confini_amministrativi/generalizzati/2023/Limiti01012023_g.zip
unzip *.zip

# convert the shape file to SQL insert commands
args=(
  # create geospatial index (?)
  -I 
  # drop (!!!!!) and recreate the old table 
  -d 
  # SRID of the source format. Look up which format your file is in 
  -s 32632 \
  # The shape file which to load. In this case it's the provinces of italy 
  Limiti01012023_g/ProvCM01012023_g/ProvCM01012023_g_WGS84.shp \
  # name of the table that is created 
  shapes.it_prov
)
shp2pgsql "${args[@]}" > it_prov.sql
```

### Load the SQL script
```bash
# it_prov.sql now is a sql script to drop, create and populate the table shapes.it_prov
# either load it using your favourite postgresql admin tool, or directly via CLI
psql  --username=xxxx --dbname=xxxx --host=xxxxxxxxx -f it_prov.sql

```
Note: If the schema doesn't exist yet, create it with
```pgsql
create schema if not exists shapes;
```

Since every shape file has it's own set of fields, the table structure is specific to that shape file