package uz.shs.better_player_plus

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class BetterPlayerAdsViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *> ?: emptyMap<Any, Any>()
        val textureId = (params["textureId"] as? Number)?.toLong() ?: -1L
        return BetterPlayerAdsView(context, textureId)
    }
}

