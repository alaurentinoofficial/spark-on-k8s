init:
	helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
	helm install spark spark-operator/spark-operator --namespace spark-operator
	
	kubectl apply -f init/spark-operator-rbac.yaml
	kubectl apply -f init/spark-operator-with-webhook.yaml
	kubectl apply -f init/spark-rbac.yaml

build-image:
	docker build . -t spark-etl-jobs:latest

deploy-image:
	docker tag spark-etl-jobs:latest alaurentino/spark-etl-jobs:latest
	docker push alaurentino/spark-etl-jobs:latest

build-deploy-image: build-image deploy-image

run:
	kubectl apply -f spark-application.yaml

spark-submit:
	spark-submit \
	--master local \
	--conf spark.hadoop.google.cloud.auth.service.account.enable=true \
	--conf spark.hadoop.fs.gs.auth.service.account.email="$ACCOUNT_EMAIL" \
	--conf spark.hadoop.fs.gs.project.id="$PROJECT_ID" \
	--conf spark.hadoop.fs.gs.auth.service.account.private.key.id="$STORAGE_KEY_ID" \
	--conf spark.hadoop.fs.gs.auth.service.account.private.key="$STORAGE_KEY" \
	src/ingest.py