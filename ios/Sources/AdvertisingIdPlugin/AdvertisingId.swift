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

    /// Asks for tracking authorization, showing the system prompt if the user has not answered it yet, and returns
    /// the status once the user answers.
    public func requestTracking() async -> TrackingStatus {
        return AdvertisingId.trackingStatus(await ATTrackingManager.requestTrackingAuthorization())
    }

    @objc public func getAdvertisingId() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }

    @objc public func getAdvertisingStatus() -> TrackingStatus {
        return AdvertisingId.trackingStatus(ATTrackingManager.trackingAuthorizationStatus)
    }

    static func trackingStatus(_ status: ATTrackingManager.AuthorizationStatus) -> TrackingStatus {
        switch status {
        case .authorized: return .Authorized
        case .denied: return .Denied
        case .notDetermined: return .NotDetermined
        case .restricted: return .Restricted
        @unknown default: return .NotDetermined
        }
    }
}
