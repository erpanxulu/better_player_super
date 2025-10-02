///Configuration for SRT (Secure Reliable Transport) streaming
class BetterPlayerSrtConfiguration {
  ///SRT connection timeout in milliseconds
  final int connectionTimeoutMs;

  ///SRT peer latency tolerance in milliseconds
  final int peerLatencyToleranceMs;

  ///SRT peer idle timeout in milliseconds
  final int peerIdleTimeoutMs;

  ///SRT input buffer size in bytes
  final int inputBufferSize;

  ///SRT output buffer size in bytes
  final int outputBufferSize;

  ///SRT maximum bandwidth in bytes per second
  final int maxBandwidth;

  ///SRT overhead percentage (0-100)
  final int overheadPercentage;

  ///SRT mss (Maximum Segment Size)
  final int mss;

  ///SRT ffs (Flight Flag Size)
  final int ffs;

  ///SRT ipttl (IP Time To Live)
  final int ipttl;

  ///SRT iptos (IP Type of Service)
  final int iptos;

  ///SRT handshake timeout in milliseconds
  final int handshakeTimeoutMs;

  ///SRT peer connection timeout in milliseconds
  final int peerConnectionTimeoutMs;

  ///SRT peer keep alive interval in milliseconds
  final int peerKeepAliveIntervalMs;

  ///SRT peer keep alive timeout in milliseconds
  final int peerKeepAliveTimeoutMs;

  ///SRT peer max reorder tolerance in milliseconds
  final int peerMaxReorderToleranceMs;

  ///SRT peer max reorder tolerance in packets
  final int peerMaxReorderTolerancePackets;

  ///SRT peer max reorder tolerance in bytes
  final int peerMaxReorderToleranceBytes;

  ///SRT peer max reorder tolerance in time
  final int peerMaxReorderToleranceTime;

  ///SRT peer max reorder tolerance in packets
  final int peerMaxReorderTolerancePackets2;

  ///SRT peer max reorder tolerance in bytes
  final int peerMaxReorderToleranceBytes2;

  ///SRT peer max reorder tolerance in time
  final int peerMaxReorderToleranceTime2;

  ///SRT peer max reorder tolerance in packets
  final int peerMaxReorderTolerancePackets3;

  ///SRT peer max reorder tolerance in bytes
  final int peerMaxReorderToleranceBytes3;

  ///SRT peer max reorder tolerance in time
  final int peerMaxReorderToleranceTime3;

  ///SRT peer max reorder tolerance in packets
  final int peerMaxReorderTolerancePackets4;

  ///SRT peer max reorder tolerance in bytes
  final int peerMaxReorderToleranceBytes4;

  ///SRT peer max reorder tolerance in time
  final int peerMaxReorderToleranceTime4;

  ///SRT peer max reorder tolerance in packets
  final int peerMaxReorderTolerancePackets5;

  ///SRT peer max reorder tolerance in bytes
  final int peerMaxReorderToleranceBytes5;

  ///SRT peer max reorder tolerance in time
  final int peerMaxReorderToleranceTime5;

  const BetterPlayerSrtConfiguration({
    this.connectionTimeoutMs = 3000,
    this.peerLatencyToleranceMs = 120,
    this.peerIdleTimeoutMs = 5000,
    this.inputBufferSize = 8192,
    this.outputBufferSize = 8192,
    this.maxBandwidth = 0,
    this.overheadPercentage = 25,
    this.mss = 1500,
    this.ffs = 25600,
    this.ipttl = 64,
    this.iptos = 0xB8,
    this.handshakeTimeoutMs = 5000,
    this.peerConnectionTimeoutMs = 5000,
    this.peerKeepAliveIntervalMs = 1000,
    this.peerKeepAliveTimeoutMs = 5000,
    this.peerMaxReorderToleranceMs = 0,
    this.peerMaxReorderTolerancePackets = 0,
    this.peerMaxReorderToleranceBytes = 0,
    this.peerMaxReorderToleranceTime = 0,
    this.peerMaxReorderTolerancePackets2 = 0,
    this.peerMaxReorderToleranceBytes2 = 0,
    this.peerMaxReorderToleranceTime2 = 0,
    this.peerMaxReorderTolerancePackets3 = 0,
    this.peerMaxReorderToleranceBytes3 = 0,
    this.peerMaxReorderToleranceTime3 = 0,
    this.peerMaxReorderTolerancePackets4 = 0,
    this.peerMaxReorderToleranceBytes4 = 0,
    this.peerMaxReorderToleranceTime4 = 0,
    this.peerMaxReorderTolerancePackets5 = 0,
    this.peerMaxReorderToleranceBytes5 = 0,
    this.peerMaxReorderToleranceTime5 = 0,
  });

