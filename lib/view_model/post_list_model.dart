import 'package:sx_app/model/post.dart';
import 'package:sx_app/provider/view_state_last_id_refresh_list_model.dart';
import 'package:sx_app/service/mock_sx_repository.dart';
import 'package:sx_app/service/sx_repository.dart';
import 'package:sx_app/view_model/mock_model.dart';

class PostListModel extends ViewStateLastIdRefreshListModel<Post>
    with MockModel {
  final int categoryId;

  PostListModel(this.categoryId);

  @override
  Future<List<Post>> loadData({int lastId = 0}) {
    return repository.fetchPosts(categoryId, lastId);
  }

  @override
  int getId(Post post) {
    return post.id;
  }
}
