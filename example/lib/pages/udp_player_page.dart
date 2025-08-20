import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

class UdpPlayerPage extends StatefulWidget {
  @override
  _UdpPlayerPageState createState() => _UdpPlayerPageState();
}

class _UdpPlayerPageState extends State<UdpPlayerPage> {
  late BetterPlayerController _betterPlayerController;
  final TextEditingController _urlController = TextEditingController();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _urlController.text = "udp://239.255.0.1:1234";
    _initializePlayer();
  }

  void _initializePlayer() {
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: false,
        looping: false,
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          enableProgressBar: true,
          enableProgressText: true,
          enableFullscreen: true,
        ),
        showPlaceholderUntilPlay: true,
        placeholder: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.videocam_off,
                  color: Colors.white,
                  size: 64,
                ),
                SizedBox(height: 16),
                Text(
                  "UDP Stream Ready",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Enter UDP URL and tap Play",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource.udp(
        _urlController.text,
        liveStream: true,
        udpConfiguration: BetterPlayerUdpConfiguration(
          maxPacketSize: 65536,
          connectionTimeout: 10000,
          bufferSize: 1024 * 1024,
          enableMulticast: true,
          ttl: 1,
          enableBroadcast: false,
        ),
      ),
    );

    _betterPlayerController.addEventsListener(_onPlayerEvent);
  }

  void _onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      setState(() {
        _isPlaying = false;
      });
    } else if (event.betterPlayerEventType == BetterPlayerEventType.play) {
      setState(() {
        _isPlaying = true;
      });
    } else if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
      setState(() {
        _isPlaying = false;
      });
    } else if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  void _playUdpStream() {
    final url = _urlController.text.trim();
    if (url.startsWith("udp://")) {
      _betterPlayerController.setupDataSource(
        BetterPlayerDataSource.udp(
          url,
          liveStream: true,
          udpConfiguration: BetterPlayerUdpConfiguration(
            maxPacketSize: 65536,
            connectionTimeout: 10000,
            bufferSize: 1024 * 1024,
            enableMulticast: true,
            ttl: 1,
            enableBroadcast: false,
          ),
        ),
      );
      _betterPlayerController.play();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid UDP URL (udp://host:port)"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _stopUdpStream() {
    _betterPlayerController.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UDP Stream Player"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "UDP Stream Player with Multicast Support",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    labelText: "UDP URL",
                    hintText: "udp://239.255.0.1:1234",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.link),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isPlaying ? null : _playUdpStream,
                        icon: Icon(Icons.play_arrow),
                        label: Text("Play Stream"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isPlaying ? _stopUdpStream : null,
                        icon: Icon(Icons.stop),
                        label: Text("Stop Stream"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(
                controller: _betterPlayerController,
              ),
            ),
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
                      "UDP Configuration:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("• Max Packet Size: 65,536 bytes"),
                    Text("• Connection Timeout: 10 seconds"),
                    Text("• Buffer Size: 1 MB"),
                    Text("• Multicast Support: Enabled"),
                    Text("• TTL: 1"),
                    Text("• Broadcast: Disabled"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    _urlController.dispose();
    super.dispose();
  }
}