  ///Convert configuration to map for platform communication
  Map<String, dynamic> toMap() {
    return {
      'connectionTimeoutMs': connectionTimeoutMs,
      'peerLatencyToleranceMs': peerLatencyToleranceMs,
      'peerIdleTimeoutMs': peerIdleTimeoutMs,
      'inputBufferSize': inputBufferSize,
      'outputBufferSize': outputBufferSize,
      'maxBandwidth': maxBandwidth,
      'overheadPercentage': overheadPercentage,
      'mss': mss,
      'ffs': ffs,
      'ipttl': ipttl,
      'iptos': iptos,
      'handshakeTimeoutMs': handshakeTimeoutMs,
      'peerConnectionTimeoutMs': peerConnectionTimeoutMs,
      'peerKeepAliveIntervalMs': peerKeepAliveIntervalMs,
      'peerKeepAliveTimeoutMs': peerKeepAliveTimeoutMs,
      'peerMaxReorderToleranceMs': peerMaxReorderToleranceMs,
      'peerMaxReorderTolerancePackets': peerMaxReorderTolerancePackets,
      'peerMaxReorderToleranceBytes': peerMaxReorderToleranceBytes,
      'peerMaxReorderToleranceTime': peerMaxReorderToleranceTime,
      'peerMaxReorderTolerancePackets2': peerMaxReorderTolerancePackets2,
      'peerMaxReorderToleranceBytes2': peerMaxReorderToleranceBytes2,
      'peerMaxReorderToleranceTime2': peerMaxReorderToleranceTime2,
      'peerMaxReorderTolerancePackets3': peerMaxReorderTolerancePackets3,
      'peerMaxReorderToleranceBytes3': peerMaxReorderToleranceBytes3,
      'peerMaxReorderToleranceTime3': peerMaxReorderToleranceTime3,
      'peerMaxReorderTolerancePackets4': peerMaxReorderTolerancePackets4,
      'peerMaxReorderToleranceBytes4': peerMaxReorderToleranceBytes4,
      'peerMaxReorderToleranceTime4': peerMaxReorderToleranceTime4,
      'peerMaxReorderTolerancePackets5': peerMaxReorderTolerancePackets5,
      'peerMaxReorderToleranceBytes5': peerMaxReorderToleranceBytes5,
      'peerMaxReorderToleranceTime5': peerMaxReorderToleranceTime5,
    };
  }

