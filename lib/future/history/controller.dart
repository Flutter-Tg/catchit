import 'package:catchit/core/locator/locator.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/detail/data_source/repository/repository_impl.dart';
import 'package:catchit/future/detail/domain/entity/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryNottifer extends ChangeNotifier {
  List<DetailEntity> history = [];

  Future<bool> add(DetailEntity entity, {bool checkDublicate = true}) async {
    if (checkDublicate) {
      List<DetailEntity> check =
          history.where((element) => element.link == entity.link).toList();
      if (check.isEmpty) {
        final resutl =
            await locator<DetailRepositoryImpl>().addDetailToDb(entity);
        if (resutl is DataSuccess) {
          await getHistory();
          notifyListeners();
          return true;
        }
        return false;
      }
      return false;
    } else {
      final resutl =
          await locator<DetailRepositoryImpl>().addDetailToDb(entity);
      if (resutl is DataSuccess) {
        await getHistory();
        notifyListeners();
        return true;
      }
      return false;
    }
  }

  List<DetailEntity> getRecent() {
    int len = history.length;
    return history.getRange(0, len > 10 ? 10 : len).toList();
  }

  Future getHistory() async {
    DataState<List<DetailEntity>> details =
        await locator<DetailRepositoryImpl>().getDbDetails();

    List<DetailEntity> list = [];
    if (details is DataSuccess) {
      list = details.data!;
    }
    history = list.reversed.toList();

    notifyListeners();
  }

  Future clearHisory() async {
    await locator<DetailRepositoryImpl>().deleteDbDetails();
    history = [];
    notifyListeners();
  }

  Future delete(List<int> ids) async {
    for (var id in ids) {
      await locator<DetailRepositoryImpl>().deleteDbDetail(id);
    }
    await getHistory();
    notifyListeners();
  }
}

final historyProvider = ChangeNotifierProvider<HistoryNottifer>((ref) {
  return HistoryNottifer();
});
