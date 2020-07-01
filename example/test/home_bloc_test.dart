import 'package:bsev_demo/repository/pokemon/model/pokemon.dart';
import 'package:bsev_demo/repository/pokemon/pokemon_repository.dart';
import 'package:bsev_demo/screens/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  MockPokemonRepository _mockCryptoRepository;

  HomeBloc _homeBloc;
  HomeCommunication _homeCommunication;

  setUp(() {
    _mockCryptoRepository = MockPokemonRepository();
    _homeCommunication = HomeCommunication();
    _homeBloc = HomeBloc(_mockCryptoRepository)
      ..setCommunication(_homeCommunication);
  });

  tearDown(() {
    _homeBloc?.dispose();
  });

  test('initial streams', () {
    expect(_homeCommunication.pokemonList.value, null);
    expect(_homeCommunication.showProgress.value, false);
  });

  test('initial bloc loadCripto', () {
    List<Pokemon> mockList = [
      Pokemon(),
      Pokemon(),
      Pokemon(),
      Pokemon(),
      Pokemon()
    ];

    final expectedShowProgress = [
      true,
      false,
    ];

    final expectedPokemonList = [
      null,
      mockList,
    ];

    when(
      _mockCryptoRepository.getPokemons(page: 0, limit: HomeBloc.limit),
    ).thenAnswer((_) => Future.value(mockList));

    _homeBloc.initView();

    expectLater(
      _homeCommunication.showProgress.get,
      emitsInOrder(expectedShowProgress),
    );

    expectLater(
      _homeCommunication.pokemonList.get,
      emitsInOrder(expectedPokemonList),
    );
  });

  test('loadMore Pokemon', () {
    List<Pokemon> mockList = [
      Pokemon(),
      Pokemon(),
      Pokemon(),
      Pokemon(),
      Pokemon()
    ];

    final expectedShowProgress = [true, false];

    final expectedPokemonList = [
      null,
      mockList,
    ];

    when(
      _mockCryptoRepository.getPokemons(page: 1, limit: HomeBloc.limit),
    ).thenAnswer((_) => Future.value(mockList));

    _homeCommunication.dispatcher(HomeEventLoad(isMore: true));

    expectLater(
      _homeCommunication.showProgress.get,
      emitsInOrder(expectedShowProgress),
    );

    expectLater(
      _homeCommunication.pokemonList.get,
      emitsInOrder(expectedPokemonList),
    );
  });
}
