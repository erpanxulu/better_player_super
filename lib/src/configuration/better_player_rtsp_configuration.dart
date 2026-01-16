///Configuration for RTSP (Real Time Streaming Protocol) streaming
class BetterPlayerRtspConfiguration {
  ///RTSP connection timeout in milliseconds
  final int timeoutMs;

  ///Whether to force use RTP over TCP (interleaved mode)
  ///If false, RTSP will try UDP first and fallback to TCP if needed
  final bool forceUseRtpTcp;

  ///Username for RTSP authentication (optional)
  final String? username;

  ///Password for RTSP authentication (optional)
  final String? password;

  const BetterPlayerRtspConfiguration({
    this.timeoutMs = 10000, // 10 seconds default
    this.forceUseRtpTcp = false,
    this.username,
    this.password,
  });

  ///Create RTSP configuration from map
  factory BetterPlayerRtspConfiguration.fromMap(Map<String, dynamic> map) {
    return BetterPlayerRtspConfiguration(
      timeoutMs: map['timeoutMs'] ?? 10000,
      forceUseRtpTcp: map['forceUseRtpTcp'] ?? false,
      username: map['username'],
      password: map['password'],
    );
  }

  ///Convert configuration to map
  Map<String, dynamic> toMap() {
    return {
      'timeoutMs': timeoutMs,
      'forceUseRtpTcp': forceUseRtpTcp,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    };
  }

  ///Create a copy with modified values
  BetterPlayerRtspConfiguration copyWith({
    int? timeoutMs,
    bool? forceUseRtpTcp,
    String? username,
    String? password,
  }) {
    return BetterPlayerRtspConfiguration(
      timeoutMs: timeoutMs ?? this.timeoutMs,
      forceUseRtpTcp: forceUseRtpTcp ?? this.forceUseRtpTcp,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BetterPlayerRtspConfiguration &&
        other.timeoutMs == timeoutMs &&
        other.forceUseRtpTcp == forceUseRtpTcp &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return Object.hash(
      timeoutMs,
      forceUseRtpTcp,
      username,
      password,
    );
  }

  @override
  String toString() {
    return 'BetterPlayerRtspConfiguration('
        'timeoutMs: $timeoutMs, '
        'forceUseRtpTcp: $forceUseRtpTcp, '
        'username: $username, '
        'password: ${password != null ? "***" : null})';
  }
}
