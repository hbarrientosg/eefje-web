#  Heroku - WordPress


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

## Setting Up a Local Environment on Mac OS X
- To run WordPress locally on Mac OS X try [MAMP](https://codex.wordpress.org/Installing_WordPress_Locally_on_Your_Mac_With_MAMP).

Open Sequel Pro, and run ...

    CREATE DATABASE wordpress;
    CREATE USER 'wordpress' IDENTIFIED BY 'wordpress';
    GRANT ALL PRIVILEGES ON wordpress . * TO 'wordpress';

In wp-config.php, edit as follows. Make sure it matches the database and user that you just created.

    $db = parse_url($_ENV["JAWSDB_MARIA_URL"] ? \ $_ENV["JAWSDB_MARIA_URL"] : \ "mysql://wordpress:wordpress@localhost:5432/wordpress");
