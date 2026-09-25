import XCTest
import AppTrackingTransparency
@testable import AdvertisingIdPlugin

class AdvertisingIdTests: XCTestCase {
    func testTrackingStatusNames() {
        XCTAssertEqual(AdvertisingId.TrackingStatus.Authorized.name(), "Authorized")
        XCTAssertEqual(AdvertisingId.TrackingStatus.Denied.name(), "Denied")
        XCTAssertEqual(AdvertisingId.TrackingStatus.NotDetermined.name(), "Not Determined")
        XCTAssertEqual(AdvertisingId.TrackingStatus.Restricted.name(), "Restricted")
    }

    func testAuthorizationStatusesMapToTrackingStatuses() {
        XCTAssertEqual(AdvertisingId.trackingStatus(.authorized), .Authorized)
        XCTAssertEqual(AdvertisingId.trackingStatus(.denied), .Denied)
        XCTAssertEqual(AdvertisingId.trackingStatus(.notDetermined), .NotDetermined)
        XCTAssertEqual(AdvertisingId.trackingStatus(.restricted), .Restricted)
    }

    func testPluginRegistration() {
        let plugin = AdvertisingIdPlugin()

        XCTAssertEqual(plugin.identifier, "AdvertisingIdPlugin")
        XCTAssertEqual(plugin.jsName, "AdvertisingId")
        XCTAssertEqual(plugin.pluginMethods.map(\.name), ["requestTracking", "getAdvertisingId", "getAdvertisingStatus"])
        XCTAssertTrue(plugin.pluginMethods.allSatisfy { $0.returnType == .promise })
    }
}
