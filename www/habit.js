var exec = require('cordova/exec');

var PLUGIN_NAME = 'HabitPlugin';

exports.getDeviceInfo = function (serialNumber, IMEI, success, error) {
  exec(success, error, "getDeviceInfo", [serialNumber, IMEI]);
};
