package uz.shs.better_player_plus

import android.view.ViewGroup
import java.lang.ref.WeakReference
import java.util.concurrent.ConcurrentHashMap

object AdsOverlayRegistry {
    private val registry = ConcurrentHashMap<Long, WeakReference<ViewGroup>>()

    fun setAdViewGroup(textureId: Long, viewGroup: ViewGroup) {
        registry[textureId] = WeakReference(viewGroup)
    }

    fun getAdViewGroup(textureId: Long): ViewGroup? {
        return registry[textureId]?.get()
    }

    fun removeAdViewGroup(textureId: Long) {
        registry.remove(textureId)
    }
}

