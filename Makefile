K8S_DIR = k8s
NAMESPACE = dj-kubernetes

run:
	kubectl apply -f $(K8S_DIR)/namespace.yml
	kubectl apply -f $(K8S_DIR)/config.yml
	kubectl apply -f $(K8S_DIR)/postgres-vol.yml
	kubectl apply -f $(K8S_DIR)/redis-vol.yml
	kubectl apply -f $(K8S_DIR)/static-media-vol.yml
	kubectl apply -f $(K8S_DIR)/postgres.yml
	kubectl apply -f $(K8S_DIR)/redis.yml
	kubectl apply -f $(K8S_DIR)/webapp.yml

destroy:
	kubectl delete -f $(K8S_DIR)/

list_svc:
	kubectl get svc -n $(NAMESPACE)

list_rc:
	kubectl get replicaset -n $(NAMESPACE)

list_dep:
	kubectl get deployment -n $(NAMESPACE)

list_pv:
	kubectl get pv -n $(NAMESPACE)

list_pvc:
	kubectl get pvc -n $(NAMESPACE)

list_pods:
	kubectl get pods -n $(NAMESPACE)

list_nodes:
	kubectl get nodes
logs:
	kubectl logs -n $(NAMESPACE) $(POD) -f
watch_logs:
	watch kubectl logs $(POD) -n $(NAMESPACE)
exec:
	kubectl exec -it $(POD) -n $(NAMESPACE) -- /bin/bash
rollout_deployment:
	kubectl rollout restart deployment/django -n $(NAMESPACE)
