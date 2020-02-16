import 'package:bsev_demo/repository/cripto_repository/CriptoRepository.dart';
import 'package:bsev_demo/repository/cripto_repository/model/Cripto.dart';
import 'package:bsev_demo/screens/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCryptoRepository extends Mock implements CryptoRepository {}

void main() {
  MockCryptoRepository _mockCryptoRepository;

  HomeBloc _homeBloc;
  HomeStreams _homeSreams;

  setUp(() {
    _mockCryptoRepository = MockCryptoRepository();
    _homeSreams = HomeStreams();
    _homeBloc = HomeBloc(_mockCryptoRepository)..streams = _homeSreams;
  });

  tearDown(() {
    _homeBloc?.dispose();
  });

  test('initial streams', () {
    expect(_homeSreams.cryptoCoins.value, null);
    expect(_homeSreams.showProgress.value, false);
  });

  test('initial bloc loadCripto', () {
    List<Cripto> mockList = [Cripto(), Cripto(), Cripto(), Cripto(), Cripto()];

    final expectedShowProgress = [
      true,
      false,
    ];

    final expectedCryptoCoins = [
      null,
      mockList,
    ];

    when(_mockCryptoRepository.load(0, HomeBloc.limit))
        .thenAnswer((_) => Future.value(mockList));

    _homeBloc.initView();

    expectLater(
        _homeSreams.showProgress.get, emitsInOrder(expectedShowProgress));

    expectLater(_homeSreams.cryptoCoins.get, emitsInOrder(expectedCryptoCoins));
  });

  test('loadMore Cripto', () {
    List<Cripto> mockList = [Cripto(), Cripto(), Cripto(), Cripto(), Cripto()];

    final expectedShowProgress = [true, false];

    final expectedCryptoCoins = [
      null,
      mockList,
    ];

    when(_mockCryptoRepository.load(1, HomeBloc.limit))
        .thenAnswer((_) => Future.value(mockList));

    _homeBloc.eventReceiver(HomeEventLoad()..isMore = true);

    expectLater(
        _homeSreams.showProgress.get, emitsInOrder(expectedShowProgress));

    expectLater(_homeSreams.cryptoCoins.get, emitsInOrder(expectedCryptoCoins));
  });
}
