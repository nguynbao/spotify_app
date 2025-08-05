class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String url;
  final Duration duration;
  final String coverUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.url,
    required this.duration,
    required this.coverUrl,
  });

  factory Song.fromFirebase(String docId, Map<String, dynamic> data) {
    return Song(
      id: docId,
      title: data['title'] ?? '',
      artist: data['artist'] ?? '',
      album: data['album'] ?? '',
      url: data['url'] ?? '',
      duration: Duration(milliseconds: data['duration'] ?? 0),
      coverUrl: data['coverUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'url': url,
      'duration': duration.inMilliseconds,
      'coverUrl': coverUrl,
    };
  }
}
