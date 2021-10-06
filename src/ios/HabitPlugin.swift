import Foundation
import DeviceHealth

@objc(HabitPlugin) public class HabitPlugin : CDVPlugin  {

    override public func pluginInitialize() {
    }

    override public func onAppTerminate() {
    }

    public func getDeviceInfo(_ command: CDVInvokedUrlCommand) {
        let serialnumber = [[command.arguments objectAtIndex:0]];
        let imeinumber = [[command.arguments objectAtIndex:1]];
        CDVPluginResult* pluginResult = nil;
        
        @try {
        DeviceHealthSDK.shared.getDeviceInfo(imei: imeinumber, serialNumber: serialnumber) { (result) in               
                if (result != nil) {
                        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                } else {
                        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:"Some error getting device info"];
                }                                                                                                                                                                    
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        }@catch (NSException* exception) {
              pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
              [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }

    public func performTests(_ command: CDVInvokedUrlCommand) {

        let pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:"Ok"];
        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
    }

}
