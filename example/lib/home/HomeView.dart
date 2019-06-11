import 'package:bsev/bsev.dart';
import 'package:bsev_demo/home/HomeBloc.dart';
import 'package:bsev_demo/home/HomeEvents.dart';
import 'package:bsev_demo/home/HomeStreams.dart';
import 'package:bsev_demo/repository/cripto_repository/model/Cripto.dart';
import 'package:bsev_demo/widget/CriptoWidget.dart';
import 'package:flutter/material.dart';

class HomeView extends BlocStatelessView<HomeBloc,HomeStreams> {

  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void eventReceiver(EventsBase event) {
    if(event is ShowError){
      showSnackBar(event.data);
    }
  }

  @override
  Widget buildView(BuildContext context, HomeStreams streams) {

    return Scaffold(
      key: scaffoldStateKey,
      appBar: AppBar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            _buildListStream(streams),
            _buildProgressStream(streams)
          ],
        ),
      ),
    );

  }

  Widget _buildListStream(HomeStreams streams) {
    return StreamBuilder(
        stream: streams.criptos.get,
        builder: (_,snapshot){

          List<Cripto> data = snapshot.data;
          var length = data == null ? 0 : data.length;

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
                itemCount: length,
                itemBuilder: (_,index){

                  if(index >= data.length - 4){
                    _callLoad(true);
                  }
                  return InkWell(
                    onTap: (){
                      dispatch(EventTest());
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

  Future<Null> _refresh() async {
    _callLoad(false);
  }

  void _callLoad(bool isMore) {

    if(isMore){
      dispatch(HomeLoadMore());
    }else{
      dispatch(HomeLoad());
    }

  }

  void showSnackBar(String msg) {
    scaffoldStateKey.currentState.showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Try Again',
            onPressed: () {
              _callLoad(false);
            },
          ),
        )
    );
  }

}
