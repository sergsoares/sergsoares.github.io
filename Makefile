build:
	hugo

run:
	hugo server --disableFastRender

create-%:
	hugo new posts/installing-binaries.md

push:
	git push origin master