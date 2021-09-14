var exec = require('cordova/exec');

var PLUGIN_NAME = 'HabitPlugin';

exports.getDeviceInfo = function (name, obj, success, error) {
  exec(success, error, PLUGIN_NAME, "getDeviceInfo", obj);
};
