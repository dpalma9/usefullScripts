from kubernetes import client, config
from kubernetes.client.rest import ApiException
from pprint import pprint

config.load_incluster_config()
api_instance = client.CoreV1Api()
namespace = 'default'

body = client.V1Service()  # V1Serice

# Creating Meta Data
metadata = client.V1ObjectMeta()
metadata.name = "my-service"

body.metadata = metadata

# Creating spec
spec = client.V1ServiceSpec()

# Creating Port object
port = client.V1ServicePort(port=80)
port.protocol = 'TCP'
port.target_port = 8000
#port.port = 80

spec.ports = [ port ]
spec.selector = {"app": "my-custom-app"}

body.spec = spec

try:
    api_response = api_instance.create_namespaced_service(namespace, body)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling CoreV1Api->create_namespaced_service: %s\n" % e)
