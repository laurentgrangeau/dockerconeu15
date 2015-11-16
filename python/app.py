from flask import Flask, request
from pymongo import MongoClient
import os
import datetime

app = Flask(__name__, static_url_path = "", static_folder = "/code/static")
mongo = MongoClient(host=os.environ.get('HOST'), port=27017)
db = mongo['dockerconeu']

@app.route('/')
def hello():
  db.hits.insert({"ip": request.remote_addr, "ts": datetime.datetime.utcnow()})
  return '<center><img src="/engine.png" /><h1>Welcome Barcelona !</h1><h2>You are the visitor #%s.</h2></center>' % db.hits.count()

@app.route('/api')
def hello_api():
  db.hits.insert({"ip": request.remote_addr, "ts": datetime.datetime.utcnow()})
  return '{ "hits": "%s" }' % db.hits.count()

if __name__ == "__main__":
  app.run(host="0.0.0.0", debug=True)
