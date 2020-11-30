![](https://github.com/kleer-la/template2_6_5/workflows/Ruby/badge.svg)

https://travis-ci.com/github/GitPabloS/BuscaMinasInge

trello.com/b/D0qDIltu/busca-minas 

### Para el setup sin docker:

install ruby 2.6.5

Setup:
	sudo apt-get install phantomjs

on the project root:
	gem install bundler
	bundle install

to run app:
	ruby app.rb

for unit test:
	rspec

for acceptance test:
	cucumber