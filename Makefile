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
	git push origin gh-pages

publish: build lazycommit push