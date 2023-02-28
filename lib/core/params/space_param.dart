import 'package:catchit/future/detail/domain/entity/detail.dart';

class SpaceParam {
  final String id;
  final String? user;
  final DetailEntity detail;
  final String created;
  final int catchCount;
  bool show;
  final List<String>? hashtags;

  set canShow(bool canShow) {
    show = canShow;
  }

  SpaceParam({
    required this.id,
    this.user,
    required this.detail,
    required this.created,
    required this.catchCount,
    required this.show,
    this.hashtags,
  });
}
