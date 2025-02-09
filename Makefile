run:
	kubectl apply -f k8s/
destroy:
	kubectl delete -f k8s/
list_services:
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
