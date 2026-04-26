Place `GeoLite2-City.mmdb` in this directory.

The file is not committed because MaxMind GeoLite2 databases require accepting
MaxMind's license terms. The application also supports overriding the path with:

`GEOIP_DATABASE_PATH=/absolute/path/to/GeoLite2-City.mmdb`

Download with:

```bash
MAXMIND_LICENSE_KEY=your_key ./scripts/download-geolite2-city.sh
```
