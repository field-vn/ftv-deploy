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
bundle install
cp .env.example .env
```

### How to deploy

### before you deploy

1. add production host on your ~/.ssh/config

2. add github private key to your ssh list like below

```
ssh-add ~/.ssh/hirusyoku-prod
```

if capistrano doesn't run , use 
```
bundle exec cap hirusyoku:production deploy branch=v1.0.2
```


#### v1.0.2

Deploy: 
```
cd path/to/ftv-deploy/hotelhr
cap -T
cap hotelhr:production deploy branch=master
```

Run console command after deploy: 
```
ssh hotelhr
cd /var/www/html/hotelhr/current
```

#### <= v1.0.2 

```
#!script

cd path/to/ftv-deploy/hotelhr
cap -T

# Deploy hotelhr - staging
cap hirusyhotelhroku:staging deploy branch=develop

# Deploy hotelhr - prod
cap hotelhr:production deploy branch=master
```