  ///Create configuration from map
  factory BetterPlayerSrtConfiguration.fromMap(Map<String, dynamic> map) {
    return BetterPlayerSrtConfiguration(
      connectionTimeoutMs: map['connectionTimeoutMs'] ?? 3000,
      peerLatencyToleranceMs: map['peerLatencyToleranceMs'] ?? 120,
      peerIdleTimeoutMs: map['peerIdleTimeoutMs'] ?? 5000,
      inputBufferSize: map['inputBufferSize'] ?? 8192,
      outputBufferSize: map['outputBufferSize'] ?? 8192,
      maxBandwidth: map['maxBandwidth'] ?? 0,
      overheadPercentage: map['overheadPercentage'] ?? 25,
      mss: map['mss'] ?? 1500,
      ffs: map['ffs'] ?? 25600,
      ipttl: map['ipttl'] ?? 64,
      iptos: map['iptos'] ?? 0xB8,
      handshakeTimeoutMs: map['handshakeTimeoutMs'] ?? 5000,
      peerConnectionTimeoutMs: map['peerConnectionTimeoutMs'] ?? 5000,
      peerKeepAliveIntervalMs: map['peerKeepAliveIntervalMs'] ?? 1000,
      peerKeepAliveTimeoutMs: map['peerKeepAliveTimeoutMs'] ?? 5000,
      peerMaxReorderToleranceMs: map['peerMaxReorderToleranceMs'] ?? 0,
      peerMaxReorderTolerancePackets: map['peerMaxReorderTolerancePackets'] ?? 0,
      peerMaxReorderToleranceBytes: map['peerMaxReorderToleranceBytes'] ?? 0,
      peerMaxReorderToleranceTime: map['peerMaxReorderToleranceTime'] ?? 0,
      peerMaxReorderTolerancePackets2: map['peerMaxReorderTolerancePackets2'] ?? 0,
      peerMaxReorderToleranceBytes2: map['peerMaxReorderToleranceBytes2'] ?? 0,
      peerMaxReorderToleranceTime2: map['peerMaxReorderToleranceTime2'] ?? 0,
      peerMaxReorderTolerancePackets3: map['peerMaxReorderTolerancePackets3'] ?? 0,
      peerMaxReorderToleranceBytes3: map['peerMaxReorderToleranceBytes3'] ?? 0,
      peerMaxReorderToleranceTime3: map['peerMaxReorderToleranceTime3'] ?? 0,
      peerMaxReorderTolerancePackets4: map['peerMaxReorderTolerancePackets4'] ?? 0,
      peerMaxReorderToleranceBytes4: map['peerMaxReorderToleranceBytes4'] ?? 0,
      peerMaxReorderToleranceTime4: map['peerMaxReorderToleranceTime4'] ?? 0,
      peerMaxReorderTolerancePackets5: map['peerMaxReorderTolerancePackets5'] ?? 0,
      peerMaxReorderToleranceBytes5: map['peerMaxReorderToleranceBytes5'] ?? 0,
      peerMaxReorderToleranceTime5: map['peerMaxReorderToleranceTime5'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'BetterPlayerSrtConfiguration('
        'connectionTimeoutMs: $connectionTimeoutMs, '
        'peerLatencyToleranceMs: $peerLatencyToleranceMs, '
        'peerIdleTimeoutMs: $peerIdleTimeoutMs, '
        'inputBufferSize: $inputBufferSize, '
        'outputBufferSize: $outputBufferSize, '
        'maxBandwidth: $maxBandwidth, '
        'overheadPercentage: $overheadPercentage, '
        'mss: $mss, '
        'ffs: $ffs, '
        'ipttl: $ipttl, '
        'iptos: $iptos, '
        'handshakeTimeoutMs: $handshakeTimeoutMs, '
        'peerConnectionTimeoutMs: $peerConnectionTimeoutMs, '
        'peerKeepAliveIntervalMs: $peerKeepAliveIntervalMs, '
        'peerKeepAliveTimeoutMs: $peerKeepAliveTimeoutMs, '
        'peerMaxReorderToleranceMs: $peerMaxReorderToleranceMs, '
        'peerMaxReorderTolerancePackets: $peerMaxReorderTolerancePackets, '
        'peerMaxReorderToleranceBytes: $peerMaxReorderToleranceBytes, '
        'peerMaxReorderToleranceTime: $peerMaxReorderToleranceTime, '
        'peerMaxReorderTolerancePackets2: $peerMaxReorderTolerancePackets2, '
        'peerMaxReorderToleranceBytes2: $peerMaxReorderToleranceBytes2, '
        'peerMaxReorderToleranceTime2: $peerMaxReorderToleranceTime2, '
        'peerMaxReorderTolerancePackets3: $peerMaxReorderTolerancePackets3, '
        'peerMaxReorderToleranceBytes3: $peerMaxReorderToleranceBytes3, '
        'peerMaxReorderToleranceTime3: $peerMaxReorderToleranceTime3, '
        'peerMaxReorderTolerancePackets4: $peerMaxReorderTolerancePackets4, '
        'peerMaxReorderToleranceBytes4: $peerMaxReorderToleranceBytes4, '
        'peerMaxReorderToleranceTime4: $peerMaxReorderToleranceTime4, '
        'peerMaxReorderTolerancePackets5: $peerMaxReorderTolerancePackets5, '
        'peerMaxReorderToleranceBytes5: $peerMaxReorderToleranceBytes5, '
        'peerMaxReorderToleranceTime5: $peerMaxReorderToleranceTime5)';
  }
}
