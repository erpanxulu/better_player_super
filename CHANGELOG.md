# Changelog

## 1.0.6

### Added
- **SRT Streaming Support**: Added support for SRT (Secure Reliable Transport) streaming protocol
  - New `BetterPlayerDataSourceType.srt` for SRT data sources
  - New `BetterPlayerSrtConfiguration` class with comprehensive SRT parameters
  - New `setSrtDataSource()` method in VideoPlayerController
  - Android implementation using Media3 ExoPlayer with custom SRT content type
  - Custom Android implementation using `srtdroid` library:
    - `SrtDataSource` for low-latency SRT streaming
    - `SrtDataSourceFactory` for creating SRT data sources
    - `TsOnlyExtractorFactory` for Transport Stream format
  - iOS support for SRT streaming
  - Example SRT player page in the example app
  - Comprehensive SRT documentation and configuration guide

### Features
- SRT protocol support for low-latency video streaming
- Configurable SRT parameters including connection timeouts, buffer sizes, and network settings
- Support for SRT URLs (srt://host:port)
- Backward compatibility with existing video sources
- Platform-specific optimizations for Android and iOS

### Documentation
- Added SRT streaming documentation (`doc/srt_streaming.md`)
- Updated README with SRT feature information
- Added SRT example page to demonstrate usage
- Comprehensive configuration parameter documentation

## 1.0.5

* package update

## 1.0.4

* ios player bug fix

## 1.0.3

* ExoPlayer migration Media3

## 1.0.2

* bug fix

## 1.0.1

* bug fix

## 1.0.0

* Initial release.
