# RTSP Streaming Support

Better Player Plus now supports RTSP (Real Time Streaming Protocol) streaming, a protocol designed for real-time video streaming over IP networks.

## What is RTSP?

RTSP (Real Time Streaming Protocol) is a network control protocol designed for use in entertainment and communications systems to control streaming media servers. It's particularly useful for:

- IP camera streaming
- Surveillance systems
- Live video broadcasting
- Video conferencing
- Any application requiring real-time video streaming over IP

## Key Features of RTSP

- **Real-time Streaming**: Low-latency video streaming over IP networks
- **Live and On-demand**: Supports both live and on-demand content
- **Transport Flexibility**: Supports RTP over UDP (unicast) and RTP over RTSP (TCP interleaved)
- **Authentication**: Supports Basic and Digest authentication
- **Cross-platform**: Works on Android and iOS

## Usage

### Basic RTSP Streaming

```dart
import 'package:better_player_plus/better_player_plus.dart';

// Create RTSP data source
final dataSource = BetterPlayerDataSource(
  BetterPlayerDataSourceType.rtsp,
  "rtsp://your-rtsp-server:554/stream",
  rtspConfiguration: BetterPlayerRtspConfiguration(
    timeoutMs: 10000,
    forceUseRtpTcp: false,
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

### RTSP with Authentication

```dart
final dataSource = BetterPlayerDataSource(
  BetterPlayerDataSourceType.rtsp,
  "rtsp://your-rtsp-server:554/stream",
  rtspConfiguration: BetterPlayerRtspConfiguration(
    timeoutMs: 10000,
    forceUseRtpTcp: false,
    username: "admin",
    password: "password",
  ),
);
```

### RTSP with TCP Transport (for NAT/Firewall environments)

```dart
final dataSource = BetterPlayerDataSource(
  BetterPlayerDataSourceType.rtsp,
  "rtsp://your-rtsp-server:554/stream",
  rtspConfiguration: BetterPlayerRtspConfiguration(
    timeoutMs: 10000,
    forceUseRtpTcp: true, // Force TCP transport
  ),
);
```

### Using Factory Method

```dart
final dataSource = BetterPlayerDataSource.rtsp(
  "rtsp://your-rtsp-server:554/stream",
  liveStream: true,
  rtspConfiguration: BetterPlayerRtspConfiguration(
    timeoutMs: 10000,
    forceUseRtpTcp: false,
  ),
);

