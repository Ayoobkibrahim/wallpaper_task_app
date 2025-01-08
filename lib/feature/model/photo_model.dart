import 'dart:convert';

PhotoModel photoModelFromMap(String str) => PhotoModel.fromMap(json.decode(str));

String photoModelToMap(PhotoModel data) => json.encode(data.toMap());

class PhotoModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  int? width;
  int? height;
  String? color;
  int? likes;
  User? user;
  Urls? urls;
  PhotoModelLinks? links;
  Location? location;
  Exif? exif;
  int? views;
  int? downloads;

  PhotoModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.likes,
    this.user,
    this.urls,
    this.links,
    this.location,
    this.exif,
    this.views,
    this.downloads,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> json) => PhotoModel(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        width: json["width"],
        height: json["height"],
        color: json["color"],
        likes: json["likes"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        urls: json["urls"] == null ? null : Urls.fromMap(json["urls"]),
        links: json["links"] == null ? null : PhotoModelLinks.fromMap(json["links"]),
        location: json["location"] == null ? null : Location.fromMap(json["location"]),
        exif: json["exif"] == null ? null : Exif.fromMap(json["exif"]),
        views: json["views"],
        downloads: json["downloads"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "width": width,
        "height": height,
        "color": color,
        "likes": likes,
        "user": user?.toMap(),
        "urls": urls?.toMap(),
        "links": links?.toMap(),
        "location": location?.toMap(),
        "exif": exif?.toMap(),
        "views": views,
        "downloads": downloads,
      };
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  factory Urls.fromMap(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
      );

  Map<String, dynamic> toMap() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
      };
}

class User {
  String? id;
  String? username;
  String? name;
  ProfileImage? profileImage;

  User({
    this.id,
    this.username,
    this.name,
    this.profileImage,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        profileImage: json["profile_image"] == null
            ? null
            : ProfileImage.fromMap(json["profile_image"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "name": name,
        "profile_image": profileImage?.toMap(),
      };
}

class ProfileImage {
  String? small;
  String? medium;
  String? large;

  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  factory ProfileImage.fromMap(Map<String, dynamic> json) => ProfileImage(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toMap() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}

class PhotoModelLinks {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  PhotoModelLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory PhotoModelLinks.fromMap(Map<String, dynamic> json) => PhotoModelLinks(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toMap() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}

class Exif {
  String? make;
  String? model;
  String? exposureTime;
  String? aperture;
  String? focalLength;
  int? iso;

  Exif({
    this.make,
    this.model,
    this.exposureTime,
    this.aperture,
    this.focalLength,
    this.iso,
  });

  factory Exif.fromMap(Map<String, dynamic> json) => Exif(
        make: json["make"],
        model: json["model"],
        exposureTime: json["exposure_time"],
        aperture: json["aperture"],
        focalLength: json["focal_length"],
        iso: json["iso"],
      );

  Map<String, dynamic> toMap() => {
        "make": make,
        "model": model,
        "exposure_time": exposureTime,
        "aperture": aperture,
        "focal_length": focalLength,
        "iso": iso,
      };
}

class Location {
  String? name;
  String? city;
  String? country;

  Location({
    this.name,
    this.city,
    this.country,
  });

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        name: json["name"],
        city: json["city"],
        country: json["country"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "city": city,
        "country": country,
      };
}
