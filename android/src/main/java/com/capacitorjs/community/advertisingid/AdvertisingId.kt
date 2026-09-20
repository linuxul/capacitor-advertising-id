package com.capacitorjs.community.advertisingid

import android.content.Context
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import com.google.android.gms.common.GooglePlayServicesNotAvailableException
import com.google.android.gms.common.GooglePlayServicesRepairableException
import java.io.IOException

public class AdvertisingId {
    public enum class TrackingStatus(private val value: String) {
        Authorized("Authorized"),
        Denied("Denied"),
        NotDetermined("Not Determined"),
        Restricted("Restricted");

        override fun toString(): String = value
    }

    public fun getTrackingId(context: Context): String? = try {
        val info = AdvertisingIdClient.getAdvertisingIdInfo(context)
        if (info.isLimitAdTrackingEnabled) "" else info.id
    } catch (e: GooglePlayServicesNotAvailableException) {
        ""
    } catch (e: GooglePlayServicesRepairableException) {
        ""
    } catch (e: IOException) {
        ""
    }

    public fun getTrackingStatus(context: Context): String = try {
        val info = AdvertisingIdClient.getAdvertisingIdInfo(context)
        if (info.isLimitAdTrackingEnabled) TrackingStatus.Denied.toString() else TrackingStatus.Authorized.toString()
    } catch (e: GooglePlayServicesNotAvailableException) {
        TrackingStatus.Restricted.toString()
    } catch (e: GooglePlayServicesRepairableException) {
        TrackingStatus.Restricted.toString()
    } catch (e: IOException) {
        TrackingStatus.NotDetermined.toString()
    }
}
