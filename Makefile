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