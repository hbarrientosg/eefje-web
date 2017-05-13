#  Heroku - WordPress
This project is a template for installing and running [WordPress](http://wordpress.org/) on [Heroku](http://www.heroku.com/). The repository comes bundled with:
* [Amazon S3 and Cloudfront](https://wordpress.org/plugins/amazon-s3-and-cloudfront/)

## Installation

Clone the repository from Github

    $ git clone git://github.com/isejaa/eefje-web.git

With the [Heroku gem](http://devcenter.heroku.com/articles/heroku-command), create your app

    $ cd eefje-web
    $ heroku create
    Creating strange-turtle-1234... done, stack is cedar
    http://strange-turtle-1234.herokuapp.com/ | git@heroku.com:strange-turtle-1234.git
    Git remote heroku added

Add a database to your app

    $ heroku addons:create jawsdb-maria:kitefin
    Creating jawsdb-maria:kitefin on ⬢ strange-turtle-1234... free
    Your database has been provisioned and is ready for use.
    Created jawsdb-maria-sinuous-1234 as JAWSDB_MARIA_URL
    Use heroku addons:docs jawsdb-maria to view documentation

Store unique keys and salts in Heroku environment variables. Wordpress can provide random values [here](https://api.wordpress.org/secret-key/1.1/salt/).

    heroku config:set AUTH_KEY='put your unique phrase here' \
      SECURE_AUTH_KEY='put your unique phrase here' \
      LOGGED_IN_KEY='put your unique phrase here' \
      NONCE_KEY='put your unique phrase here' \
      AUTH_SALT='put your unique phrase here' \
      SECURE_AUTH_SALT='put your unique phrase here' \
      LOGGED_IN_SALT='put your unique phrase here' \
      NONCE_SALT='put your unique phrase here'

Deploy to Heroku

      $ git push heroku master
      remote: Compressing source files... done.
      remote: Building source:
      remote:
      remote: -----> PHP app detected
      remote:
      remote:  !     WARNING: No 'composer.json' found.
      remote:        Using 'index.php' to declare app type as PHP is considered legacy
      remote:        functionality and may lead to unexpected behavior.
      remote:
      remote: -----> Bootstrapping...
      remote: -----> Installing platform packages...
      remote:        NOTICE: No runtime required in composer.lock; using PHP ^5.5.17
      remote:        - apache (2.4.20)
      remote:        - nginx (1.8.1)
      remote:        - php (5.6.30)
      remote: -----> Installing dependencies...
      remote:        Composer version 1.4.1 2017-03-10 09:29:45
      remote: -----> Preparing runtime environment...
      remote:        NOTICE: No Procfile, using 'web: heroku-php-apache2'.
      remote: -----> Checking for additional extensions to install...
      remote: -----> Discovering process types
      remote:        Procfile declares types -> web
      remote:
      remote: -----> Compressing...
      remote:        Done: 21.2M
      remote: -----> Launching...
      remote:        Released v19
      remote:        https://strange-turtle-1234.herokuapp.com/ deployed to Heroku
      remote:
      remote: Verifying deploy.... done.
      To https://git.heroku.com/strange-turtle-1234.git
      * [new branch]      master -> master

## Usage
Because a file cannot be written to Heroku's file system, updating and installing plugins or themes should be done locally and then pushed to Heroku.

## Updating

Updating your WordPress version is just a matter of merging the updates into
the branch created from the installation.

WordPress needs to update the database. After push, navigate to:

    http://your-app-url.herokuapp.com/wp-admin

WordPress will prompt for updating the database. After that you'll be good
to go.

## Sync database
Your JAWSDB_MARIA_URL configuration variable will contain the connection information in the following manner.

    mysql://USER:PASS@HOST:3306/DATABASE


    mysqldump -h HOST -u USER -pPASS DATABASE > backup.sql

You now have a backup of your database in your terminal’s working directory in a file called backup.sql

To load your backup file into the new JawsDB Maria database, simply issue the following command from the same directory that you saved backup.sql

     mysql -h HOST -u USER -pPASS DATABASE < backup.sql

## Setting Up a Local Environment on Mac OS X
- To run WordPress locally on Mac OS X try [MAMP](https://codex.wordpress.org/Installing_WordPress_Locally_on_Your_Mac_With_MAMP).

Open Sequel Pro, and run ...

    CREATE DATABASE wordpress;
    CREATE USER 'wordpress' IDENTIFIED BY 'wordpress';
    GRANT ALL PRIVILEGES ON wordpress . * TO 'wordpress';

In wp-config.php, edit as follows. Make sure it matches the database and user that you just created.

    $db = parse_url($_ENV["JAWSDB_MARIA_URL"] ? \ $_ENV["JAWSDB_MARIA_URL"] : \ "mysql://wordpress:wordpress@localhost:5432/wordpress");

Set local variables for development

    $ vim /Applications/MAMP/conf/apache/httpd.conf
    SetEnv AWS_ACCESS_KEY_ID 'put your unique phrase here'
    SetEnv AWS_SECRET_ACCESS_KEY 'put your unique phrase here'
