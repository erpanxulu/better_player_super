# SRT Streaming Implementation in Better Player Plus

This document explains the new SRT (Secure Reliable Transport) streaming implementation that has been integrated into the `better_player_plus` package.

## Overview

The SRT streaming implementation provides low-latency, reliable video streaming capabilities using the SRT protocol. This implementation uses a custom approach with the `srtdroid` library for optimal performance on Android.

## Architecture

### Flutter Layer
- `BetterPlayerDataSourceType.srt` - New data source type for SRT streams
- `BetterPlayerVideoFormat.srt` - Video format hint for SRT content
- `BetterPlayerSrtConfiguration` - Comprehensive SRT configuration class
- `setSrtDataSource()` method - New method for setting SRT data sources

### Android Layer (Media3 ExoPlayer)
- `SrtDataSource` - Custom Media3 data source for SRT protocol
- `SrtDataSourceFactory` - Factory for creating SRT data sources
- `TsOnlyExtractorFactory` - Custom extractor for Transport Stream format
- Integration with existing `BetterPlayer` architecture

### iOS Layer (AVPlayer)
- Native SRT support through AVPlayer
- Basic SRT streaming capabilities

## Key Components

### 1. SrtDataSource
```kotlin
class SrtDataSource(
    private val srtConfiguration: Map<String, Any?>? = null
) : BaseDataSource(/*isNetwork*/true)
```

**Features:**
- Extends Media3's `BaseDataSource`
- Uses `srtdroid` library for SRT protocol handling
- Implements custom buffering with TS packet alignment
- Supports configurable connection parameters
- Handles SRT URL parsing and connection management

**Key Methods:**
- `open(dataSpec: DataSpec)` - Establishes SRT connection
- `read(buffer: ByteArray, offset: Int, length: Int)` - Reads data from SRT socket
- `close()` - Closes SRT connection and cleans up resources

### 2. SrtDataSourceFactory
```kotlin
class SrtDataSourceFactory(
    private val srtConfiguration: Map<String, Any?>? = null
) : DataSource.Factory
```

**Purpose:**
- Factory class for creating `SrtDataSource` instances
- Passes SRT configuration to data source
- Integrates with Media3's data source system

### 3. TsOnlyExtractorFactory
```kotlin
class TsOnlyExtractorFactory : ExtractorsFactory {
    override fun createExtractors(): Array<Extractor> = arrayOf(
        TsExtractor()
    )
}
```

**Purpose:**
- Provides `TsExtractor` for Transport Stream format
- Optimized for SRT streams carrying TS payload
- Ensures proper packet parsing and synchronization

## Configuration

### SRT Configuration Parameters

The `BetterPlayerSrtConfiguration` class provides extensive configuration options:

```dart
BetterPlayerSrtConfiguration(
  connectionTimeoutMs: 5000,
  peerLatencyToleranceMs: 120,
  maxBW: 12000000,
  inputBW: 12000000,
  overhead: 25,
  mss: 1500,
  ffi: 25600,
  ipttl: 64,
  iptos: 0xB8,
  latencyTolerance: 120,
  peerLatencyTolerance: 120,
  rcvLatency: 120,
  peerIdleTimeout: 5000,
  streamId: "live",
  passphrase: "yourpassphrase",
  pbkeylen: 32,
  transtype: "live",
  mode: "caller",
  payloadSize: 1316,
)
```

### SRT URL Format

```dart
const String srtUrl = "srt://192.168.1.100:9000?streamid=live&latency=120&passphrase=yourpassphrase&mode=caller&transtype=live&payloadsize=1316";
```

**URL Parameters:**
- `streamid` - Stream identifier
- `latency` - Latency tolerance in milliseconds
- `passphrase` - Authentication passphrase
- `mode` - Connection mode (caller/listener)
- `transtype` - Transmission type (live/file)
- `payloadsize` - Payload size in bytes

## Usage Example

### Basic SRT Streaming

