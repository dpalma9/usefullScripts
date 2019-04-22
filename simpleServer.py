from http.server import BaseHTTPRequestHandler, HTTPServer
import socketserver

class testHTTPServer_RequestHandler(BaseHTTPRequestHandler):

  # GET
  def do_GET(self):
        self.send_response(200)

        self.send_header('Content-type','text/html')
        self.end_headers()

        message = "OK"
        self.wfile.write(bytes(message, "utf8"))
        return

def run():
  print('starting server...')

  PORT = 8081
  server_address = ('127.0.0.1', PORT)
  httpd = HTTPServer(server_address, testHTTPServer_RequestHandler)
  print('running server at port ', PORT)
  try:
    httpd.serve_forever()
  except KeyboardInterrupt:
    pass
    httpd.server_close()

run()

