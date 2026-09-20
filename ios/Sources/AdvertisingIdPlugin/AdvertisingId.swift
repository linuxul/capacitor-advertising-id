import Foundation
import AdSupport
import AppTrackingTransparency

@objc public class AdvertisingId: NSObject {
    @objc public enum TrackingStatus: Int {
        // The case names are public API.
        // swiftlint:disable identifier_name
        case Authorized
        case Denied
        case NotDetermined
        case Restricted
        // swiftlint:enable identifier_name

        func name() -> String {
            switch self {
            case .Authorized: return "Authorized"
            case .Denied: return "Denied"
            case .NotDetermined: return "Not Determined"
            case .Restricted: return "Restricted"
            }
        }
    }

    @objc public func requestTracking(completion: (@escaping (TrackingStatus) -> Void)) {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized: completion(.Authorized)
            case .denied: completion(.Denied)
            case .notDetermined: completion(.NotDetermined)
            case .restricted: completion(.Restricted)
            @unknown default: completion(.NotDetermined)
            }
        }
    }

    @objc public func getAdvertisingId() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }

    @objc public func getAdvertisingStatus() -> TrackingStatus {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized: return .Authorized
        case .denied: return .Denied
        case .notDetermined: return .NotDetermined
        case .restricted: return .Restricted
        @unknown default: return .NotDetermined
        }
    }
}
