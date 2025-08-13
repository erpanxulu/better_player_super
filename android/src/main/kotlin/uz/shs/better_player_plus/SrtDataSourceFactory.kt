package uz.shs.better_player_plus

import androidx.media3.common.util.UnstableApi
import androidx.media3.datasource.DataSource

@UnstableApi
class SrtDataSourceFactory(
    private val srtConfiguration: Map<String, Any?>? = null
) : DataSource.Factory {
    override fun createDataSource(): DataSource {
        return SrtDataSource(srtConfiguration)
    }
}
