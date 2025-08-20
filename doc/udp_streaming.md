# UDP Streaming Support

Better Player Plus now supports UDP (User Datagram Protocol) streaming, allowing you to stream video content over UDP networks including multicast streams.

## Overview

UDP streaming is ideal for:
- **Live streaming** with low latency
- **Multicast streaming** to multiple receivers
- **Broadcast streaming** over local networks
- **Real-time video** applications
- **Network monitoring** and surveillance

## Features

- ✅ **UDP Protocol Support**: Native UDP streaming
- ✅ **Multicast Support**: Automatic multicast detection and handling
- ✅ **Transport Stream (TS)**: Built-in TS format support
- ✅ **Configurable Parameters**: Customizable packet size, timeouts, and buffers
- ✅ **Network Interface Selection**: Choose specific network interfaces
- ✅ **TTL Configuration**: Control multicast packet TTL
- ✅ **Broadcast Support**: Enable/disable broadcast streaming

## Basic Usage

### Simple UDP Stream

```dart
BetterPlayer.network(
  "udp://239.255.0.1:1234",
  betterPlayerConfiguration: BetterPlayerConfiguration(
    autoPlay: true,
    looping: false,
  ),
)
```

### UDP Stream with Configuration

```dart
BetterPlayer.udp(
  "udp://239.255.0.1:1234",
  liveStream: true,
  udpConfiguration: BetterPlayerUdpConfiguration(
    maxPacketSize: 65536,
    connectionTimeout: 10000,
    bufferSize: 1024 * 1024,
    enableMulticast: true,
    ttl: 1,
    enableBroadcast: false,
  ),
)
```

### Using BetterPlayerController

```dart
final controller = BetterPlayerController(
  BetterPlayerConfiguration(
    autoPlay: false,
    looping: false,
  ),
  betterPlayerDataSource: BetterPlayerDataSource.udp(
    "udp://239.255.0.1:1234",
    liveStream: true,
    udpConfiguration: BetterPlayerUdpConfiguration(
      enableMulticast: true,
      ttl: 1,
    ),
  ),
);

// Later, change the source
controller.setupDataSource(
  BetterPlayerDataSource.udp(
    "udp://192.168.1.100:5000",
    liveStream: true,
  ),
);
```

## Configuration Options

### BetterPlayerUdpConfiguration

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `maxPacketSize` | `int` | `65536` | Maximum UDP packet size in bytes |
| `connectionTimeout` | `int` | `10000` | Connection timeout in milliseconds |
| `bufferSize` | `int` | `1048576` | Buffer size in bytes (1MB) |
| `enableMulticast` | `bool` | `true` | Enable multicast support |
| `networkInterface` | `String?` | `null` | Specific network interface to use |
| `ttl` | `int` | `1` | Time To Live for multicast packets |
| `enableBroadcast` | `bool` | `false` | Enable broadcast support |

### Advanced Configuration Example

```dart
BetterPlayerUdpConfiguration(
  maxPacketSize: 131072,        // 128KB packets
  connectionTimeout: 15000,     // 15 second timeout
  bufferSize: 2 * 1024 * 1024, // 2MB buffer
  enableMulticast: true,        // Enable multicast
  networkInterface: "eth0",     // Use specific interface
  ttl: 5,                       // TTL of 5 hops
  enableBroadcast: false,       // Disable broadcast
)
```

## URL Formats

### Standard UDP
```
udp://host:port
udp://192.168.1.100:5000
udp://localhost:1234
```

### Multicast UDP
```
udp://239.255.0.1:1234
udp://224.0.0.1:5000
udp://233.1.2.3:8080
```

### IPv6 UDP
```
udp://[::1]:1234
udp://[fe80::1%eth0]:5000
```

## Multicast Support

Better Player Plus automatically detects multicast addresses (224.0.0.0 - 239.255.255.255) and:

1. **Acquires Multicast Lock**: Automatically manages WiFi multicast permissions
2. **Sets TTL**: Configures packet TTL for proper routing
3. **Interface Selection**: Can specify network interface for multicast
4. **Resource Management**: Properly releases multicast locks on disposal

### Multicast Example

```dart
BetterPlayer.udp(
  "udp://239.255.0.1:1234",
  udpConfiguration: BetterPlayerUdpConfiguration(
    enableMulticast: true,
    ttl: 3,                    // Allow 3 network hops
    networkInterface: "wlan0", // Use WiFi interface
  ),
)
```

## Transport Stream Support

