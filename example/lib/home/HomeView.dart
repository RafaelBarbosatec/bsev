import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home/HomeBloc.dart';
import 'package:bsev_demo/home/HomeEvents.dart';
import 'package:bsev_demo/home/HomeStreams.dart';
import 'package:bsev_demo/home_second/SecondView.dart';
import 'package:bsev_demo/repository/cripto_repository/model/Cripto.dart';
import 'package:bsev_demo/widget/CriptoWidget.dart';
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
          body: Container(
            child: Stack(
              children: <Widget>[
                _buildListStream(communication),
                _buildProgressStream(communication)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListStream(BlocCommunication<HomeStreams> communication) {
    return RefreshIndicator(
      onRefresh: () {
        return _refresh(communication.dispatcher);
      },
      child: StreamListener<List<Cripto>>(
        stream: communication.streams.cryptoCoins.get,
        builder: (BuildContext context, ValueSnapshot<List<Cripto>> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                if (index >= snapshot.data.length - 1) {
                  _callLoad(true, communication.dispatcher);
                }

                return CryptoWidget(
                  item: snapshot.data[index],
                  onClick: (item) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondView()),
                    );
                  },
                );
              });
        },
      ),
    );
  }

  Widget _buildProgressStream(BlocCommunication<HomeStreams> communication) {
    return StreamListener<bool>(
        stream: communication.streams.showProgress.get,
        builder: (_, ValueSnapshot<bool> snapshot) {
          if (snapshot.data) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        });
  }

  Future<Null> _refresh(dispatcher) async {
    _callLoad(false, dispatcher);
  }

  void _callLoad(bool isMore, dispatcher) {
    if (isMore) {
      dispatcher(HomeEventLoadMore());
    } else {
      dispatcher(HomeEventLoad());
    }
  }

  void showSnackBar(String msg, dispatcher) {
    scaffoldStateKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: 'Try Again',
        onPressed: () {
          _callLoad(false, dispatcher);
        },
      ),
    ));
  }
}
