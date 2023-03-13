import 'package:catchit/core/locator/locator.dart';
import 'package:catchit/core/resources/data_state.dart';
import 'package:catchit/future/history/data/repository.dart';
import 'package:catchit/future/history/domain/entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryNottifer extends ChangeNotifier {
  List<FileEntity> history = [];

  Future<bool> add(FileEntity entity) async {
    final resutl = await locator<HistoryRepositoryImpl>().addFileToDb(entity);
    if (resutl is DataSuccess) {
      await getHistory();
      notifyListeners();
      return true;
    }
    return false;
  }

  // List<FileEntity> getRecent() {
  //   int len = history.length;
  //   return history.getRange(0, len > 10 ? 10 : len).toList();
  // }

  Future getHistory() async {
    final details = await locator<HistoryRepositoryImpl>().getDbFiles();
    if (details is DataSuccess) {
      history = details.data!;
      history.sort((a, b) => b.id!.compareTo(a.id as int));
      notifyListeners();
    }
  }

  Future clearHisory() async {
    await locator<HistoryRepositoryImpl>().deleteDbFiles();
    history = [];
    notifyListeners();
  }

  Future delete(List<FileEntity> files) async {
    for (var file in files) {
      await locator<HistoryRepositoryImpl>().deleteDbFile(file);
    }
    await getHistory();
    notifyListeners();
  }
}

final historyProvider = ChangeNotifierProvider<HistoryNottifer>((ref) {
  return HistoryNottifer();
});
