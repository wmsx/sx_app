import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sx_app/provider/view_state_list_model.dart';

abstract class ViewStateLastIdRefreshListModel<T>
    extends ViewStateListModel<T> {
  static int firstId = 0;
  static int pageSize = 20;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _lastId = firstId;

  RefreshController get refreshController => _refreshController;

  // 下拉刷新
  @override
  Future<List<T>> refresh({bool init = false}) async {
    try {
      _lastId = firstId;
      var data = await loadData(lastId: _lastId);
      if (data.isEmpty) {
        refreshController.refreshCompleted();
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        setIdle();
      }
      return data;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }

// 上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(lastId: _lastId);
      if (data.isEmpty) {
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        _lastId = getId(data[data.length - 1]);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }
      return data;
    } catch (e, s) {
      setError(e, s);
      refreshController.loadFailed();
      return null;
    }
  }

  int getId(T item);

  Future<List<T>> loadData({int lastId});
}
