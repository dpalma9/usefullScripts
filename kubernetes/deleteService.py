from kubernetes import client, config
from kubernetes.client.rest import ApiException
from pprint import pprint

config.load_incluster_config()
api_instance = client.CoreV1Api()
namespace = 'pcf-ct-yhn7l7en'
namespace = 'a-namespace'
service_name = 'my-service'

try:
        api_response = api_instance.delete_namespaced_service(name=service_name, namespace=namespace)
        pprint(api_response)
except ApiException as e:
        print("Exception when calling CoreV1Api->delete_namespaced_service: %s\n" % e)
