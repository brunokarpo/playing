# Maven
_clean:
	./mvnw clean

_build: _clean
	./mvnw install


# Docker
docker-image-build:
	docker image build -f Dockerfile -t brunokarpo/playing:dev .


docker-container-run: docker-image-build
	docker container run --rm -p 8080:8080 -p 8081:8081 --name playing-dev brunokarpo/playing:dev

docker-container-stop:
	docker container stop playing-dev

# Kubernetes
k8s-apply:
	kubectl -f ./k8s apply

k8s-rollout:
	kubectl rollout restart -f ./k8s/deployment.yml