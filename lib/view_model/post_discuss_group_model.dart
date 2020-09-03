import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/view_model/mock_model.dart';
import 'package:sx_app/provider/view_state_model.dart';

class PostDiscussGroupModel extends ViewStateModel with MockModel {
  List<DiscussGroup> lastest10DiscussGroups;
  List<DiscussGroup> discussGroups;

  fetchLastest10DiscussGroups() async {
    setBusy();
    try {
      lastest10DiscussGroups = await repository.fetchLastest10DiscussGroups();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  fetchDiscussGroups() async {
    setBusy();
    try {
      discussGroups = await repository.fetchDiscussGroups();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
