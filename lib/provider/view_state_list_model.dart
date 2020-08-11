import 'view_state_model.dart';

abstract class ViewStateListModel<T> extends ViewStateModel {
  // 页面数据
  List<T> list = [];

  // 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data);
}
