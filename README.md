# Sample Deployment Of Django Application With:
- Redis
- Postgres
- Persistent Volumes (use local mount path)

Basically a 3 django application container is runing behind a LoadBalancer. So, to get a service list: ``make list_svc``
And make sure, a minikube tunnel is started with ``minikube tunnel``

**Start Minikube Tunnel**
```sh
> minikube tunnel

Status:	
	machine: minikube
	pid: 229645
	route: 10.96.0.0/12 -> 192.168.39.66
	minikube: Running
	services: [webapp-svc]
    errors: 
		minikube: no errors
		router: no errors
		loadbalancer emulator: no errors
```

It says that, the cluster CIDR ``10.96.0.0/12`` is routed to ``192.168.39.66`` on host machine.

**Get LoadBalancer Port Mapping For Host Machine**
```sh
> make list_svc

NAME           TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)          AGE
postgres-svc   ClusterIP      10.104.163.24    <none>           5432/TCP         17m
redis-svc      ClusterIP      10.108.160.127   <none>           6379/TCP         17m
webapp-svc     LoadBalancer   10.103.163.110   10.103.163.110   8000:31073/TCP   17m
```

webapp-svc is runing on port 8000 on container, and its port is mapped to ``31073``. So, the application is accessible at:

```sh
http://192.168.39.66:31073
```

# Make Commands:

- **Create resources:** ``make run``

- **Destroy resources:** ``make destroy``

- **List Services:** ``make list_svc``

- **List ReplicaSets:** ``make list_rc``

- **List Deployments:** ``make list_dep``

- **List Deployments:** ``make list_dep``

- **List PersistentVolumes:** ``make list_pv``

- **List PersistentVolumesClaims:** ``make list_pvc``

- **List Pods:** ``make list_pods``

## Kubernetes Handy Commands:

- **Drop shell context into pods:** ``kubectl exec -it <pod-name> -n django-app -- /bin/bash``

- **Watch Logs:** `` watch kubectl logs <pod_name> -n django-app``

Here, ``django-app`` is the namespace.

# Reference Follow For Solving Related Errors:

- [CreateContainerConfigError](https://stackoverflow.com/questions/63059963/kubernete-createcontainerconfigerror)

- [Kubernetes Resource Creation](https://github.com/sbhusal123/kubernetes-curated/tree/main/Curated%20Reference/Resource%20Creation)
