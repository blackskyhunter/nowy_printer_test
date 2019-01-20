.PHONY: test

docker_run: docker_build
	docker run \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d hello-world-printer

docker_build:
	docker build -t hello-world-printer .

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

test:
	PYTHONPATH=. py.test --verbose -s

USERNAME=blackskyhunter
TAG=$(blackskyhunter)/hello-world-printer

docker_push: docker_build
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD); \
	docker tag hello-world-printer $(TAG); \
	docker logout;
