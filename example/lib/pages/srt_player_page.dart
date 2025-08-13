import 'package:better_player_plus/better_player_plus.dart';
import 'package:better_player_plus/src/configuration/better_player_srt_configuration.dart';
import 'package:flutter/material.dart';

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
    // Example SRT stream URL with parameters - replace with your actual SRT stream
    const String srtUrl = "srt://192.168.1.100:9000?streamid=live&latency=120&passphrase=yourpassphrase&mode=caller&transtype=live&payloadsize=1316";
    
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.srt,
      srtUrl,
      srtConfiguration: BetterPlayerSrtConfiguration(
        connectionTimeoutMs: 5000,
        peerLatencyToleranceMs: 120,
        peerIdleTimeoutMs: 5000,
        inputBufferSize: 16384,
        outputBufferSize: 16384,
        maxBandwidth: 0, // 0 means unlimited
        overheadPercentage: 25,
        mss: 1500,
        ffs: 25600,
        ipttl: 64,
        iptos: 0xB8,
        handshakeTimeoutMs: 5000,
        peerConnectionTimeoutMs: 5000,
        peerKeepAliveIntervalMs: 1000,
        peerKeepAliveTimeoutMs: 5000,
      ),
      headers: {
        'User-Agent': 'BetterPlayerPlus/1.0.6',
      },
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: "SRT Stream Example",
        author: "Better Player Plus",
        notificationChannelName: "SRT Player",
      ),
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoDetectFullscreenDeviceOrientation: true,
        autoDetectFullscreenAspectRatio: true,
        allowedScreenSleep: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 42,
                ),
                Text(
                  errorMessage ?? "Unknown error occurred",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
      betterPlayerDataSource: _betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SRT Stream Player"),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "SRT (Secure Reliable Transport) Streaming Example",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "This example demonstrates SRT streaming support in Better Player Plus.\n\n"
              "SRT is a protocol for low-latency video streaming that provides:\n"
              "• Secure transmission\n"
              "• Reliable delivery\n"
              "• Low latency\n"
              "• Adaptive bitrate\n\n"
              "Note: Replace the SRT URL with your actual SRT stream server.",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SRT Configuration:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("Connection Timeout: ${_betterPlayerDataSource.srtConfiguration?.connectionTimeoutMs}ms"),
                    Text("Peer Latency Tolerance: ${_betterPlayerDataSource.srtConfiguration?.peerLatencyToleranceMs}ms"),
                    Text("Input Buffer Size: ${_betterPlayerDataSource.srtConfiguration?.inputBufferSize} bytes"),
                    Text("Output Buffer Size: ${_betterPlayerDataSource.srtConfiguration?.outputBufferSize} bytes"),
                    Text("Max Bandwidth: ${_betterPlayerDataSource.srtConfiguration?.maxBandwidth == 0 ? 'Unlimited' : '${_betterPlayerDataSource.srtConfiguration?.maxBandwidth} bytes/s'}"),
                    Text("Overhead: ${_betterPlayerDataSource.srtConfiguration?.overheadPercentage}%"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
