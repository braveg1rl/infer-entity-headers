build:
	mkdir -p lib
	rm -rf lib/*
	node_modules/.bin/coffee --compile -m --output lib/ src/

watch:
	node_modules/.bin/coffee --watch --compile --output lib/ src/
	
test:
	node_modules/.bin/mocha

jumpstart:
	curl -u 'meryn' https://api.github.com/user/repos -d '{"name":"infer-entity-headers", "description":"Infers http entity headers from path, entity and existing headers.","private":false}'
	mkdir -p src
	touch src/infer-entity-headers.coffee
	mkdir -p test
	touch test/infer-entity-headers.coffee
	npm install
	git init
	git remote add origin git@github.com:meryn/infer-entity-headers
	git add .
	git commit -m "jumpstart commit."
	git push -u origin master

.PHONY: test