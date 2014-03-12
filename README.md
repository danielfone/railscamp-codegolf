railscamp-codegolf
==================

This is pretty much a dump of my infrastructure. Here are some setup notes off the top of my head.

* It is designed to run in a vagrant container (i.e. this directory structure ends up in /vagrant)
* There should be a user called 'golfer' who should be in the 'vagrant' group.
* You probably want to run the server with `$ RAILS_ENV=production rails server`
* I ran into permission issues with SQLite so switched to postgres
* You need a top-level directory called `/codegolf`

        drwxr-xr-x 25 vagrant vagrant 4096 Mar  9 01:12 /codegolf

* See .psql_history for setting up the database
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
