var exec = require('cordova/exec');

var PLUGIN_NAME = 'HabitPlugin';

exports.getDeviceInfo = function (number, imei, success, error) {
  alert("number: " + number + " imei: " + imei);
  //var result = exec(success, error, PLUGIN_NAME, "getDeviceInfo", [number, imei]);
  var result = exec("getDeviceInfo", [number, imei], success, error);
  if(result)
  {alert("true");}
  else
  {alert("false");}
};
