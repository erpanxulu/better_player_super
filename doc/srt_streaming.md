# SRT Streaming Support

Better Player Plus now supports SRT (Secure Reliable Transport) streaming, a protocol designed for low-latency video streaming with secure transmission and reliable delivery.

## What is SRT?

SRT (Secure Reliable Transport) is an open-source video transport protocol that enables the delivery of high-quality, low-latency video streams across unpredictable networks. It's particularly useful for:

- Live streaming
- Video conferencing
- Remote production
- Broadcasting
- Any application requiring low latency and reliable delivery

## Key Features of SRT

- **Low Latency**: Typically 100-200ms end-to-end latency
- **Secure**: Built-in encryption for secure transmission
- **Reliable**: Automatic retransmission of lost packets
- **Adaptive**: Adjusts to network conditions
- **Cross-platform**: Works on Windows, macOS, Linux, Android, and iOS

## Usage

### Basic SRT Streaming

```dart
import 'package:better_player_plus/better_player_plus.dart';

// Create SRT data source
final dataSource = BetterPlayerDataSource(
  BetterPlayerDataSourceType.srt,
  "srt://your-srt-server:9000",
  srtConfiguration: BetterPlayerSrtConfiguration(
    connectionTimeoutMs: 5000,
    peerLatencyToleranceMs: 120,
    peerIdleTimeoutMs: 5000,
  ),
);

// Create player controller
final controller = BetterPlayerController(
  BetterPlayerConfiguration(
    autoPlay: true,
    aspectRatio: 16 / 9,
  ),
  betterPlayerDataSource: dataSource,
);

// Use in widget
BetterPlayer(controller: controller)
```

### Advanced SRT Configuration

```dart
final srtConfig = BetterPlayerSrtConfiguration(
  // Connection settings
  connectionTimeoutMs: 5000,
  handshakeTimeoutMs: 5000,
  
  // Peer settings
  peerLatencyToleranceMs: 120,
  peerIdleTimeoutMs: 5000,
  peerConnectionTimeoutMs: 5000,
  peerKeepAliveIntervalMs: 1000,
  peerKeepAliveTimeoutMs: 5000,
  
  // Buffer settings
  inputBufferSize: 16384,
  outputBufferSize: 16384,
  
  // Network settings
  maxBandwidth: 0, // 0 = unlimited
  overheadPercentage: 25,
  mss: 1500,
  ffs: 25600,
  ipttl: 64,
  iptos: 0xB8,
  
  // Reorder tolerance settings
  peerMaxReorderToleranceMs: 0,
  peerMaxReorderTolerancePackets: 0,
  peerMaxReorderToleranceBytes: 0,
  peerMaxReorderToleranceTime: 0,
);

final dataSource = BetterPlayerDataSource(
  BetterPlayerDataSourceType.srt,
  "srt://your-srt-server:9000",
  srtConfiguration: srtConfig,
);
```

### SRT URL Formats

SRT URLs follow this format:
```
srt://host:port
srt://host:port?mode=caller
srt://host:port?mode=listener
```

Common SRT ports:
- **9000**: Default SRT port
- **9001**: Alternative SRT port
- **Custom**: Any port you configure

## Configuration Parameters

### Connection Settings

| Parameter | Default | Description |
|-----------|---------|-------------|
| `connectionTimeoutMs` | 3000 | Connection timeout in milliseconds |
| `handshakeTimeoutMs` | 5000 | Handshake timeout in milliseconds |

### Peer Settings

| Parameter | Default | Description |
|-----------|---------|-------------|
| `peerLatencyToleranceMs` | 120 | Peer latency tolerance in milliseconds |
| `peerIdleTimeoutMs` | 5000 | Peer idle timeout in milliseconds |
| `peerConnectionTimeoutMs` | 5000 | Peer connection timeout in milliseconds |
| `peerKeepAliveIntervalMs` | 1000 | Peer keep-alive interval in milliseconds |
| `peerKeepAliveTimeoutMs` | 5000 | Peer keep-alive timeout in milliseconds |

### Buffer Settings

| Parameter | Default | Description |
|-----------|---------|-------------|
| `inputBufferSize` | 8192 | Input buffer size in bytes |
| `outputBufferSize` | 8192 | Output buffer size in bytes |

### Network Settings

| Parameter | Default | Description |
|-----------|---------|-------------|
| `maxBandwidth` | 0 | Maximum bandwidth in bytes per second (0 = unlimited) |
| `overheadPercentage` | 25 | Overhead percentage (0-100) |
| `mss` | 1500 | Maximum Segment Size |
| `ffs` | 25600 | Flight Flag Size |
| `ipttl` | 64 | IP Time To Live |
| `iptos` | 0xB8 | IP Type of Service |

