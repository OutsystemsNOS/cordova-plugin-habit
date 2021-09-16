var exec = require('cordova/exec');

var PLUGIN_NAME = 'HabitPlugin';

exports.getDeviceInfo = function (number, success, error) {
  exec(success, error, PLUGIN_NAME, "getDeviceInfo", [number]);
};
