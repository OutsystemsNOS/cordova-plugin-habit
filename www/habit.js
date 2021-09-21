var exec = require('cordova/exec');

var PLUGIN_NAME = 'HabitPlugin';

exports.getDeviceInfo = function (serialnumber, imei, success, error) {
  exec(success, error, PLUGIN_NAME, "getDeviceInfo", [serialnumber, imei]);
};

exports.performTests = function (appid, apikey, serialnumber, imei, tests, success, error) {
  exec(success, error, PLUGIN_NAME, "performTests", [appid, apikey, serialnumber, imei, tests]);
};
