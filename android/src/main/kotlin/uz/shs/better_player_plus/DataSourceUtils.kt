package uz.shs.better_player_plus

import android.net.Uri
import androidx.media3.datasource.DataSource
import androidx.media3.datasource.DefaultHttpDataSource

internal object DataSourceUtils {
    private const val USER_AGENT = "User-Agent"
    private const val USER_AGENT_PROPERTY = "http.agent"

    @JvmStatic
    fun getUserAgent(headers: Map<String, String>?): String? {
        var userAgent = System.getProperty(USER_AGENT_PROPERTY)
        if (headers != null && headers.containsKey(USER_AGENT)) {
            val userAgentHeader = headers[USER_AGENT]
            if (userAgentHeader != null) {
                userAgent = userAgentHeader
            }
        }
        return userAgent
    }

    @JvmStatic
    fun getDataSourceFactory(
        userAgent: String?,
        headers: Map<String, String>?
    ): DataSource.Factory {
        val dataSourceFactory: DataSource.Factory = DefaultHttpDataSource.Factory()
            .setUserAgent(userAgent)
            .setAllowCrossProtocolRedirects(true)
            .setConnectTimeoutMs(DefaultHttpDataSource.DEFAULT_CONNECT_TIMEOUT_MILLIS)
            .setReadTimeoutMs(DefaultHttpDataSource.DEFAULT_READ_TIMEOUT_MILLIS)
        if (headers != null) {
            val notNullHeaders = mutableMapOf<String, String>()
            headers.forEach { entry ->
                notNullHeaders[entry.key] = entry.value
            }
            (dataSourceFactory as DefaultHttpDataSource.Factory).setDefaultRequestProperties(
                notNullHeaders
            )
        }
        return dataSourceFactory
    }

    @JvmStatic
    fun getDataSourceFactoryWithHlsDefaults(
        userAgent: String?,
        headers: Map<String, String>?,
        uri: Uri?
    ): DataSource.Factory {
        val dataSourceFactory: DataSource.Factory = DefaultHttpDataSource.Factory()
            .setUserAgent(userAgent ?: "Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36")
            .setAllowCrossProtocolRedirects(true)
            .setConnectTimeoutMs(DefaultHttpDataSource.DEFAULT_CONNECT_TIMEOUT_MILLIS)
            .setReadTimeoutMs(DefaultHttpDataSource.DEFAULT_READ_TIMEOUT_MILLIS)
        
        val notNullHeaders = mutableMapOf<String, String>()
        
        // Add default HLS headers
        notNullHeaders["Accept"] = "application/vnd.apple.mpegurl, application/x-mpegURL, application/octet-stream, */*"
        notNullHeaders["Accept-Encoding"] = "identity"
        notNullHeaders["Connection"] = "keep-alive"
        
        // Add referer if it's a streaming URL
        if (uri != null && (uri.scheme == "https" || uri.scheme == "http")) {
            val host = uri.host
            if (host != null) {
                notNullHeaders["Referer"] = "${uri.scheme}://$host/"
            }
        }
        
        // Add custom headers if provided
        if (headers != null) {
            headers.forEach { entry ->
                notNullHeaders[entry.key] = entry.value
            }
        }
        
        (dataSourceFactory as DefaultHttpDataSource.Factory).setDefaultRequestProperties(notNullHeaders)
        return dataSourceFactory
    }

    @JvmStatic
    fun isHTTP(uri: Uri?): Boolean {
        if (uri == null || uri.scheme == null) {
            return false
        }
        val scheme = uri.scheme
        return scheme == "http" || scheme == "https"
    }
}