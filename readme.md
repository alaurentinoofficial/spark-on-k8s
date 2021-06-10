
### Add the repository
```bash
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
```

### Configure the init steps of the spark operator
```bash
kubectl apply -f manifest/spark-operator-rbac.yaml
kubectl apply -f manifest/spark-operator-with-webhook.yaml
kubectl apply -f manifest/spark-rbac.yaml
```

### Run job
```bash
kubectl apply -f jobs/citibi-injest.yaml
```