```dart
import 'package:better_player_plus/better_player_plus.dart';
import 'package:better_player_plus/src/configuration/better_player_srt_configuration.dart';

class SrtPlayerPage extends StatefulWidget {
  @override
  _SrtPlayerPageState createState() => _SrtPlayerPageState();
}

class _SrtPlayerPageState extends State<SrtPlayerPage> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    const String srtUrl = "srt://your-srt-server:9000";
    
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.srt,
      srtUrl,
      srtConfiguration: BetterPlayerSrtConfiguration(
        connectionTimeoutMs: 5000,
        peerLatencyToleranceMs: 120,
        streamId: "live",
        passphrase: "yourpassphrase",
      ),
    );
    
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
      ),
    );
    
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SRT Stream Player")),
      body: BetterPlayer(controller: _betterPlayerController),
    );
  }
}
```

### Advanced Configuration

```dart
BetterPlayerSrtConfiguration(
  // Connection settings
  connectionTimeoutMs: 10000,
  peerConnectionTimeoutMs: 8000,
  
  // Latency settings
  peerLatencyToleranceMs: 200,
  latencyTolerance: 200,
  rcvLatency: 200,
  
  // Buffer settings
  inputBufferSize: 32768,
  outputBufferSize: 32768,
  
  // Network settings
  maxBW: 25000000, // 25 Mbps
  overhead: 25,
  mss: 1500,
  
  // Security settings
  passphrase: "secure-passphrase-123",
  pbkeylen: 32,
  
  // Stream settings
  streamId: "live-stream-1",
  transtype: "live",
  mode: "caller",
  payloadSize: 1316,
)
```

## Dependencies

### Android Dependencies

```gradle
dependencies {
    implementation "io.github.thibaultbee:srtdroid:1.0.0"
}

repositories {
    maven { url 'https://jitpack.io' }
}
```

### Flutter Dependencies

The SRT functionality is built into the `better_player_plus` package, so no additional Flutter dependencies are required.

## Performance Considerations

### Buffer Sizes
- Larger buffer sizes provide better stability but increase latency
- Smaller buffer sizes reduce latency but may cause stuttering
- Recommended starting values: 16KB-32KB for input/output buffers

### Latency Settings
- `peerLatencyToleranceMs` affects end-to-end latency
- Lower values = lower latency but less tolerance for network jitter
- Recommended range: 120-200ms for live streaming

### Bandwidth Management
- Set `maxBW` based on your network capacity
- Monitor actual bandwidth usage and adjust accordingly
- Use `overhead` parameter to account for protocol overhead

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
if (kDebugMode) {
  print("SRT Configuration: ${srtConfig.toMap()}");
}
```

## Platform Support

### Android
- ✅ Full SRT support with custom implementation
- ✅ Low-latency streaming capabilities
- ✅ Extensive configuration options
- ✅ Transport Stream format support

### iOS
- ✅ Basic SRT support via AVPlayer
- ⚠️ Limited configuration options
- ⚠️ May have higher latency than Android

### Web
- ❌ No SRT support (WebRTC fallback not implemented)
- 🔄 Falls back to HLS/DASH if available

## Future Enhancements

### Planned Features
- WebRTC-based SRT support for web platforms
- Advanced SRT statistics and monitoring
- Dynamic bitrate adaptation
- Multi-stream SRT support
- Enhanced error recovery mechanisms

### Performance Optimizations
- Zero-copy buffer handling
- Hardware acceleration support
- Network quality adaptation
- Predictive buffering

## Contributing

To contribute to the SRT implementation:

1. Fork the repository
2. Create a feature branch
3. Implement your changes
4. Add tests for new functionality
5. Submit a pull request

## Support

For SRT-specific issues or questions:

1. Check this documentation
2. Review the example code
3. Open an issue on GitHub
4. Check SRT community forums

## License

This SRT implementation is part of the `better_player_plus` package and follows the same license terms.
