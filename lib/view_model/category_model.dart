import 'package:sx_app/model/category.dart';
import 'package:sx_app/provider/view_state_list_model.dart';
import 'package:sx_app/view_model/mock_model.dart';

class CategoryModel extends ViewStateListModel<Category> with MockModel {
 
  @override
  Future<List<Category>> loadData() async {
    return repository.fetchCategories();
  }
}
