var exec = require('cordova/exec');

var PLUGIN_NAME = 'HabitPlugin';

exports.getDeviceInfo = function (serialnumber, imei, success, error) {
  exec(success, error, PLUGIN_NAME, "getDeviceInfo", [serialnumber, imei]);
};

exports.performTests = function (appid, apikey, serialnumber, imei, tests, success, error) {
  exec(success, error, PLUGIN_NAME, "performTests", [appid, apikey, serialnumber, imei, tests]);
};

exports.hideStartScreen = function (hide, success, error) {
  exec(success, error, PLUGIN_NAME, "hideStartScreen", [hide]);
};

exports.setLanguage = function (language, imei, success, error) {
  exec(success, error, PLUGIN_NAME, "setLanguage", [language]);
};

exports.setThemeColor = function (red, blue, green, success, error) {
  exec(success, error, PLUGIN_NAME, "setThemeColor", [red, blue, green]);
};
