var express = require('express');
var mongodb = require('mongodb');

var app = express();
var client = mongodb.MongoClient;
var url = process.env.HOST;

app.get('/', function (req, res) {
  res.send('Hello World!');
});

app.get('/mongo', function (req, res) {
  client.connect(url, function (err, db) {
    if (err) {
      res.send(err);
    } else {
      var hits = db.collection('hits');
      var hit = { ip: '', time: '' };

      hits.insert(hit, function (err, result) {
        if (err) {
	  res.send(err);
	} else {
	  hits.count(function (err, count) {
	    if (err) {
	      res.send(err);
	    } else {
	      res.send('<h1>You are the %s visitor</h1>', count);
	      db.close();
	    }
	  });
	}
      });
    }
  });
});


var server = app.listen(8888, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});
