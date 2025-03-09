run:
	hugo server --disableFastRender

build:
	hugo

create-%:
	hugo new posts/installing-binaries.md

lazycommit:
	git add .
	git commit -m "Updated articles"

push:
	git push origin master

publish: build lazycommit push

submodule:
	git submodule init
	git submodule update

docker-build:
	docker build -t sergsoares .

docker-build-live:
	docker build -t sergsoares-live -f Dockerfile.live .

docker-build-dev:
	docker build -t sergsoares-dev -f Dockerfile.dev .

docker-run:
	docker run -p 127.0.0.1:1313:1313 sergsoares

docker-run-live:
	docker run -p 8081:1313 sergsoares-live

init-preview:
	docker run --rm -d --name sergsoares-live -p 8080:1313 sergsoares-live

run-dev:
	docker run --rm -v /home/xubuntu/tasks/sergsoares.github.io:/app --network host -d --name sergsoares-dev sergsoares-dev

logs-dev:
	docker logs sergsoares-dev

stop-dev:
	docker stop sergsoares-dev

stop-preview:
	docker stop sergsoares-live

analysis-docker:
	dive sergsoares
