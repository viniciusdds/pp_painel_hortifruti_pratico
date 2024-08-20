

import 'package:app_painel_hortifruti_pratico/app/data/models/category.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/category_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';

class EditCategoryRepository {
  final Api _api;

  EditCategoryRepository(this._api);

  Future<CategoryModel> putCategory(CategoryRequestModel categoryRequest) => _api.putCategory(categoryRequest);


}

