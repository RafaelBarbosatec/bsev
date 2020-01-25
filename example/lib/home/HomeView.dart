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
      eventReceiver: (context, event, dispatcher) {
        if (event is HomeEventShowError) {
          showSnackBar(event.msg, dispatcher);
        }
      },
      builder: (context, dispatcher, HomeStreams streams) {
        return Scaffold(
          key: scaffoldStateKey,
          appBar: AppBar(),
          body: Container(
            child: Stack(
              children: <Widget>[
                _buildListStream(streams, dispatcher),
                _buildProgressStream(streams)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListStream(HomeStreams streams, dispatcher) {
    return RefreshIndicator(
      onRefresh: () {
        return _refresh(dispatcher);
      },
      child: StreamListener<List<Cripto>>(
        stream: streams.cryptoCoins.get,
        builder: (BuildContext context, ValueSnapshot<List<Cripto>> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                if (index >= snapshot.data.length - 1) {
                  _callLoad(true, dispatcher);
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

  Widget _buildProgressStream(HomeStreams streams) {
    return StreamListener<bool>(
        stream: streams.showProgress.get,
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
