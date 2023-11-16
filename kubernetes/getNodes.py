import os

from kubernetes import client
from distutils import util


def load_k8s_api_config():
    config = client.Configuration()
    config.host = os.getenv('KUBE_HOST', "https://localhost:443")
    config.verify_ssl = util.strtobool(os.getenv('KUBE_VERIFY_SSL', "false"))
    if config.verify_ssl:
        config.ssl_ca_cert = os.getenv('KUBE_CA_CERT', "/path/to/ssl_ca_cert")
    else:
        config.ssl_ca_cert = None
    token = get_k8s_token()
    config.api_key = {"authorization": "Bearer " + token}
    config.debug = util.strtobool(os.getenv('KUBE_DEBUG', "false"))
    if os.getenv('KUBE_HTTP_PROXY'):
        config.proxy = os.getenv('KUBE_HTTP_PROXY')
    return config


def get_k8s_token():
    if os.getenv('KUBE_API_KEY'):
        return os.getenv('KUBE_API_KEY')
    else:
        f = open("/var/run/secrets/kubernetes.io/serviceaccount/token", "r")
        token = f.read()
        return token

## API CONF
config = load_k8s_api_config()
k8s_api = client.ApiClient(config)
core_v1 = client.CoreV1Api(k8s_api)
nodes = core_v1.list_node(watch=False)

print("Tipo de dato que es nodes --> " + str(type(nodes.items)))
for node in nodes.items:
  if node.spec.unschedulable:
    nodes.items.remove(node)
    print("He borrado el nodo por estar acordonado: " + node.metadata.name)

