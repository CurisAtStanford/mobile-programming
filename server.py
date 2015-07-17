import BaseHTTPServer, SimpleHTTPServer
import ssl
 
web_server = BaseHTTPServer.HTTPServer(('localhost', 8000), SimpleHTTPServer.SimpleHTTPRequestHandler)
web_server.socket = ssl.wrap_socket (web_server.socket, 
                                     server_side=True,
                                     certfile="./server/crt.crt",
                                     keyfile="./server/key.key")
web_server.serve_forever()

