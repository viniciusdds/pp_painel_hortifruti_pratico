

import 'package:app_painel_hortifruti_pratico/app/data/models/category.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/category_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';

class NewCategoryRepository {
  final Api _api;

  NewCategoryRepository(this._api);

  Future<CategoryModel> postCategory(CategoryRequestModel categoryRequest) => _api.postCategory(categoryRequest);


}

