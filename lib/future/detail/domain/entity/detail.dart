class DetailEntity {
  final int? id;
  final String platform;
  final String link;
  final String title;
  final DetailOwner? owner;
  final List<DetailFile>? images;
  final List<DetailFile>? videos;
  final List<DetailFile>? audios;
  final String? thumb;
  final DetailCaption? caption;

  set id(int? id) => id;

  DetailEntity({
    this.id,
    required this.platform,
    required this.link,
    required this.title,
    this.owner,
    this.images,
    this.thumb,
    this.videos,
    this.audios,
    this.caption,
  });

  factory DetailEntity.fromJson(Map<String, dynamic> json) {
    // owner
    DetailOwner? ownerData;
    if (json['owner'] != null) {
      ownerData = DetailOwner.fromJson(json['owner']);
    }

    // images
    List<DetailFile>? imageData;
    if (json['images'] != null) {
      imageData = [];
      final imageList = json['images'];
      for (var image in imageList) {
        imageData.add(DetailFile.fromJson(image));
      }
    }
    // video
    List<DetailFile>? videosData;
    if (json['videos'] != null) {
      videosData = [];
      final videosList = json['videos'];
      for (var video in videosList) {
        videosData.add(DetailFile.fromJson(video));
      }
    }
    // audio
    List<DetailFile>? audiosData;
    if (json['audios'] != null) {
      audiosData = [];
      final audiosList = json['audios'];
      for (var audio in audiosList) {
        audiosData.add(DetailFile.fromJson(audio));
      }
    }
    // caption
    DetailCaption? captionData;
    if (json['caption'] != null) {
      captionData = DetailCaption.fromJson(json['caption']);
    }
    return DetailEntity(
      platform: json['platform'],
      link: json['link'],
      title: json['title'],
      owner: ownerData,
      images: imageData,
      videos: videosData,
      audios: audiosData,
      caption: captionData,
      thumb: json['thumb'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    List<Map<String, dynamic>> imagesJson = [];
    if (images != null) {
      for (var file in images!) {
        imagesJson.add(file.toJson());
      }
    }

    List<Map<String, dynamic>> videosJson = [];
    if (videos != null) {
      for (var file in videos!) {
        videosJson.add(file.toJson());
      }
    }

    List<Map<String, dynamic>> audioJson = [];
    if (audios != null) {
      for (var file in audios!) {
        audioJson.add(file.toJson());
      }
    }

    data['platform'] = platform;
    data['link'] = link;
    data['title'] = title;
    data['owner'] = owner?.toJson();
    data['images'] = imagesJson.isEmpty ? null : imagesJson;
    data['videos'] = videosJson.isEmpty ? null : videosJson;
    data['audios'] = audioJson.isEmpty ? null : imagesJson;
    data['caption'] = caption?.toJson();
    data['thumb'] = thumb;

    return data;
  }
}

class DetailOwner {
  final String? profileUrl;
  final String username;
  final String? bio;

  DetailOwner({
    this.profileUrl,
    required this.username,
    this.bio,
  });

  factory DetailOwner.fromJson(Map<String, dynamic> json) {
    return DetailOwner(
      profileUrl: json['profileUrl'],
      username: json['username'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['profileUrl'] = profileUrl;
    data['username'] = username;
    data['bio'] = bio;
    return data;
  }
}

class DetailFile {
  final String? title;
  final String? file;
  final String url;
  final String name;
  final String type;
  final int? size;
  final String? quality;

  DetailFile({
    this.title,
    this.file,
    required this.url,
    required this.name,
    required this.type,
    this.size,
    this.quality,
  });

  factory DetailFile.fromJson(Map<String, dynamic> json) {
    return DetailFile(
      title: json['title'],
      file: json['file'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      quality: json['quality'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['title'] = title;
    data['file'] = file;
    data['url'] = url;
    data['name'] = name;
    data['type'] = type;
    data['size'] = size;
    data['quality'] = quality;
    return data;
  }
}

class DetailCaption {
  final String? title;
  final String? description;

  DetailCaption({this.title, this.description});

  factory DetailCaption.fromJson(Map<String, dynamic> json) {
    return DetailCaption(
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
