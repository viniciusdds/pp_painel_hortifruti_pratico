import 'package:app_painel_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';

class PerfilRepository {
  final Api _api;

  PerfilRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<UserModel> putUser(userProfileRequestModel) => _api.putUser(userProfileRequestModel);
}

