# I want to load shapefiles of geographic regions (countries, regions, provinces, municipalities etc.)


## Italy
For Italy, a possible data source is Istat: https://www.istat.it/it/archivio/222527

Following this guide:
https://postgis.net/workshops/postgis-intro/loading_data.html

```
FROM postgis/postgis
RUN apt -y update
RUN apt install -y postgis
ENTRYPOINT bash
```

```
docker run --rm -it $(docker build -q .)
```