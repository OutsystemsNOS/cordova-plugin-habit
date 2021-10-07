import Foundation
import DeviceHealth

@objc(HabitPlugin) public class HabitPlugin : CDVPlugin  {

    override public func pluginInitialize() {
    }

    override public func onAppTerminate() {
    }
    
    @objc(getDeviceInfo:)
    public func getDeviceInfo(_ command: CDVInvokedUrlCommand) {
        let serialnumber = command.arguments[0] as? String ?? ""
        let imeinumber = command.arguments[1] as? String ?? ""
        
        DeviceHealthSDK.shared.getDeviceInfo(imei: imeinumber, serialNumber: serialnumber) { (result) in  
            DispatchQueue.main.async {
                let text = self.JSONStringify(result!, prettyPrinted: true)
            }
        }
    }
    
    func JSONStringify(_ value: [String:Any],prettyPrinted:Bool = false) -> String
    {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)

        if JSONSerialization.isValidJSONObject(value) {

            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            } catch {

//                dLog(message: "error")
            }
        }
        return ""

    }

}
