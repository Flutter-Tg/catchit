class FileInfoParam {
  final String format;
  final String type;
  final int? size;

  FileInfoParam({
    required this.format,
    required this.type,
    this.size,
  });
}