UDP streams are automatically detected as Transport Stream (TS) format and use the appropriate extractor:

- **TS Extractor**: Handles MPEG-2 Transport Streams
- **Payload Reader**: Supports various TS payload types
- **Access Units**: Detects and handles video/audio access units
- **Non-IDR Keyframes**: Supports flexible keyframe handling

## Error Handling

The player automatically handles common UDP streaming issues:

- **Connection Timeouts**: Configurable timeout handling
- **Packet Loss**: Graceful handling of dropped packets
- **Network Changes**: Automatic reconnection on network changes
- **Multicast Issues**: Proper multicast lock management

### Error Event Handling

```dart
controller.addEventsListener((event) {
  if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
    print("UDP Stream Error: ${event.description}");
    // Handle error - maybe retry or show user message
  }
});
```

## Performance Considerations

### Buffer Sizing
- **Small Buffers**: Lower latency, higher packet loss risk
- **Large Buffers**: Higher latency, smoother playback
- **Recommended**: Start with 1MB buffer, adjust based on network

### Packet Size
- **Small Packets**: Better for unreliable networks
- **Large Packets**: Better for stable networks
- **Default**: 64KB is good for most use cases

### Network Interface Selection
- **WiFi**: Good for mobile devices
- **Ethernet**: Better for stable streaming
- **Auto**: Let system choose best interface

## Platform-Specific Notes

### Android
- **Media3 ExoPlayer**: Uses Media3 for UDP handling
- **Multicast Lock**: Automatic WiFi multicast permission management
- **Network Security**: Respects Android network security policies

### iOS
- **Native Support**: Uses iOS native UDP capabilities
- **Multicast**: Automatic multicast handling
- **Background**: Limited background UDP support

## Example Applications

### Live Streaming App
```dart
class LiveStreamPlayer extends StatefulWidget {
  @override
  _LiveStreamPlayerState createState() => _LiveStreamPlayerState();
}

class _LiveStreamPlayerState extends State<LiveStreamPlayer> {
  late BetterPlayerController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: true,
        aspectRatio: 16 / 9,
      ),
      betterPlayerDataSource: BetterPlayerDataSource.udp(
        "udp://239.255.0.1:1234",
        liveStream: true,
        udpConfiguration: BetterPlayerUdpConfiguration(
          enableMulticast: true,
          ttl: 5,
          bufferSize: 2 * 1024 * 1024,
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BetterPlayer(controller: _controller);
  }
}
```

### Network Monitor
```dart
BetterPlayer.udp(
  "udp://192.168.1.100:5000",
  udpConfiguration: BetterPlayerUdpConfiguration(
    connectionTimeout: 5000,    // Fast timeout for monitoring
    bufferSize: 512 * 1024,     // Smaller buffer for real-time
    enableMulticast: false,     // Direct connection
  ),
)
```

## Troubleshooting

### Common Issues

1. **Stream Not Playing**
   - Check UDP URL format
   - Verify network connectivity
   - Check firewall settings
   - Ensure multicast permissions (Android)

2. **High Latency**
   - Reduce buffer size
   - Check network quality
   - Verify TTL settings
   - Consider direct connection vs multicast

3. **Packet Loss**
   - Increase buffer size
   - Check network stability
   - Verify packet size settings
   - Consider network interface selection

### Debug Information

Enable debug logging to troubleshoot UDP issues:

```dart
BetterPlayerConfiguration(
  autoPlay: false,
  loggingEnabled: true,  // Enable debug logging
)
```

## Best Practices

1. **Start Simple**: Begin with default configuration
2. **Test Locally**: Verify with local UDP streams first
3. **Monitor Performance**: Watch for packet loss and latency
4. **Adjust Buffers**: Tune buffer sizes for your network
5. **Handle Errors**: Implement proper error handling
6. **Resource Management**: Always dispose controllers properly

## Migration from Other Players

If you're migrating from other UDP players:

1. **Replace URL**: Change to `udp://` format
2. **Update Configuration**: Use `BetterPlayerUdpConfiguration`
3. **Handle Events**: Use Better Player event system
4. **Test Thoroughly**: Verify with your UDP streams

## Future Enhancements

Planned improvements for UDP streaming:

- **Adaptive Buffering**: Dynamic buffer size adjustment
- **Network Quality Detection**: Automatic quality adaptation
- **Multiple Stream Support**: Handle multiple UDP sources
- **Advanced Error Recovery**: Better packet loss handling
- **Performance Metrics**: Detailed streaming statistics
