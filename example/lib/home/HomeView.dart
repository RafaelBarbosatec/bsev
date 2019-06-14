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

    return Bsev<HomeBloc,HomeStreams>(
      dataToBloc: "any data",
      eventReceiver: (event,dispather){

        if(event is ShowError){
          showSnackBar(event.data,dispather);
        }

      },
      builder: (context,dispather,streams){

        return Scaffold(
          key: scaffoldStateKey,
          appBar: AppBar(),
          body: Container(
            child: Stack(
              children: <Widget>[
                _buildListStream(streams,dispather),
                _buildProgressStream(streams)
              ],
            ),
          ),
        );

      },
    );
  }

  Widget _buildListStream(HomeStreams streams,dispather) {
    return StreamBuilder(
        stream: streams.criptos.get,
        builder: (_,snapshot){

          List<Cripto> data = snapshot.data;
          var length = data == null ? 0 : data.length;

          return RefreshIndicator(
            onRefresh: (){
              return _refresh(dispather);
            },
            child: ListView.builder(
                itemCount: length,
                itemBuilder: (context,index){

                  if(index >= data.length - 4){
                    _callLoad(true,dispather);
                  }
                  return InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondView()),
                        );
                      },
                      child: CriptoWidget(item: data[index])
                  );

                }
            ),
          );
        }
    );
  }

  Widget _buildProgressStream(HomeStreams streams) {
    return StreamBuilder(
        stream: streams.showProgress.get,
        builder: (_,snapshot){
          if(snapshot.hasData && snapshot.data){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Container();
          }
        }
    );
  }

  Future<Null> _refresh(dispather) async {
    _callLoad(false,dispather);
  }

  void _callLoad(bool isMore,dispather) {

    if(isMore){
      dispather(HomeLoadMore());
    }else{
      dispather(HomeLoad());
    }

  }

  void showSnackBar(String msg,dispather) {
    scaffoldStateKey.currentState.showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Try Again',
            onPressed: () {
              _callLoad(false,dispather);
            },
          ),
        )
    );
  }

}