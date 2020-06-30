import 'package:bsev/bsev.dart';
import 'package:bsev_demo/repository/pokemon/model/pokemon.dart';
import 'package:bsev_demo/screens/home/bloc/bloc.dart';
import 'package:bsev_demo/screens/home/widgets/pripto_widget.dart';
import 'package:bsev_demo/screens/second/second_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Bsev<HomeBloc, HomeStreams>(
      eventReceiver: (event, communication) {
        if (event is HomeEventShowError) {
          showSnackBar(event.msg, communication.dispatcher);
        }
      },
      builder: (context, communication) {
        return Scaffold(
          key: scaffoldStateKey,
          appBar: AppBar(),
          body: Stack(
            children: <Widget>[
              _buildListStream(communication),
              _buildProgressStream(communication.streams)
            ],
          ),
        );
      },
    );
  }

  Widget _buildListStream(BlocCommunication<HomeStreams> communication) {
    return RefreshIndicator(
      onRefresh: () {
        communication.dispatcher(HomeEventLoad());
        return Future.value();
      },
      child: communication.streams.pokemonList.builder<List<Pokemon>>((data) {
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (index >= data.length - 1) {
                communication.dispatcher(HomeEventLoad()..isMore = true);
              }

              return PokemonWidget(
                item: data[index],
                onClick: (item) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondView()),
                  );
                },
              );
            });
      }),
    );
  }

  Widget _buildProgressStream(HomeStreams streams) {
    return streams.showProgress.builder<bool>((data) {
      if (data) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }

  void showSnackBar(String msg, dispatcher) {
    scaffoldStateKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: 'Try Again',
        onPressed: () {
          dispatcher(HomeEventLoad());
        },
      ),
    ));
  }
}