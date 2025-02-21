from django.http import JsonResponse
import json

import os

def foo_view(request):
    if request.method == "GET":
        return JsonResponse({"message": "Hello, this is a GET request!"})
    
    elif request.method == "POST":
        try:
            data = json.loads(request.body)
            return JsonResponse({"message": "Received data!", "data": data})
        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON"}, status=400)
    
    return JsonResponse({"error": "Method not allowed"}, status=405)


def host_name(request):
    return JsonResponse({
        "status": "Ok",
        "hostname": os.environ.get('HOSTNAME', "unknown")
    })
