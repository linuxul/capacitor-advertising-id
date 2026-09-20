package com.capacitorjs.community.advertisingid

import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "AdvertisingId")
public class AdvertisingIdPlugin : Plugin() {
    private val implementation = AdvertisingId()

    @PluginMethod
    public fun requestTracking(call: PluginCall) {
        val status = implementation.getTrackingStatus(context)

        val output = JSObject()
        output.put("value", status)
        call.resolve(output)
    }

    @PluginMethod
    public fun getAdvertisingId(call: PluginCall) {
        val id = implementation.getTrackingId(context)
        val status = implementation.getTrackingStatus(context)

        val output = JSObject()
        output.put("id", id)
        output.put("status", status)
        call.resolve(output)
    }

    @PluginMethod
    public fun getAdvertisingStatus(call: PluginCall) {
        val status = implementation.getTrackingStatus(context)

        val output = JSObject()
        output.put("status", status)
        call.resolve(output)
    }
}
