import XCTest
@testable import AdvertisingIdPlugin

class AdvertisingIdTests: XCTestCase {
    func testTrackingStatusNames() {
        XCTAssertEqual(AdvertisingId.TrackingStatus.Authorized.name(), "Authorized")
        XCTAssertEqual(AdvertisingId.TrackingStatus.Denied.name(), "Denied")
        XCTAssertEqual(AdvertisingId.TrackingStatus.NotDetermined.name(), "Not Determined")
        XCTAssertEqual(AdvertisingId.TrackingStatus.Restricted.name(), "Restricted")
    }

    func testPluginRegistration() {
        let plugin = AdvertisingIdPlugin()

        XCTAssertEqual(plugin.identifier, "AdvertisingIdPlugin")
        XCTAssertEqual(plugin.jsName, "AdvertisingId")
        XCTAssertEqual(plugin.pluginMethods.map(\.name), ["requestTracking", "getAdvertisingId", "getAdvertisingStatus"])
        XCTAssertTrue(plugin.pluginMethods.allSatisfy { $0.returnType == .promise })
    }
}
