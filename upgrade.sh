# WIP
# PROBABLY DON'T USE THIS

#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# generate a db snapshot before the upgrade
echo "Backing up the database to /home/rusty/backup/mastodon-backup-upgrade-snapshot.sql.gz..."
/usr/bin/docker exec mastodondeploy_db_1 pg_dump --clean postgres -U postgres | gzip > /home/rusty/backup/mastodon-backup-upgrade-snapshot.sql.gz
# Reload this tarball with
# cat /home/rusty/backup/mastodon-backup-upgrade-snapshot.sql.gz | gunzip | /usr/bin/docker exec -i mastodondeploy_db_1 psql postgres -U postgres 

# tag the old images for rollback
echo "Tagging current mastodon images :rollback..."
/usr/bin/docker tag gargron/mastodon:latest gargron/mastodon:rollback

/usr/local/bin/docker pull gargron/mastodon

./restart.sh
docker image prune -f