### Reorder Tolerance Settings

| Parameter | Default | Description |
|-----------|---------|-------------|
| `peerMaxReorderToleranceMs` | 0 | Maximum reorder tolerance in milliseconds |
| `peerMaxReorderTolerancePackets` | 0 | Maximum reorder tolerance in packets |
| `peerMaxReorderToleranceBytes` | 0 | Maximum reorder tolerance in bytes |
| `peerMaxReorderToleranceTime` | 0 | Maximum reorder tolerance in time |

## Platform Support

### Android
- Full SRT support using Media3 ExoPlayer
- Custom `SrtDataSource` implementation using `srtdroid` library
- Custom `TsOnlyExtractorFactory` for Transport Stream format
- Custom SRT content type handling
- Progressive media source for SRT streams
- Low-latency streaming with configurable buffer sizes

### iOS
- SRT support using AVPlayer
- Native SRT protocol handling

### Web
- SRT support via WebRTC (if available)
- Fallback to HLS/DASH if SRT not supported

## Best Practices

### 1. Network Configuration
- Use appropriate buffer sizes for your network conditions
- Set realistic latency tolerance values
- Monitor bandwidth usage and adjust accordingly

### 2. Error Handling
```dart
final controller = BetterPlayerController(
  BetterPlayerConfiguration(
    errorBuilder: (context, errorMessage) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.error, color: Colors.white),
            Text(errorMessage ?? "SRT connection failed"),
          ],
        ),
      );
    },
  ),
  betterPlayerDataSource: dataSource,
);
```

### 3. Connection Monitoring
```dart
controller.videoPlayerController?.videoEventStreamController.listen((event) {
  if (event.eventType == VideoEventType.initialized) {
    print("SRT stream connected successfully");
  } else if (event.eventType == VideoEventType.error) {
    print("SRT stream error: ${event.errorDescription}");
  }
});
```

## Troubleshooting

### Common Issues

1. **Connection Timeout**
   - Increase `connectionTimeoutMs`
   - Check network connectivity
   - Verify SRT server is running

2. **High Latency**
   - Decrease `peerLatencyToleranceMs`
   - Optimize network settings
   - Check server configuration

3. **Buffer Underruns**
   - Increase buffer sizes
   - Check network stability
   - Monitor bandwidth usage

4. **Authentication Issues**
   - Verify SRT server credentials
   - Check firewall settings
   - Ensure proper SRT handshake

### Debug Information

Enable debug logging to troubleshoot SRT issues:

```dart
// In your app initialization
if (kDebugMode) {
  // Enable SRT debug logging
  print("SRT Configuration: ${srtConfig.toMap()}");
}
```

## Examples

See the complete SRT example in the example app:
- `example/lib/pages/srt_player_page.dart`

## Technical Implementation

### Android Implementation Details

The Android implementation uses a custom approach with the following components:

#### 1. SrtDataSource
- Extends Media3's `BaseDataSource`
- Uses `srtdroid` library for SRT protocol handling
- Implements custom buffering with TS packet alignment
- Supports configurable connection parameters

#### 2. SrtDataSourceFactory
- Factory class for creating `SrtDataSource` instances
- Passes SRT configuration to data source
- Integrates with Media3's data source system

#### 3. TsOnlyExtractorFactory
- Provides `TsExtractor` for Transport Stream format
- Optimized for SRT streams carrying TS payload
- Ensures proper packet parsing and synchronization

#### 4. Integration with BetterPlayer
- Custom content type handling (`CONTENT_TYPE_SRT`)
- Seamless integration with existing Media3 infrastructure
- Maintains compatibility with other video formats

### Key Features

- **Low Latency**: Optimized for real-time streaming
- **Configurable**: Extensive SRT parameter customization
- **Robust**: Built-in error handling and recovery
- **Efficient**: Custom buffering for optimal performance

## Additional Resources

- [SRT Protocol Documentation](https://github.com/Haivision/srt)
- [SRT Best Practices](https://github.com/Haivision/srt/blob/master/docs/API.md)
- [SRT Network Configuration](https://github.com/Haivision/srt/blob/master/docs/API.md#network-parameters)

## Support

For SRT-specific issues or questions:
1. Check this documentation
2. Review the example code
3. Open an issue on GitHub
4. Check SRT community forums
