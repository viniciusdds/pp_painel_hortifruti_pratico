import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';

class DeletePerfilImageRepository {
  final Api _api;

  DeletePerfilImageRepository(this._api);

  //deletePerfilImage
  Future<void> deleteLogo() => _api.deleteLogo();

}

