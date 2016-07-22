all : publish

update_theme :
	rm -rf theme/hyde-y
	cp -R /Users/sglyon/personal_website/themes/hyde-y themes

publish :
	hugo  # run once to update public
	ghp-import -n -p public
