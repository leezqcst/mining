.PHONY: test
test: pep8 clean
	@nosetests --with-coverage --cover-package=mining mining/test
	@$(which gulp.js)

.PHONY: tox-test
tox-test: environment
	@tox

.PHONY: environment
environment:
	@pip install numexpr==2.3
	@pip install -r requirements_dev.txt
	@python setup.py develop
	@npm install bower
	@mv mining/mining.sample.ini mining/mining.ini

.PHONY: install
install:
	@python setup.py install

.PHONY: pep8
pep8:
	@flake8 mining --ignore=F403,F401,F812,E128 --exclude=mining/assets

.PHONY: sdist
sdist: test
	@python setup.py sdist upload

.PHONY: clean
clean:
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name 'Thumbs.db' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} \;
