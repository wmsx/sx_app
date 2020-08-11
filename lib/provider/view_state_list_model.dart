import 'view_state_model.dart';

abstract class ViewStateListModel<T> extends ViewStateModel {
  // 页面数据
  List<T> list = [];

  initData() async {
    setBusy();
    await refresh();
  }

  refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setIdle();
      }
    } catch (e, s) {
      setError(e, s);
    }
  }

  // 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}
}
