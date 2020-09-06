import 'package:sx_app/model/post.dart';
import 'package:sx_app/view_model/mock_model.dart';
import 'package:sx_app/provider/view_state_refresh_list_model.dart';

class ThumbUpPostModel extends ViewStateRefreshListModel<Post> with MockModel {
  @override
  Future<List<Post>> loadData({int pageNum, int pageSize}) {
    return repository.fetchThumbUpPost(pageNum, pageSize);
  }
}
