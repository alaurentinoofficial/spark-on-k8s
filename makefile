init:
	helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

	kubectl apply -f spark-on-k8s/spark-operator-rbac.yaml
	kubectl apply -f spark-on-k8s/spark-operator-with-webhook.yaml
	kubectl apply -f spark-on-k8s/spark-rbac.yaml

build-image:
	docker build . -t spark-etl-jobs:latest

	# docker tag spark-etl-jobs:latest alaurentino/spark-etl-jobs:latest
	# docker push alaurentino/spark-etl-jobs:latest

citibike-run:
	kubectl apply -f spark-application.yaml