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
      console.log(err);
      res.send(err);
    } else {
      console.log("gros bourrin");

      db.collection('hits').insertOne( { "toto": "tata" } , function (err, result) { if (err) console.log(err); console.log(result); } );

      var hits = db.collection('hits');
      var hit = { "ip": "10.0.0.1", "time": "10" };

      hits.insert(hit, function (err, result) {
        console.log("insert");
        if (err) {
	  console.log(err);
	  res.send(err);
	} else {
	  hits.count(function (err, count) {
	    console.log("count");
	    if (err) {
	      console.log(err);
	      res.send(err);
	    } else {
	      res.send('<h1>You are the %s visitor</h1>', count);
	    }
	  });
	}
      });
    }
    db.close();
  });
});


var server = app.listen(8888, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});
