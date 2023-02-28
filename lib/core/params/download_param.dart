class DownloadBtnParam {
  final String? title;
  final String fileUrl;
  final String fileName;
  final int? fileSize;
  final bool isAudio;
  final bool isImage;
  final bool isVideo;

  DownloadBtnParam(
      {this.title,
      required this.fileUrl,
      required this.fileName,
      this.fileSize,
      this.isAudio = false,
      this.isImage = false,
      this.isVideo = false});
}
