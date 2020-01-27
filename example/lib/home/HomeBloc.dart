import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home/HomeEvents.dart';
import 'package:bsev_demo/home/HomeStreams.dart';
import 'package:bsev_demo/repository/cripto_repository/CriptoRepository.dart';
import 'package:bsev_demo/repository/cripto_repository/model/Cripto.dart';

class HomeBloc extends BlocBase<HomeStreams> {
  final CryptoRepository api;

  int _page = 0;
  List<Cripto> _list;
  static const limit = 20;

  HomeBloc(this.api);

  @override
  void initView() {
    loadCrypto(false);
  }

  @override
  void eventReceiver(EventsBase event) {
    if (event is HomeEventLoad) {
      loadCrypto(false);
    }

    if (event is HomeEventLoadMore) {
      loadCrypto(true);
    }
  }

  void loadCrypto(bool isMore) {
    if (streams.showProgress.value) {
      return;
    }

    if (isMore) {
      _page++;
    } else {
      _page = 0;
    }

    streams.showProgress.set(true);

    api.load(_page, limit).then((crypto) {
      if (isMore) {
        _list.addAll(crypto);
      } else {
        _list = crypto;
      }

      streams.cryptoCoins.set(_list);
      streams.showProgress.set(false);
    }).catchError((error) {
      streams.showProgress.set(false);
      dispatchView(
          HomeEventShowError()..msg = "Unable conection to load information");
    });
  }
}
