# wpops (terra)

Scripts for deploying LEMP apps (wordpress, etc) on digital ocean (or other provider)

> Created: 2019

> Note: This repo is code demo only
> 

## SSH Access

Generate new key
```
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -f terra
```

Upload key to droplet

Add key to ssh config file
```
nano ~/.ssh/config

Host {new-host}
    HostName {ip}
    IdentityFile ~/.ssh/terra
```

Login to droplet
```
ssh root@{new-host}
```


## Setup

Add sudo user before cloning

```sh
adduser terra
usermod -aG sudo terra
su - terra
```

Clone repo

```sh
cd ~
git clone https://github.com/syelanin/wpops.git
cd wpops
```


## Usage

### Launch Wordpress

Update config in wp/example.com.conf

```sh
./wp.sh example.com
```
### Launch LEMP

Update config in lemp/am.conf

```sh
./lemp.sh example.com
```

### Launch vhost (on LEMP droplet)

Update config in vhost/example.com.conf

```sh
./vhost.sh example.com
```

### Install klo

1. create droplet

2. assign domain symtrackbin.pro

3. install lemp
```sh
./lemp.sh klo
./vhost.sh klo.dev
```

4. copy imklo_xxx.zip to host

5. unzip file
```sh
unzip imklo_xxx.zip
```

1. unzip klo.sql.zip

2. create tables
```sh
sudo mysql -D klo -u root -p < klo.sql
```

8. copy files
```sh
cd ~/imklo/klo
sudo cp -r * /var/www/symtrackbin.pro
cd /var/www/symtrackbin.pro
sudo chown -R www-data: *
sudo mv index.html index.html_
```

9. update db in config

```sh
sudo nano /var/www/symtrackbin.pro/application/config/database.php
$db['default']['username'] = 'klo';
$db['default']['password'] = 'mypass';
$db['default']['database'] = 'klo';
```

10. update domain in config

```sh
sudo nano /var/www/symtrackbin.pro/application/config/config.php
$config['base_url'] = 'http://symtrackbin.pro';
```

11. update permissions for db folder

```sh
sudo chmod -R 777 /var/www/symtrackbin.pro/application/db
```

12. create cron tasks

```sh
sudo crontab -e

1 * * * * wget -O /dev/null -q http://symtrackbin.pro/api/update_net
1 1 * * * wget -O /dev/null -q http://symtrackbin.pro/api/update_sx
1 * * * * wget -O /dev/null -q http://symtrackbin.pro/api/update_status_domains

sudo crontab -l
```

13. login
http://symtrackbin.pro
user: admin_kloak
pass: iambigpassword


### Install klo (vestacp)

almost all from above except dependecies are installed by vestacp

https://www.digitalocean.com/community/tutorials/how-to-install-vestacp-and-migrate-user-data
https://www.digitalocean.com/community/tutorials/how-to-install-vestacp-and-set-up-a-website-on-ubuntu-14-04
http://www.servermom.org/vesta-cp-mysql-root-password/

add db via vesta and import sql in phpmyadmin

copy files to /home/admin/web/symtrackbin.pro/public_html
chown -R admin: /home/admin/web/symtrackbin.pro/public_html/

update config files as in above section
change mysql to mysqli in /home/admin/web/symtrackbin.pro/public_html/application/config/database.php

update permissions for db folder

add cron entries via vesta
