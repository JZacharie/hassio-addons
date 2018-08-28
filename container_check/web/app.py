from flask import Flask
from flask import Response
from flask import request
import urllib

app = Flask(__name__)

@app.route('/ping')
def ping():
    return "Pong"

@app.route('/check_url', methods = ['GET', 'POST'])
def check_url():

    if request.method == 'POST' and request.form['url'] != '':
        url = request.form['url']
    else:
        url = "http://127.0.0.1:5000/ping"

    r = urllib.urlopen(url).getcode()
    if r == 200:
        return Response("It works !", status=200, mimetype='text/plain')
    else:
        return Response("Outch !!!", status=200, mimetype='text/plain')

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')