import threading
from http.server import BaseHTTPRequestHandler, HTTPServer
import socketserver
import logging
import requests
import json

# Class with treads to handle post request to the server
class publish_Thread(threading.Thread):

    def __init__(self, data):
        threading.Thread.__init__(self)
        self.data = data;

    def run(self):

        log_prefix = '      [Publish trigger request] '

        headers = {
            'Content-Type': 'application/json'
        }

        data2 = json.loads(self.data)
        s = json.dumps(data2, indent=4, sort_keys=True)
        print(f'Body: {s}')
        logging.info(s)

        endpoint = "https://myserver.com"
        print(f'{log_prefix}Sending request to {endpoint}')
        logging.info(f'{log_prefix}Sending request to {endpoint}')
        r = requests.post(endpoint, data=s, headers=headers)
        print(f'{log_prefix}Response {r.status_code}')
        logging.info(f'{log_prefix}Response {r.status_code}')
        print(f'{log_prefix}Received data {r.text}')
        logging.info(f'{log_prefix}Received data {r.text}')

class testHTTPServer_RequestHandler(BaseHTTPRequestHandler):

    # GET
    def do_GET(self):
            self.send_response(200)

            self.send_header('Content-type','text/html')
            self.end_headers()

            message = "OK! I'm working"
            logging.info(message)
            self.wfile.write(bytes(message, "utf8"))
            return
    
    # Handle body data (in case the request has one)
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        parse_body = json.loads(post_data.decode('utf-8'))
        logging.info("POST request,\nPath: %s\nHeaders:\n%s\n\nBody:\n%s\n",
                        str(self.path), str(self.headers), parse_body)

        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write("POST request for {}".format(self.path).encode('utf-8'))

        ##Start one thread to handle POST
        #thread_for_request = publish_Thread(post_data)
        #thread_for_request.start()

        return

def run():
    print('starting server...')

    PORT = 9000
    server_address = ('0.0.0.0', PORT)
    httpd = HTTPServer(server_address, testHTTPServer_RequestHandler)
    print('running server at port ', PORT)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
        httpd.server_close()

logging.basicConfig(filename="/var/log/output.log",
                        filemode='a',
                        format='%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s',
                        datefmt='%H:%M:%S',
                        level=logging.DEBUG)
run()

