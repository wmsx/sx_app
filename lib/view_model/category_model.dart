import 'package:sx_app/model/category.dart';
import 'package:sx_app/provider/view_state_list_model.dart';
import 'package:sx_app/service/sx_repository.dart';

class CategoryModel extends ViewStateListModel<Category> {
  @override
  Future<List<Category>> loadData() async {
    return SXRepository.fetchCategories();
  }
}
