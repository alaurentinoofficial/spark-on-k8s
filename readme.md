# Prerequisites

* Helm
* Kubernetes
* Docker
* `OPTIONAL` Apache Spark localy >= 3.0.0

<br>
<br>

# Instalation

The following command add the spark operator repository in helm and install at namespace `spark-operator`. After that, configure the rbac. permitions

```bash
make init
```

<br>
<br>

# Execute

### Run job Kubernetes
Execute the spark application using kubernetes
```bash
make run
```

### Run job localy using spark submit
Execute the spark application using spark submit
```bash
make run
```