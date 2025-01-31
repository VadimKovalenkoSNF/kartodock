############################# Useful commands for kartodock operations #############################
include .env

# Run osm-initial-import
#
# Usage: make osm \
# 			ARGS='-p http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf'
osm:
	docker-compose exec workspace osm-initial-import $(ARGS) -s -H postgres-postgis

generate_config:
	docker-compose exec kartotherian generate_config

run_kartotherian:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && node /home/kartotherian/packages/kartotherian/server.js -c /etc/opt/config.kartotherian.docker.yaml"

npm_test:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && npm test"

npm_install:
	docker-compose exec kartotherian bash -c ". /.nvm/nvm.sh && nvm use 10.15.2 && npm install --unsafe-perm"

npm_link:
	docker-compose exec kartotherian bash -c "cd /srv/dependencies/osm-bright.tm2source && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link"
	docker-compose exec kartotherian bash -c "cd /srv/dependencies/osm-bright.tm2 && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link"
	docker-compose exec kartotherian bash -c "cd /home/kartotherian/packages/kartotherian && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link @kartotherian/osm-bright-source"
	docker-compose exec kartotherian bash -c "cd /home/kartotherian/packages/kartotherian && . /.nvm/nvm.sh && nvm use 10.15.2 && npm link @kartotherian/osm-bright-style"

clean:
	docker-compose exec kartotherian bash -c "./clean_node_modules.sh"

imposm_run:
	docker-compose exec workspace bash -c "imposm run -config /etc/imposm/config.json" -expiretiles-zoom 15

# pregen_dequeue:
#     docker-compose exec tegola /etc/pregenerate-maps-tile.sh
#
# pregen_enqueue:
#     docker-compose exec tegola poppy --broker-url redis://redis:6379 --queue-name pregen enqueue --message-entry tile 1/1/1

install:
	# TODO
	# Check if kartotherian is installed and clone if it isn't
	# docker-compose up --build kartotherian
	# Execute (clean and?) npm install
	# Execute osm-initial-import
	# Execute generate_config
	# Execute keyspace_setup
	# Execute kartotherian monorepo tests
