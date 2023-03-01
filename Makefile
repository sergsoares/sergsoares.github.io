build:
	hugo

run:
	hugo server --disableFastRender

create-%:
	hugo new posts/installing-binaries.md

lazycommit:
	git add .
	git commit -m "Updated articles"

push:
	git push origin master

publish: build lazycommit push