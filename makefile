init:
	helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

	kubectl apply -f manifest/spark-operator-rbac.yaml
	kubectl apply -f manifest/spark-operator-with-webhook.yaml
	kubectl apply -f manifest/spark-rbac.yaml

deploy:
	docker build ./transformations/citibike -t citibike:latest

	# docker tag citibike:latest alaurentino/citibike:latest
	# docker push alaurentino/citibike:latest

citibike-run:
	kubectl apply -f ./jobs/citibi-injest.yaml