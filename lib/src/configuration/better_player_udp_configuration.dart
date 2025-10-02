///Configuration for UDP streaming in Better Player
class BetterPlayerUdpConfiguration {
  ///Maximum packet size for UDP streaming
  final int maxPacketSize;

  ///Connection timeout in milliseconds
  final int connectionTimeout;

  ///Buffer size for UDP packets
  final int bufferSize;

  ///Whether to enable multicast support
  final bool enableMulticast;

  ///Network interface to use for multicast (optional)
  final String? networkInterface;

  ///TTL (Time To Live) for multicast packets
  final int ttl;

  ///Whether to enable broadcast support
  final bool enableBroadcast;

  const BetterPlayerUdpConfiguration({
    this.maxPacketSize = 65536, // Default UDP max packet size
    this.connectionTimeout = 10000, // 10 seconds
    this.bufferSize = 1024 * 1024, // 1MB buffer
    this.enableMulticast = true,
    this.networkInterface,
    this.ttl = 1,
    this.enableBroadcast = false,
  });

  ///Create UDP configuration from map
  factory BetterPlayerUdpConfiguration.fromMap(Map<String, dynamic> map) {
    return BetterPlayerUdpConfiguration(
      maxPacketSize: map['maxPacketSize'] ?? 65536,
      connectionTimeout: map['connectionTimeout'] ?? 10000,
      bufferSize: map['bufferSize'] ?? 1024 * 1024,
      enableMulticast: map['enableMulticast'] ?? true,
      networkInterface: map['networkInterface'],
      ttl: map['ttl'] ?? 1,
      enableBroadcast: map['enableBroadcast'] ?? false,
    );
  }

  ///Convert configuration to map
  Map<String, dynamic> toMap() {
    return {
      'maxPacketSize': maxPacketSize,
      'connectionTimeout': connectionTimeout,
      'bufferSize': bufferSize,
      'enableMulticast': enableMulticast,
      'networkInterface': networkInterface,
      'ttl': ttl,
      'enableBroadcast': enableBroadcast,
    };
  }

  ///Create a copy with modified values
  BetterPlayerUdpConfiguration copyWith({
    int? maxPacketSize,
    int? connectionTimeout,
    int? bufferSize,
    bool? enableMulticast,
    String? networkInterface,
    int? ttl,
    bool? enableBroadcast,
  }) {
    return BetterPlayerUdpConfiguration(
      maxPacketSize: maxPacketSize ?? this.maxPacketSize,
      connectionTimeout: connectionTimeout ?? this.connectionTimeout,
      bufferSize: bufferSize ?? this.bufferSize,
      enableMulticast: enableMulticast ?? this.enableMulticast,
      networkInterface: networkInterface ?? this.networkInterface,
      ttl: ttl ?? this.ttl,
      enableBroadcast: enableBroadcast ?? this.enableBroadcast,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BetterPlayerUdpConfiguration &&
        other.maxPacketSize == maxPacketSize &&
        other.connectionTimeout == connectionTimeout &&
        other.bufferSize == bufferSize &&
        other.enableMulticast == enableMulticast &&
        other.networkInterface == networkInterface &&
        other.ttl == ttl &&
        other.enableBroadcast == enableBroadcast;
  }

  @override
  int get hashCode {
    return Object.hash(
      maxPacketSize,
      connectionTimeout,
      bufferSize,
      enableMulticast,
      networkInterface,
      ttl,
      enableBroadcast,
    );
  }

  @override
  String toString() {
    return 'BetterPlayerUdpConfiguration('
        'maxPacketSize: $maxPacketSize, '
        'connectionTimeout: $connectionTimeout, '
        'bufferSize: $bufferSize, '
        'enableMulticast: $enableMulticast, '
        'networkInterface: $networkInterface, '
        'ttl: $ttl, '
        'enableBroadcast: $enableBroadcast)';
  }
}
