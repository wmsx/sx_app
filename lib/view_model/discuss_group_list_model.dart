import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/provider/view_state_list_model.dart';
import 'package:sx_app/service/mock_sx_repository.dart';
import 'package:sx_app/service/sx_repository.dart';
import 'package:sx_app/view_model/mock_model.dart';

class DiscussGroupListModel extends ViewStateListModel<DiscussGroup>
    with MockModel {
      
  @override
  Future<List<DiscussGroup>> loadData() {
    return isMock
        ? MockSXRepository.fetchDiscussGroup()
        : SXRepository.fetchDiscussGroup();
  }
}
