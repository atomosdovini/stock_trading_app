# STOCK TRADING APP
## Where?
- The stock trading app can be found on GitHub at the following repository: [GitHub](https://github.com/ler-Rith)

## Installation Guide

### Run with Docker
#### requirements
- git
- docker

### Clone and Configure the App
- Clone the stock trading app repository:
    `git clone git@github.com:bh.git`
  - Navigate to the app directory 
~~~
cd stock_trading_app
~~~
Run
~~~
sudo docker-compose up --build 
~~~
| check  `config/database.yml` need to set `host: db`

This will create database for test and development, run the tests using RSpec and run the Application
#### Check the app open

`http://localhost:3000/stocks`

----------------------------------------------------------------    

### Runing and Installing on Ubuntu 20.04
- Using rbenv installing ruby 2.7.6
- Installation base using [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-18-04-pt) - 

#### Prepare the Environment

Update the system:
```
sudo apt-get update
```
Install the necessary dependencies for Ruby:

```
sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev
```

**Install rbenv**

Install `rbenv`, a Ruby version manager:

```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```

Add rbenv to your PATH. If you're using Bash, run:

```
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

If you're using Zsh, run:

```
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
source ~/.zshrc
```
```
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

Install the desired Ruby version. In this case, we will install Ruby `2.7.6`:

```
rbenv install 2.7.6
```

Set the global Ruby version to 2.7.6:

```
rbenv global 2.7.6
```

**Install Bundler and Rails**

```
gem install bundler
gem install rails -v 6.0.3
```

**Install Node.js and Yarn**

Install Node.js using nvm (Node Version Manager):

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

or

```
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

Add the following lines to your shell profile (e.g., ~/.bashrc or ~/.zshrc):

```
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

Install the LTS version of Node.js using nvm:

`nvm install --lts`

Using `node -v` to verify node version 

**Install Yarn:**

```
sudo apt update && sudo apt install --no-install-recommends yarn
```

**Install postgreSQL**

```
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib libpq-dev
```

Change password for postgres user

```
sudo -i -u postgres
```

Access postgres 

```bash
postgres@...
$ psql
```

Change password for dev user

```
postgres=# ALTER USER postgres WITH ENCRYPTED password 'postgres';
postgres=# CREATE USER dev WITH SUPERUSER PASSWORD 'de123';
postgres=# \q
```

exit postgres

```
postgres@...
$ exit
```

### Git necessary

### Clone and Configure the App
- Clone the stock trading app repository:
    `git clone git@github.com:bh.git`
  - Navigate to the app directory:
  - run
~~~
cd stock_trading_app
~~~
If runing without docker, In `config/database.yml` you need to set

`host: localhost`
~~~
bundle install
~~~
Create databases for test and development
~~~
rails db:create
rails db:migrate
~~~
run tests
~~~
bundle exec rspec
~~~
run the app 
~~~
rails s
~~~
or just run all togheter
~~~
bundle install && rails db:create && rails db:migrate && bundle exec rspec && rails s
~~~
### Access:
~~~
http://localhost:3000
~~~

-----
Personal Considerations


The application provides users with the ability to manage and trade stocks. It leverages a public API to fetch real-time stock data, which is then stored in our database. Periodically, the stock data is refreshed to ensure up-to-date information for users to make informed decisions.

When a user decides to buy stocks, they can specify the desired quantity. The purchase transaction is recorded in the Operations table of our database, capturing details such as the transaction value and the corresponding stock_id. The Stocks table contains essential information about each stock, including its name and symbol.

It's important to note that selling stocks is only possible if the user has previously purchased them. Users must own the stocks they wish to sell. To review their transaction history, users can navigate to the 'My Operations' section, where they can access a comprehensive record of their buying and selling activities.

In summary, the application empowers users to actively manage their stock portfolio by buying and selling stocks.