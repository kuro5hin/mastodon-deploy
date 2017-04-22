#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
/usr/local/bin/docker-compose run --rm web rake mastodon:media:clear
/usr/local/bin/docker-compose run --rm web rake mastodon:push:refresh
/usr/local/bin/docker-compose run --rm web rake mastodon:feeds:clear
/usr/local/bin/docker-compose run --rm web rake mastodon:users:clear
/usr/bin/docker exec mastodon_db_1 pg_dump --clean postgres -U postgres | gzip > /home/rusty/backup/mastodon-backup-$(date +"%Y-%m-%d").sql.gz
