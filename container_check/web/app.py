from flask import Flask
from flask import Response
from flask import request
import docker
import urllib
import errno, time

app = Flask(__name__)

MAXIMUM_NUMBER_OF_ATTEMPTS = 3

@app.route('/ping')
def ping():
    return "Pong"

@app.route('/check/url', methods = ['GET', 'POST'])
def check_url():

    if request.method == 'POST' and request.form['url'] != '':
        url = request.form['url']
    else:
        url = "http://127.0.0.1:5000/ping"

    #try:
    #    r = urllib.urlopen(url).getcode()
    #except socket_error:
    #    r = 500

    for attempt in range(MAXIMUM_NUMBER_OF_ATTEMPTS):
        try:
            r = urllib.urlopen(url).getcode()
        except Exception as e: # replace " as " with ", " for Python<2.6
            #if exc.errno == errno.ECONNREFUSED:
            time.sleep(3)
            #else:
            #    raise # re-raise otherwise
        else: # we tried, and we had no failure, so
            break
    else: # we never broke out of the for loop
        #raise RuntimeError("maximum number of unsuccessful attempts reached")
        r = 500


    if r < 500:
        message = "It works !"
    else:
        message = "Outch !!!"

    
    return Response(message, status=r, mimetype='text/plain')

@app.route('/get/containers', methods = ['GET'])
def list_containers():
    client = docker.from_env()

    for container in client.containers.list():
        print client.containers.get(container.id).name

    return "Toto"

@app.route('/put/containers/restart', methods = ['POST'])
def restart_container():
    client = docker.from_env()

    if request.method == 'POST' and request.form['container'] != '':
        container = request.form['container']
        client.containers.get(container).restart()

    return "Toto"

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')