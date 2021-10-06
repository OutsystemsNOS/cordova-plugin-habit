import Foundation
import DeviceHealth

@objc(HabitPlugin) public class HabitPlugin : CDVPlugin  {

    override public func pluginInitialize() {
    }

    override public func onAppTerminate() {
    }

    public func getDeviceInfo(_ command: CDVInvokedUrlCommand) {

        let pluginResult = CDVPluginResult(status:CDVCommandStatus_OK, messageAsString:@"Ok")
        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
    }

    public func performTests(_ command: CDVInvokedUrlCommand) {

        let pluginResult = CDVPluginResult(status:CDVCommandStatus_OK, messageAsString:@"Ok")
        self.commandDelegate?.send(pluginResult, callbackId: command.callbackId)
    }

}
