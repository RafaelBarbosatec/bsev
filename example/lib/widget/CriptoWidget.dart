
import 'package:bsev_demo/repository/cripto_repository/model/Cripto.dart';
import 'package:flutter/material.dart';

import 'package:bsev_demo/detail/Detail.dart';

class CriptoWidget extends StatefulWidget {

  final Cripto item;

  const CriptoWidget({Key key, this.item}) : super(key: key);

  @override
  _CriptoWidgetState createState() => _CriptoWidgetState();
}

class _CriptoWidgetState extends State<CriptoWidget> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<Offset> _animationSlide;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationSlide = Tween(
        begin: Offset(2.0,0.0)
        , end: Offset(0.0,0.0)
    ).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Curves.decelerate
        )
    );
    _controller.forward(from: 0.0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationSlide,
      child: FadeTransition(
        opacity: _controller,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Card(
            child: _getListTile(),
          ),
        ),
      ),
    );
  }

  ListTile _getListTile(){

    return new ListTile(
      leading: _getLeadingWidget(widget.item.name,widget.item.symbol),
      title: _getTittleWidget(widget.item.name),
      subtitle: _getSubtitleWidget(widget.item.priceUsd),
      trailing: _getTrailingWidget(widget.item.percentChange24h),
      onTap: onTapTile(),
    );

  }

  onTapTile(){

  }

  Widget _getLeadingWidget(String currencyName,String symbol){

    return Container(
      width: 50,
      height: 50,
      child: _getImageNetwork(symbol),
    );
  }

  Widget _getImageNetwork(symbol){

    var imageUrl = "https://res.cloudinary.com/dxi90ksom/image/upload/$symbol";

    try{
      return Image.network(imageUrl);
    }catch(e){
      return Text("EMPTY");
    }

  }

  Text _getTittleWidget(String curencyName){
    return Text(
      curencyName,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Text _getSubtitleWidget(String priceUsd){
    return Text('R\$ $priceUsd');
  }

  Widget _getTrailingWidget(String percentChange1h){

    return Column(
      children: <Widget>[
        _getTextPeriodoTrailig(),
        _getTextPorcentTrailing(percentChange1h)],
    );

  }

  Widget _getTextPeriodoTrailig(){

    return Text("24h",
      style: TextStyle(
          fontSize: 8.0
      ),
    );

  }

  Widget _getTextPorcentTrailing(String percentChange1h){

    var percent = double.parse(percentChange1h);

    return Text(
      '$percentChange1h%',
      style: TextStyle(
          color: (percent > 0) ?  Colors.green : Colors.red
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
