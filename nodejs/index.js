var express = require('express');
var cassandra = require('cassandra-driver');
var async = require ('async');

var app = express();

var client = new cassandra.Client( { contactPoints : [ process.env.HOST ] } );
client.connect(function(err, result) {
    console.log('Connected.');
});

app.get('/', function (req, res) {
  res.send('Hello World!');
});

app.get('/metadata', function(req, res) {
    console.log('Host: %s', process.env.HOST);
    res.send(client.hosts.slice(0).map(function (node) {
        return { address : node.address, rack : node.rack, datacenter : node.datacenter }
    }));
});

var server = app.listen(8888, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app listening at http://%s:%s', host, port);
});
