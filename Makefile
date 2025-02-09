run:
	kubectl apply -f k8s/namespace.yml
	kubectl apply -f k8s/config.yml
	kubectl apply -f k8s/postgres-vol.yml
	kubectl apply -f k8s/redis-vol.yml
	kubectl apply -f k8s/static-media-vol.yml
	kubectl apply -f k8s/postgres.yml
	kubectl apply -f k8s/redis.yml
	kubectl apply -f k8s/webapp.yml
destroy:
	kubectl delete -f k8s/
list_svc:
	kubectl get svc -n django-app
list_rc:
	kubectl get replicaset -n django-app
list_dep:
	kubectl get deployment -n django-app
list_pv:
	kubectl get pv -n django-app
list_pvc:
	kubectl get pvc -n django-app
list_pods:
	kubectl get pods -n django-app
