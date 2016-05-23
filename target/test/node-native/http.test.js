// Generated by CoffeeScript 1.10.0
(function() {
  var http;

  require('../../src/fluentnode');

  http = require('http');

  describe('| node-native | http', function() {
    var server, test_Data, test_Ip, test_Port, url;
    test_Port = 45566 + Math.floor((Math.random() * 100) + 1);
    test_Ip = '127.0.0.1';
    test_Data = 'hello from web';
    url = "http://" + test_Ip + ":" + test_Port;
    server = null;
    before(function(done) {
      server = http.createServer(null);
      return server.listen_OnPort_Saying(test_Port, test_Data, (function(_this) {
        return function() {
          return done();
        };
      })(this));
    });
    after(function(done) {
      return server.close_And_Destroy_Sockets(function() {
        return done();
      });
    });
    it('http_Status', function(done) {
      return url.http_Status(function(status) {
        status.assert_Is(200);
        return done();
      });
    });
    it('http_With_Options', function(done) {
      var options;
      server.respond_With_Request_Headers();
      options = {
        headers: {
          'name': 'value_'.add_5_Random_Letters(),
          'cookie': 'abc=123;'
        }
      };
      return url.http_With_Options(options, function(err, data) {
        var json;
        json = JSON.parse(data);
        json.name.assert_Is(options.headers.name);
        json.cookie.assert_Is('abc=123;');
        return done();
      });
    });
    it('http_With_Options (bad data)', function(done) {
      return url.http_With_Options({
        port: 81
      }, function(err, data, res) {
        assert_Is_Not_Null(err).code.assert_Is('ECONNREFUSED');
        assert_Is_Null(data);
        assert_Is_Null(res);
        return done();
      });
    });
    return it('http_With_Options', function(done) {
      var options, req;
      server.respond_With_Request_Headers();
      options = {
        headers: {
          'name': 'value_'.add_5_Random_Letters(),
          'cookie': 'abc=123;'
        },
        method: 'POST'
      };
      req = url.http_With_Options(options, function(err, data) {
        var expected_Server_Req_Options, json;
        json = JSON.parse(data);
        expected_Server_Req_Options = {
          name: options.headers.name,
          host: test_Ip + ":" + test_Port,
          connection: 'close',
          cookie: 'abc=123;',
          'content-length': '0'
        };
        json.assert_Is(expected_Server_Req_Options);
        return done();
      });
      req.method.assert_Is('POST');
      req._headers.name.assert_Is(options.headers.name);
      req._headers.cookie.assert_Is(options.headers.cookie);
      req._headers.host.assert_Is(test_Ip + ":" + test_Port);
      return req.path.assert_Is('/');
    });
  });

}).call(this);
