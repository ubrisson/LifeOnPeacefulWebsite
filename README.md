# Personal website 
![Rails Tests](https://github.com/ubrisson/railsBlogTest/workflows/Rails%20Tests/badge.svg)

This is my personal website repository.
It is built with [Ruby on Rails](https://rubyonrails.org/) and [TailwindCSS](https://tailwindcss.com/).
It is hosted on [alwaysdata.net](https://ubrisson.alwaysdata.net/).

## License
Not yet. Open and free until then.

## Requirements

* Ruby 2.6
* NodeJS 12

## Development installation

To try this website, clone the repo and then install the needed
gems:
```
$ bundle install --without production
```
Since this site uses tailwindCSS via webpack (and webpacker), JS dependencies must be installed too:
```
$ yarn
```
Next, migrate the database:
```
$ rails db:migrate
```
Finally, run the test suite to verify that everything is working
correctly:
```
$ rails db:migrate RAILS_ENV=test
$ rails test
```
If the test suite passes, you'll be ready to run the app in a local
server:
```
$ rails server
```

## Production

You can execute commands on a remote server via SSH.

To lessen the load on the production server, the website is deployed after local precompilation of the css and js.
This allows to skip NodeJS installation and JS dependencies.

On the server, install bundler and the needed gems.
```
$ gem install bundler
$ bundle install --without test development
```
Then migrate:
```
$ rails db:migrate RAILS_ENV=production
```
Then locally precompile the assets.
```
$ rails assets:precompile RAILS_ENV=production
```
The `public/packs` files are then pushed over to the server via git or FTP.

Then trust your host service to start the server.

### Users

Not logged in users can only see public contents.
Logged-in users can see public and private contents.
Admin users can edit, add and remove contents.

Adding users has been voluntarily left-out in the website.
To add a user, use the production console via SSH on the production server:
```
$ rails console -e production
$ @user = User.new(name:'example_user', password:'password', paswword_confirmation:'password')
$ @user.save
```

## CI

Github actions is used to test push and pull-requests.
All dependencies are installed and rails test are run.
The current code coverage of tests is 100% (although a few tests are only here for that).