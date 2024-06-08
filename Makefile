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

docker-run:
	docker run -p 127.0.0.1:1313:1313 sergsoares

docker-run-live:
	docker run -p 127.0.0.1:1313:1313 sergsoares-live

analysis-docker:
	dive sergsoares