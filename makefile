init:
	helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

	kubectl apply -f spark-on-k8s/spark-operator-rbac.yaml
	kubectl apply -f spark-on-k8s/spark-operator-with-webhook.yaml
	kubectl apply -f spark-on-k8s/spark-rbac.yaml

citibike-build-image:
	docker build ./transformations/citibike -t citibike:latest

	# docker tag citibike:latest alaurentino/citibike:latest
	# docker push alaurentino/citibike:latest

citibike-run:
	kubectl apply -f ./jobs/citibike-injest.yaml