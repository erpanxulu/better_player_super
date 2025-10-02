import 'package:flutter_test/flutter_test.dart';
import 'package:better_player_plus/src/configuration/better_player_data_source_type.dart';
import 'package:better_player_plus/src/configuration/better_player_srt_configuration.dart';
import 'package:better_player_plus/src/configuration/better_player_video_format.dart';
import 'package:better_player_plus/src/video_player/video_player_platform_interface.dart';

void main() {
  group('SRT Support Tests', () {
    test('BetterPlayerDataSourceType.srt should be available', () {
      expect(BetterPlayerDataSourceType.srt, isNotNull);
      expect(BetterPlayerDataSourceType.values, contains(BetterPlayerDataSourceType.srt));
    });

    test('BetterPlayerVideoFormat.srt should be available', () {
      expect(BetterPlayerVideoFormat.srt, isNotNull);
      expect(BetterPlayerVideoFormat.values, contains(BetterPlayerVideoFormat.srt));
    });

    test('BetterPlayerSrtConfiguration should have default values', () {
      final config = BetterPlayerSrtConfiguration();
      
      expect(config.connectionTimeoutMs, equals(3000));
      expect(config.peerLatencyToleranceMs, equals(120));
      expect(config.peerIdleTimeoutMs, equals(5000));
      expect(config.inputBufferSize, equals(8192));
      expect(config.outputBufferSize, equals(8192));
      expect(config.maxBandwidth, equals(0));
      expect(config.overheadPercentage, equals(25));
      expect(config.mss, equals(1500));
      expect(config.ffs, equals(25600));
      expect(config.ipttl, equals(64));
      expect(config.iptos, equals(0xB8));
    });

    test('BetterPlayerSrtConfiguration should support custom values', () {
      final config = BetterPlayerSrtConfiguration(
        connectionTimeoutMs: 10000,
        peerLatencyToleranceMs: 200,
        inputBufferSize: 16384,
        outputBufferSize: 16384,
        maxBandwidth: 1000000,
        overheadPercentage: 30,
      );
      
      expect(config.connectionTimeoutMs, equals(10000));
      expect(config.peerLatencyToleranceMs, equals(200));
      expect(config.inputBufferSize, equals(16384));
      expect(config.outputBufferSize, equals(16384));
      expect(config.maxBandwidth, equals(1000000));
      expect(config.overheadPercentage, equals(30));
    });

    test('BetterPlayerSrtConfiguration.toMap should return correct map', () {
      final config = BetterPlayerSrtConfiguration(
        connectionTimeoutMs: 5000,
        peerLatencyToleranceMs: 150,
      );
      
      final map = config.toMap();
      
      expect(map['connectionTimeoutMs'], equals(5000));
      expect(map['peerLatencyToleranceMs'], equals(150));
      expect(map['peerIdleTimeoutMs'], equals(5000)); // default value
      expect(map['inputBufferSize'], equals(8192)); // default value
    });

    test('BetterPlayerSrtConfiguration.fromMap should create correct instance', () {
      final map = {
        'connectionTimeoutMs': 8000,
        'peerLatencyToleranceMs': 180,
        'inputBufferSize': 32768,
        'maxBandwidth': 2000000,
      };
      
      final config = BetterPlayerSrtConfiguration.fromMap(map);
      
      expect(config.connectionTimeoutMs, equals(8000));
      expect(config.peerLatencyToleranceMs, equals(180));
      expect(config.inputBufferSize, equals(32768));
      expect(config.maxBandwidth, equals(2000000));
      expect(config.outputBufferSize, equals(8192)); // default value
    });

    test('DataSource should support SRT source type', () {
      final dataSource = DataSource(
        sourceType: DataSourceType.srt,
        uri: 'srt://example.com:9000',
        srtConfiguration: BetterPlayerSrtConfiguration(
          connectionTimeoutMs: 5000,
        ),
      );
      
      expect(dataSource.sourceType, equals(DataSourceType.srt));
      expect(dataSource.uri, equals('srt://example.com:9000'));
      expect(dataSource.srtConfiguration, isNotNull);
      expect(dataSource.srtConfiguration!.connectionTimeoutMs, equals(5000));
    });

    test('DataSource rawFormalHint should handle SRT format', () {
      final dataSource = DataSource(
        sourceType: DataSourceType.srt,
        uri: 'srt://example.com:9000',
        formatHint: BetterPlayerVideoFormat.srt,
      );
      
      expect(dataSource.rawFormalHint, equals('srt'));
    });

    test('DataSource key should include SRT format hint', () {
      final dataSource = DataSource(
        sourceType: DataSourceType.srt,
        uri: 'srt://example.com:9000',
        formatHint: BetterPlayerVideoFormat.srt,
      );
      
      expect(dataSource.key, equals('srt://example.com:9000:srt'));
    });

    test('BetterPlayerSrtConfiguration toString should be readable', () {
      final config = BetterPlayerSrtConfiguration(
        connectionTimeoutMs: 5000,
        peerLatencyToleranceMs: 120,
      );
      
      final string = config.toString();
      
      expect(string, contains('BetterPlayerSrtConfiguration'));
      expect(string, contains('connectionTimeoutMs: 5000'));
      expect(string, contains('peerLatencyToleranceMs: 120'));
    });

    test('BetterPlayerSrtConfiguration should handle edge cases', () {
      final config = BetterPlayerSrtConfiguration(
        maxBandwidth: 0, // unlimited
        overheadPercentage: 0, // minimum
        peerMaxReorderToleranceMs: 0, // disabled
      );
      
      expect(config.maxBandwidth, equals(0));
      expect(config.overheadPercentage, equals(0));
      expect(config.peerMaxReorderToleranceMs, equals(0));
    });
  });
}
