import Foundation
import DeviceHealth

@objc(HabitPlugin) public class HabitPlugin : CDVPlugin  {

    override public func pluginInitialize() {
    }

    override public func onAppTerminate() {
    }

    public func getDeviceInfo(_ command: CDVInvokedUrlCommand) {
        let serialnumber = command.arguments[0] as? String ?? ""
        let imeinumber = command.arguments[1] as? String ?? ""
        
        DeviceHealthSDK.shared.getDeviceInfo(imei: imeinumber, serialNumber: serialnumber) { (result) in               
                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: result)
                self.commandDelegate.send(result, callbackId: command.callbackId)
        }
    }

    public func performTests(_ command: CDVInvokedUrlCommand) {

        let pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:"Ok"];
        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
    }

}
