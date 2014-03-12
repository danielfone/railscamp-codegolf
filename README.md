railscamp-codegolf
==================

This is pretty much an unedited dump of my infrastructure. It is **hugely** insecure and relies on trusting the players. Here are some setup notes off the top of my head.

* It is designed to run in a vagrant container (i.e. this directory structure ends up in /vagrant)
* There should be a user called 'golfer' who should be in the 'vagrant' group.
* You probably want to run the server with `$ RAILS_ENV=production rails server`
* I ran into permission issues with SQLite so switched to postgres
* You need a top-level directory called `/codegolf`

        drwxr-xr-x 25 vagrant vagrant 4096 Mar  9 01:12 /codegolf

* See .psql_history for setting up the database
* For private-key access to the player's repos via ssh, you'll need to add the a public key to ~golfer/.ssh/authorized_keys. Specifcally:

        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVIz9z5JY+ySASZpXjyjnKajbt95wbm5ZKyhIG1JjOIykgj2E3XdVYk3pk4wgSuwkZj0yI7k4yxsdACN6TlCKmENvTTbpniRXSjRcmxxLTu10wFUnVz/FwknqLA6YEDn4QibSwsq8Hm8rLjTemGouk11oCZUDg+0o24F61h0aXPq26ehuMkdy9L8UPgHCGEkZ68Mjt21wWLUlo+xQHWleWQG16oq6oKgLhJRWZQjA5ZdI19jjOdLvEnw1AfUWZpri242l5D3/NXbFgPzwhpu9wmt76GSUQNNthDRaFMzBhcCC43XpkJPdjsWqHKl/kLSic/n/aPHPMjqMr1wpJolZ9 golfer@precise32

* rvm should be installed for both vagrant and golfer. I used something like:

        curl -L get.rvm.io | bash -s stable
        source ~/.rvm/scripts/rvm
        rvm requirements
        rvm install 2.1.0
        rvm use 2.1.0
        ruby -v
        rvm --default use 2.1.0
        ls
        gem update --system
        gem update bundle

    and then after everything was installed:

        vagrant@precise32:/vagrant$ sudo cp -a ~/.rvm ~golfer/; sudo chown golfer:golfer ~golfer/.rvm -R

    ... but there must be a smarter way to do this.

## Setup

*(This is off the top of my head and I haven't tested these instructions)*

* Make sure you're in the application root (usually /vagrant)
* Setup rails first
  * cd webapp/
  * rake db:setup
  * rails server
  * you should be able to browse to a blank score card now
* Setup filesystem
  * cd /vagrant
  * bin/clean (read this script before you run it, it involves rm's!)
  * bin/setup_course (loads course details into database in makes a "gold master" repo for cloning)
  * bin/mkteam (sets up a team in the database and creates a repo for this team)

## Going Live

* Do the same as the setup, just ensure you've done `export RAILS_ENV=production` everywhere.
* After you've set up the course in the production database, you'll want to mess around with the test cases so they're not the same as the player's versions. You can do it in a separate branch or whatever, but the rake task called by the post-recieve hook will run whatever tests are in the course/test/cases directory of *this application*

