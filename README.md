# ppl Docker container

This docker container bakes configs into its image and requires the following configuration files:

<a name="conf-files" />

* `conf/client_secret.json` - Offline Google API application credentials
* `conf/local_settings.py` - Django configuration file ([guide here](#))

## Deployment

The ppl folder should contain the latest tested tag of [the ppl repository](https://github.com/HackUCF/ppl). If it doesn't, run this command below. By default, the git submodule tracks ppl's master branch.

    $ git submodule ppl git pull

Stuff the configuration files mentioned [above](#conf-files) into `/conf`, then build the image. As per usual, you can use this same command to rebuild for modifications to both `/conf` and the ppl application.

    $ docker build -t ppl .

Now start it like any other Docker image. In this example, I daemonize it, name the container instance by its run day, bind a directory that contains static files for nginx, and give nginx a way to proxy_pass to the container.
    
    $ docker run -d -v /srv/http/ppl/public:/srv/http/ppl/public -p 127.0.0.1:8000:8000 --name ppl-$(date +%F) ppl
    
If this is the first time starting the container (or you left the DB to default settings and rebuilt the container), you must configure the server's Google API access by running:

    $ docker exec -it ppl ./manage.py update_membership --noauth_local_webserver

The membership database will update! Now connect it to its database, static files server, and more.

## Updating

If you're not very familiar with Docker administration, just rebuild it and eat the downtime. If the database is SQLite (the default), you'll have to reconfigure Google API access. Run the last command in deployment.