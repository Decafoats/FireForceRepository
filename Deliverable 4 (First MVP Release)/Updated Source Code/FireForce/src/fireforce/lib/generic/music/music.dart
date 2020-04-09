import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

Future<AudioPlayer> playIncorrect() async {
  AudioCache cache = new AudioCache();
  return await cache.play("music/wrong.mp3");
}

Future<AudioPlayer> playCheer() async {
  AudioCache cache = new AudioCache();
  return await cache.play("music/cheer.wav");
}

Future<AudioPlayer> playBark() async {
  AudioCache cache = new AudioCache();
  return await cache.play("music/bark.wav");
}