final controller = BetterPlayerController(
  BetterPlayerConfiguration(
    autoPlay: true,
  ),
  betterPlayerDataSource: dataSource,
);
```

## Configuration Parameters

### Connection Settings

| Parameter | Default | Description |
|-----------|---------|-------------|
| `timeoutMs` | 10000 | Connection timeout in milliseconds |
| `forceUseRtpTcp` | false | Force use of RTP over TCP (interleaved mode). If false, RTSP will try UDP first and fallback to TCP if needed |

### Authentication

| Parameter | Default | Description |
|-----------|---------|-------------|
| `username` | null | Username for RTSP authentication (optional) |
| `password` | null | Password for RTSP authentication (optional) |

**Note**: You can also include credentials directly in the RTSP URL:
```
rtsp://username:password@host:port/path
```

## Platform Support

### Android
- Full RTSP support using Media3 ExoPlayer RTSP extension
- Uses `RtspMediaSource` from Media3
- Supports H.264 video and AAC/AC-3 audio
- Automatic transport selection (UDP first, TCP fallback)
- Basic and Digest authentication support

### iOS
- RTSP support using AVPlayer
- Native RTSP protocol handling
- Supports standard RTSP features

## Transport Modes

### UDP Transport (Default)
- RTSP tries UDP transport first
- Lower latency
- Better for local networks
- May not work through NAT/firewalls

### TCP Transport (Interleaved)
- RTP packets are interleaved over RTSP TCP connection
- Works through NAT/firewalls
- Slightly higher latency
- Set `forceUseRtpTcp: true` to force TCP mode

## Best Practices

### 1. Network Configuration
- Use TCP transport (`forceUseRtpTcp: true`) for networks with NAT/firewalls
- Adjust timeout based on network conditions
- Monitor connection stability

### 2. Error Handling
```dart
final controller = BetterPlayerController(
  BetterPlayerConfiguration(
    errorBuilder: (context, errorMessage) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.error, color: Colors.white),
            Text(errorMessage ?? "RTSP connection failed"),
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
    print("RTSP stream connected successfully");
  } else if (event.eventType == VideoEventType.error) {
    print("RTSP stream error: ${event.errorDescription}");
  }
});
```

## Troubleshooting

### Common Issues

1. **Connection Timeout**
   - Increase `timeoutMs`
   - Check network connectivity
   - Verify RTSP server is running and accessible
   - Check firewall settings

2. **No Video/Audio**
   - Verify RTSP server supports H.264 video and AAC/AC-3 audio
   - Check codec compatibility
   - Ensure stream is active

3. **NAT/Firewall Issues**
   - Use TCP transport mode (`forceUseRtpTcp: true`)
   - Check port forwarding if needed
   - Verify RTSP server configuration

4. **Authentication Issues**
   - Verify credentials are correct
   - Check RTSP server authentication settings
   - Try including credentials in URL format

### Debug Information

Enable debug logging to troubleshoot RTSP issues:

```dart
// In your app initialization
if (kDebugMode) {
  // Enable RTSP debug logging
  print("RTSP Configuration: ${rtspConfig.toMap()}");
}
```

## Supported Codecs

### Video
- **H.264**: Full support (requires SPS/PPS in SDP)

### Audio
- **AAC**: ADTS-wrapped AAC audio
- **AC-3**: AC-3 audio

**Note**: H.265 (HEVC) support is limited and may not work with all streams.

## Examples

### IP Camera Streaming
```dart
final dataSource = BetterPlayerDataSource.rtsp(
  "rtsp://192.168.1.100:554/stream1",
  liveStream: true,
  rtspConfiguration: BetterPlayerRtspConfiguration(
    timeoutMs: 10000,
    username: "admin",
    password: "admin123",
  ),
);
```

### Public RTSP Stream
```dart
final dataSource = BetterPlayerDataSource.rtsp(
  "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4",
  rtspConfiguration: BetterPlayerRtspConfiguration(
    timeoutMs: 15000,
  ),
);
```

## Technical Implementation

### Android Implementation Details

The Android implementation uses Media3 ExoPlayer RTSP extension:

#### 1. RtspMediaSource
- Uses `androidx.media3.exoplayer.rtsp.RtspMediaSource` from Media3
- Handles RTSP protocol negotiation
- Manages RTP packet reception
- Supports both UDP and TCP transport

#### 2. Configuration
- Timeout configuration via `setTimeoutMs()`
- Transport mode via `setForceUseRtpTcp()`
- Authentication via URI credentials

#### 3. Integration with BetterPlayer
- Custom content type handling (`CONTENT_TYPE_RTSP`)
- Seamless integration with existing Media3 infrastructure
- Maintains compatibility with other video formats

### Key Features

- **Low Latency**: Optimized for real-time streaming
- **Configurable**: Timeout and transport mode customization
- **Robust**: Built-in error handling and recovery
- **Efficient**: Uses Media3's optimized RTSP implementation

## Additional Resources

- [RTSP Protocol Specification (RFC 2326)](https://tools.ietf.org/html/rfc2326)
- [Media3 RTSP Documentation](https://developer.android.com/media/media3/exoplayer/rtsp)
- [RTSP Best Practices](https://developer.android.com/media/media3/exoplayer/rtsp)

## Support

For RTSP-specific issues or questions:
1. Check this documentation
2. Review the example code
3. Open an issue on GitHub
4. Check Media3 documentation for RTSP limitations
