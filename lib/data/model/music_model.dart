// To parse this JSON data, do
//
//     final musicModel = musicModelFromJson(jsonString);

import 'dart:convert';

MusicModel musicModelFromJson(String str) => MusicModel.fromJson(json.decode(str));

String musicModelToJson(MusicModel data) => json.encode(data.toJson());

class MusicModel {
  MusicModel({
    required this.tracks,
    required this.seeds,
  });

  List<Track> tracks;
  List<Seed> seeds;

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
    tracks: List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
    seeds: List<Seed>.from(json["seeds"].map((x) => Seed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tracks": List<dynamic>.from(tracks.map((x) => x.toJson())),
    "seeds": List<dynamic>.from(seeds.map((x) => x.toJson())),
  };
}

class Seed {
  Seed({
    this.initialPoolSize,
    this.afterFilteringSize,
    this.afterRelinkingSize,
    this.id,
    this.type,
    this.href,
  });

  int? initialPoolSize;
  int? afterFilteringSize;
  int? afterRelinkingSize;
  String? id;
  String? type;
  String? href;

  factory Seed.fromJson(Map<String, dynamic> json) => Seed(
    initialPoolSize: json["initialPoolSize"],
    afterFilteringSize: json["afterFilteringSize"],
    afterRelinkingSize: json["afterRelinkingSize"],
    id: json["id"],
    type: json["type"],
    href: json["href"] == null ? null : json["href"],
  );

  Map<String, dynamic> toJson() => {
    "initialPoolSize": initialPoolSize,
    "afterFilteringSize": afterFilteringSize,
    "afterRelinkingSize": afterRelinkingSize,
    "id": id,
    "type": type,
    "href": href == null ? null : href,
  };
}

class Track {
  Track({
    this.album,
    this.artists,
    this.discNumber,
    this.durationMs,
    this.explicit,
    this.externalIds,
    this.externalUrls,
    this.href,
    this.id,
    this.isLocal,
    this.isPlayable,
    this.name,
    this.popularity,
    this.previewUrl,
    this.trackNumber,
    this.type,
    this.uri,
    this.linkedFrom,
  });

  Album? album;
  List<Artist>? artists;
  int? discNumber;
  int? durationMs;
  bool? explicit;
  ExternalIds? externalIds;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  bool? isLocal;
  bool? isPlayable;
  String? name;
  int? popularity;
  String? previewUrl;
  int? trackNumber;
  ArtistType? type;
  String? uri;
  Artist? linkedFrom;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    album: Album.fromJson(json["album"]),
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    discNumber: json["disc_number"],
    durationMs: json["duration_ms"],
    explicit: json["explicit"],
    externalIds: ExternalIds.fromJson(json["external_ids"]),
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    isLocal: json["is_local"],
    isPlayable: json["is_playable"],
    name: json["name"],
    popularity: json["popularity"],
    previewUrl: json["preview_url"] == null ? null : json["preview_url"],
    trackNumber: json["track_number"],
    type: artistTypeValues.map![json["type"]],
    uri: json["uri"],
    linkedFrom: json["linked_from"] == null ? null : Artist.fromJson(json["linked_from"]),
  );

  Map<String, dynamic> toJson() => {
    "album": album!.toJson(),
    "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
    "disc_number": discNumber,
    "duration_ms": durationMs,
    "explicit": explicit,
    "external_ids": externalIds!.toJson(),
    "external_urls": externalUrls!.toJson(),
    "href": href,
    "id": id,
    "is_local": isLocal,
    "is_playable": isPlayable,
    "name": name,
    "popularity": popularity,
    "preview_url": previewUrl == null ? null : previewUrl,
    "track_number": trackNumber,
    "type": artistTypeValues.reverse[type],
    "uri": uri,
    "linked_from": linkedFrom == null ? null : linkedFrom!.toJson(),
  };
}

class Album {
  Album({
    this.albumType,
    this.artists,
    this.externalUrls,
    this.href,
    this.id,
    this.images,
    this.name,
    this.releaseDate,
    this.releaseDatePrecision,
    this.totalTracks,
    this.type,
    this.uri,
  });

  AlbumType? albumType;
  List<Artist>? artists;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Image>? images;
  String? name;
  DateTime? releaseDate;
  ReleaseDatePrecision? releaseDatePrecision;
  int? totalTracks;
  AlbumTypeEnum? type;
  String? uri;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    albumType: albumTypeValues.map![json["album_type"]],
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    name: json["name"],
    releaseDate: DateTime.parse(json["release_date"]),
    releaseDatePrecision: releaseDatePrecisionValues.map![json["release_date_precision"]],
    totalTracks: json["total_tracks"],
    type: albumTypeEnumValues.map![json["type"]],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "album_type": albumTypeValues.reverse[albumType],
    "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
    "external_urls": externalUrls!.toJson(),
    "href": href,
    "id": id,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "name": name,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "release_date_precision": releaseDatePrecisionValues.reverse[releaseDatePrecision],
    "total_tracks": totalTracks,
    "type": albumTypeEnumValues.reverse[type],
    "uri": uri,
  };
}

enum AlbumType { SINGLE, ALBUM }

final albumTypeValues = EnumValues({
  "ALBUM": AlbumType.ALBUM,
  "SINGLE": AlbumType.SINGLE
});

class Artist {
  Artist({
    this.externalUrls,
    this.href,
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? name;
  ArtistType? type;
  String ?uri;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    name: json["name"] == null ? null : json["name"],
    type: artistTypeValues.map![json["type"]],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls!.toJson(),
    "href": href,
    "id": id,
    "name": name == null ? null : name,
    "type": artistTypeValues.reverse[type],
    "uri": uri,
  };
}

class ExternalUrls {
  ExternalUrls({
    this.spotify,
  });

  String? spotify;

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
    spotify: json["spotify"],
  );

  Map<String, dynamic> toJson() => {
    "spotify": spotify,
  };
}

enum ArtistType { ARTIST, TRACK }

final artistTypeValues = EnumValues({
  "artist": ArtistType.ARTIST,
  "track": ArtistType.TRACK
});

class Image {
  Image({
    this.height,
    this.url,
    this.width,
  });

  int? height;
  String? url;
  int? width;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    height: json["height"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "url": url,
    "width": width,
  };
}

enum ReleaseDatePrecision { DAY }

final releaseDatePrecisionValues = EnumValues({
  "day": ReleaseDatePrecision.DAY
});

enum AlbumTypeEnum { ALBUM }

final albumTypeEnumValues = EnumValues({
  "album": AlbumTypeEnum.ALBUM
});

class ExternalIds {
  ExternalIds({
    this.isrc,
  });

  String? isrc;

  factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
    isrc: json["isrc"],
  );

  Map<String, dynamic> toJson() => {
    "isrc": isrc,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
