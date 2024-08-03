extension TimeFormat on Duration {
  String get formatTime {
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }
}
