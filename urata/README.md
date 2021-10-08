# README #
Centralized Multi-deployment with Capistrano

## Requirements

| Tools      | Version          | URL                                          |
|------------|------------------|----------------------------------------------|
| ruby       | 2.3.\* or later  | https://www.ruby-lang.org/en/                |
| capistrano | 3.8.1 | http://capistranorb.com/                                |


### How to setup

```
#!script
git clone git@github.com:jazttijaztti/daicho-deploy.git
cd daicho-deploy
git pull origin master
bundle install
cp .env.example .env
```

### How to deploy

### before you deploy

1. add production host on your ~/.ssh/config

2. add github private key to your ssh list like below

```
ssh-add ~/.ssh/daicho-prod
```

if capistrano doesn't run , use 
```
bundle exec cap daicho:production deploy branch=v1.0.2
```


#### v1.0.2

Deploy: 
```
cd path/to/daicho-deploy
cap -T
cap daicho:production deploy branch=v1.0.2
```

Run console command after deploy: 
```
ssh daicho-prod
cd /var/www/html/daicho-prod/current
```

#### <= v1.0.2 

```
#!script

cd path/to/daicho-deploy
cap -T

# Deploy daicho - dev
cap daicho:dev deploy branch=develop

# Deploy daicho - staging
cap daicho:staging deploy branch=develop

# Deploy dacho - prod
cap daicho:production deploy branch=v0.1.2
```
