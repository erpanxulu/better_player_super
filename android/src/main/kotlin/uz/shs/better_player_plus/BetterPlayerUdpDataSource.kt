package uz.shs.better_player_plus

import android.net.Uri
import android.net.wifi.WifiManager
import android.content.Context
import androidx.media3.common.MediaItem
import androidx.media3.common.util.UnstableApi
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.UdpDataSource
import androidx.media3.exoplayer.source.MediaSource
import androidx.media3.exoplayer.source.ProgressiveMediaSource
import androidx.media3.extractor.DefaultExtractorsFactory
import androidx.media3.extractor.ts.DefaultTsPayloadReaderFactory
import androidx.media3.extractor.ts.TsExtractor
import androidx.media3.common.Player
import androidx.media3.common.PlaybackException
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.*

/**
 * UDP Data Source implementation for Better Player Plus
 * Handles UDP streaming with multicast support and TS (Transport Stream) extraction
 */
@UnstableApi
class BetterPlayerUdpDataSource(
    private val context: Context,
    private val maxPacketSize: Int = UdpDataSource.DEFAULT_MAX_PACKET_SIZE,
    private val connectionTimeout: Int = 10000,
    private val bufferSize: Int = 1024 * 1024,
    private val enableMulticast: Boolean = true,
    private val networkInterface: String? = null,
    private val ttl: Int = 1,
    private val enableBroadcast: Boolean = false
) {
    private var multicastLock: WifiManager.MulticastLock? = null
    private var player: Player? = null

    /**
     * Build UDP Media Source for the given URL
     */
    fun buildUdpMediaSource(url: String): MediaSource {
        val udpFactory = DataSource.Factory {
            UdpDataSource(
                2000,
                10_000
            )
        }
        
        val tsExtractor = DefaultExtractorsFactory()
            .setTsExtractorFlags(
                DefaultTsPayloadReaderFactory.FLAG_ALLOW_NON_IDR_KEYFRAMES
                        or DefaultTsPayloadReaderFactory.FLAG_DETECT_ACCESS_UNITS
            )
            .setTsExtractorMode(TsExtractor.MODE_SINGLE_PMT)

        val mediaItem = MediaItem.fromUri(Uri.parse(url))

        return ProgressiveMediaSource.Factory(udpFactory, tsExtractor)
            .createMediaSource(mediaItem)
    }

    /**
     * Check if the given URL is a multicast address
     */
    fun isMulticastUrl(url: String): Boolean {
        return try {
            val uri = Uri.parse(url)
            val host = uri.host
            val firstOctet = host?.split(".")?.firstOrNull()?.toInt() ?: -1
            firstOctet in 224..239
        } catch (e: Exception) {
            false
        }
    }

    /**
     * Acquire multicast lock for WiFi multicast support
     */
    fun acquireMulticastLock() {
        if (enableMulticast) {
            val wifi = context.getSystemService(Context.WIFI_SERVICE) as WifiManager
            multicastLock = wifi.createMulticastLock("better-player-udp-multicast-lock").apply {
                setReferenceCounted(true)
                acquire()
            }
        }
    }

    /**
     * Release multicast lock
     */
    fun releaseMulticastLock() {
        multicastLock?.let { 
            if (it.isHeld) it.release() 
        }
        multicastLock = null
    }

    /**
     * Get available network interfaces for multicast
     */
    fun getAvailableNetworkInterfaces(): List<String> {
        val interfaces = mutableListOf<String>()
        try {
            val networkInterfaces = NetworkInterface.getNetworkInterfaces()
            while (networkInterfaces.hasMoreElements()) {
                val networkInterface = networkInterfaces.nextElement()
                if (networkInterface.isUp && !networkInterface.isLoopback) {
                    interfaces.add(networkInterface.displayName)
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return interfaces
    }

    /**
     * Set player instance for event handling
     */
    fun setPlayer(player: Player) {
        this.player = player
    }

    /**
     * Add error listener to player
     */
    fun addErrorListener(errorListener: Player.Listener) {
        player?.addListener(errorListener)
    }

    /**
     * Cleanup resources
     */
    fun dispose() {
        releaseMulticastLock()
        player = null
    }
}
