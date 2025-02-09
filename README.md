# Sample Deployment Of Django Application With:
- Redis
- Django
- Persistent Volumes (use local mount path)

# Commands:
Refer [Makefile](./Makefile)

# Handy Commands:

- **Drop shell context into pods:** ``kubectl exec -it <pod-name> -n django-app -- /bin/bash``


# Reference Follow For Solving Related Errors:

- [CreateContainerConfigError](https://stackoverflow.com/questions/63059963/kubernete-createcontainerconfigerror)

- [Kubernetes Resource Creation](https://github.com/sbhusal123/kubernetes-curated/tree/main/Curated%20Reference/Resource%20Creation)
