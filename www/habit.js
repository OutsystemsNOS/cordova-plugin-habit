var exec = require('cordova/exec');

var PLUGIN_NAME = 'HabitPlugin';

exports.getDeviceInfo = function (number, imei, success, error) {
  cordova.exec(success, error, PLUGIN_NAME, "getDeviceInfo", [number, imei]);
};
