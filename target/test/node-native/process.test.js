// Generated by CoffeeScript 1.8.0
(function() {
  var os;

  require('../../src/fluentnode');

  os = require('os');

  describe('| process |', function() {
    it('start_Process', function() {
      ''.start_Process.assert_Is_Function();
      if (os.platform() === 'win32') {
        'cmd'.start_Process('/c', 'echo').assert_Is_Object().constructor.name.assert_Is('ChildProcess');
        return 'cmd'.start_Process('/c').pid.assert_Is_Number();
      } else {
        'echo'.start_Process().assert_Is_Object().constructor.name.assert_Is('ChildProcess');
        return 'echo'.start_Process().pid.assert_Is_Number();
      }
    });
    if (os.platform() === 'win32') {
      return;
    }
    it('start_Process_Redirect_Console', function(done) {
      var childProcess, log_Messages, original_log;
      original_log = console.log;
      log_Messages = [];
      console.log = function(logMsg) {
        return log_Messages.push(logMsg);
      };
      childProcess = 'ls'.start_Process_Redirect_Console('.');
      return childProcess.on('exit', function() {
        console.log('process ended');
        log_Messages.first().assert_Contains('README.md');
        log_Messages.second().assert_Is('process ended');
        console.log = original_log;
        return done();
      });
    });
    return it('String::start_Process_Capture_Console_Out', function(done) {
      var runTest, runTests, testsData;
      runTest = function(testData, next) {
        var expected_Data, name, parameter;
        name = testData.process_Name;
        parameter = testData.process_Parameter;
        expected_Data = testData.expected_Data;
        return name.start_Process_Capture_Console_Out(parameter, function(data) {
          data.assert_Is(expected_Data);
          return next();
        });
      };
      runTests = function(testsData, next) {
        if (testsData.empty()) {
          return next();
        } else {
          return runTest(testsData.pop(), function() {
            return runTests(testsData, next);
          });
        }
      };
      testsData = [
        {
          process_Name: 'echo',
          process_Parameter: 'hello',
          expected_Data: 'hello\n'
        }, {
          process_Name: 'echo',
          process_Parameter: ['hello', 'me'],
          expected_Data: 'hello,me\n'
        }, {
          process_Name: 'echo',
          process_Parameter: [],
          expected_Data: '\n'
        }, {
          process_Name: 'echo',
          process_Parameter: [null],
          expected_Data: '\n'
        }, {
          process_Name: 'git',
          process_Parameter: ['xyz'],
          expected_Data: 'git: \'xyz\' is not a git command. See \'git --help\'.\n'
        }
      ];
      return runTests(testsData, done);
    });
  });

}).call(this);
