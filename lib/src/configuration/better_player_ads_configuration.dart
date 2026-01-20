enum BetterPlayerAdsStreamType {
  clientSide,
  daiVod,
  daiLive,
}

class BetterPlayerAdsConfiguration {
  /// Enable/disable ads for the data source.
  final bool enabled;

  /// Enable extra debug logs for ads.
  final bool debugMode;

  /// If true, stop content playback when ad playback fails.
  final bool strictMode;

  /// VAST ad tag URL for Google IMA client-side ads.
  final String? adTagUrl;

  /// Stream type for IMA DAI (iOS only).
  final BetterPlayerAdsStreamType streamType;

  /// DAI VOD content source ID (iOS only).
  final String? contentSourceId;

  /// DAI VOD video ID (iOS only).
  final String? videoId;

  /// DAI Live asset key (iOS only).
  final String? assetKey;

  const BetterPlayerAdsConfiguration({
    this.enabled = true,
    this.debugMode = false,
    this.strictMode = false,
    this.adTagUrl,
    this.streamType = BetterPlayerAdsStreamType.clientSide,
    this.contentSourceId,
    this.videoId,
    this.assetKey,
  }) : assert(
          !enabled ||
              streamType != BetterPlayerAdsStreamType.clientSide ||
              adTagUrl != null,
          "adTagUrl is required for client-side ads",
        );
}

