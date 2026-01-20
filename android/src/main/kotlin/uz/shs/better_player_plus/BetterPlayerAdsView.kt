package uz.shs.better_player_plus

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import io.flutter.plugin.platform.PlatformView

class BetterPlayerAdsView(
    context: Context,
    private val textureId: Long
) : PlatformView {
    private val container: FrameLayout = FrameLayout(context)

    init {
        AdsOverlayRegistry.setAdViewGroup(textureId, container)
    }

    override fun getView(): View {
        return container
    }

    override fun dispose() {
        AdsOverlayRegistry.removeAdViewGroup(textureId)
    }
}

