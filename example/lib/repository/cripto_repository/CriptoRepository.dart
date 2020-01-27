import 'package:bsev_demo/repository/cripto_repository/model/Cripto.dart';
import 'package:bsev_demo/support/conection/con.dart';

class CryptoRepository {
  final Con _con;

  CryptoRepository(this._con);

  Future<List<Cripto>> load(int page, int limit) async {
    List response = await _con.get("?convert=BRL&start=$page&limit=$limit");
    return response.map<Cripto>((i) => Cripto.fromJson(i)).toList();
  }
}
