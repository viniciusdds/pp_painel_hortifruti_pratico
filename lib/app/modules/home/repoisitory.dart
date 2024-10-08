
import 'package:app_painel_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_painel_hortifruti_pratico/app/data/provider/api.dart';

class HomeRepository {

  final Api _api;

  HomeRepository(this._api);

  Future<List<StoreModel>> getStores(int cityId) => _api.getStores(cityId);
}