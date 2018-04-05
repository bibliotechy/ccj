# Collaborative Cataloging Japan Prototype#

## A Blacklight App ##

### Setup for running locally##


```
git clone https://github.com/bibliotechy/ccj

cd ccj

./bin/setup

```

Setup will 
* install app dependencies via bundle 
* run database migrations
* seed the database with an admin user
* fetch and start solr
* start your rails server

When that completes, go to http://localhost:3000 in your browser to see the app.

You can upload content on the [Uploads admin page](http://localhost:3000/admin/uploads) after logging in with:
* username: admin@ccj.org
* password: ccjadmin

Create a new upload using the files in the `sampledata/` directory.

You uploaded data should now be visible in the Blacklight app at http://localhost:3000
