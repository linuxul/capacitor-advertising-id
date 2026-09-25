import Foundation
import Capacitor

@objc(AdvertisingIdPlugin)
public class AdvertisingIdPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AdvertisingIdPlugin"
    public let jsName = "AdvertisingId"
    public let pluginMethods: [CAPPluginMethod] = [
        .async("requestTracking", AdvertisingIdPlugin.requestTracking),
        .promise("getAdvertisingId", AdvertisingIdPlugin.getAdvertisingId),
        .promise("getAdvertisingStatus", AdvertisingIdPlugin.getAdvertisingStatus)
    ]
    private let implementation = AdvertisingId()

    /// Presents the App Tracking Transparency prompt, from the main actor, and returns the answer.
    @MainActor
    func requestTracking(_ call: CAPPluginCall) async -> JSObject {
        let status = await implementation.requestTracking()
        return ["value": status.name()]
    }

    func getAdvertisingId(_ call: CAPPluginCall) {
        let id = implementation.getAdvertisingId()
        let status = implementation.getAdvertisingStatus()
        call.resolve([
            "id": id,
            "status": status.name()
        ])
    }

    func getAdvertisingStatus(_ call: CAPPluginCall) {
        let status = implementation.getAdvertisingStatus()
        call.resolve([
            "status": status.name()
        ])
    }
}
