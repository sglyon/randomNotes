# Migrating postgres to sqlite

I found a handful of helpful links on the internet.

This was my final solution

```shell

localhost$ heroku run python manage.py dumpdata --natural --indent=4 -e sessions -e admin -e contenttypes -e auth.Permission > db.json
on-heroku$ curl -H "Max-Downloads: 1" -H "Max-Days: 5" --upload-file db.json https://transfer.sh/my_db.json # prints out a url
localhost$ curl URL_FROM_LAST_STEP -o my_db.json
localhost$ # CHANGE SETTINGS.py for new database settings
localhost$ python manage.py syncdb
localhost$ python manage.py sqlflush
localhost$ python manage.py loaddata my_db.json
```
