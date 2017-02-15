build:
	hugo
	./rewrite.sh
publish:
	git subtree push  --prefix=public origin gh-pages --squash 
	ssh dstefan@login.eng.ucsd.edu 'cd public_html/cse130-winter17/ && git pull'
remove:
	git push origin :gh-pages
