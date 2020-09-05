import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/provider/view_state_list_model.dart';
import 'package:sx_app/view_model/mock_model.dart';
import 'package:sx_app/view_model/menger_model.dart';

class DiscussGroupListModel extends ViewStateListModel<DiscussGroup>
    with MockModel {
  MengerModel _mengerModel;

  MengerModel get mengerModel => _mengerModel;

  void update(MengerModel mengerModel) {
    _mengerModel = mengerModel;
    initData();
  }

  @override
  Future<List<DiscussGroup>> loadData() {
    if (_mengerModel != null && _mengerModel.hasMenger) {
      return repository.fetchDiscussGroups();
    }
    return Future.value(List());
  }
}
