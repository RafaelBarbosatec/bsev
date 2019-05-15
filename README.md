[![pub package](https://img.shields.io/pub/v/bsev.svg)](https://pub.dartlang.org/packages/bsev)

# BSEV (BloC,Streams,Events,View)

Useful to aid in the use of BloC pattern with dependency injection

![fluxo_bsev](https://github.com/RafaelBarbosatec/bsev/blob/master/imgs/fluxo_bsev.png)

# Usage
To use this plugin, add `bsev` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Devemos inicialmente criar a classe que representa nossos Streams e Events:

#### Streams

``` dart
import 'package:bsev/bsev.dart';

class HomeStreams extends StreamsBase{

  var count = BehaviorSubjectCreate<Int>(initValue: 0);
  //var count = StreamCreate<Int>();
  //var count = PublishSubjectCreate<Int>();
  //var count = ReplaySubjectCreate<Int>();

  @override
  void dispose() {
    count.close();
  }

}

```

#### Events

``` dart
import 'package:bsev/bsev.dart';

class HomeEvents extends EventsBase{}

class IncrementEvent extends HomeEvents{}

```

Agora podemos criar nosso BloC, classe que será centralizada a regra de negócio.

#### Bloc

``` dart
import 'package:bsev/bsev.dart';

class HomeBloc extends BlocBase<HomeStreams,HomeEvents>{

  @override
  void initState() {
    streams = HomeStreams();
  }
  
  @override
  void initView() {
  }
  
  @override
  void eventReceiver(HomeEvents event) {
    if(event is IncrementEvent){
      streams.count.set(streams.count.value + 1)
    }
  }
}

```

Em nosso bloc temos 3 métodos obrigatórios: initState, initView e eventReceiver:

**initState**: Invocado assim que inicia o estado da view;

**initView**: No primeiro buildView esse método é invocado;

**eventReceiver**: invocado tava ves que o bloc recebe um evento;

#### View

``` dart
import 'package:bsev/bsev.dart';

class HomeView extends BlocStatelessView<HomeBloc,HomeStreams,HomeEvents> {

   @override
  void eventReceiver(HomeEvents event) {
    // performs action received by the bloc
  }
  
  @override
  Widget buildView(BuildContext context) {

    return Scaffold(
      key: scaffoldStateKey,
      appBar: AppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            dispatch(IncrementEvent());
          }
      ),
    );
    
    Widget _buildBody() {
    
      return StreamBuilder(
        stream: streams.count.get,
        initialData: 0,
        builder: (_,snapshot){
          
          int count = 0;
          if(snapshot.hasData){
            count = snapshot.data;
          }
          
          return Center(
            child: Text(count)
          )
        }
      );
      
    }
  
}

```

Como nosso Bloc será injetado em nossa view automaticament, devemos configura-ló no Injector na main de nosso projeto:

``` dart
  MyApp(){

    var injector = Injector.appInstance;
    injector.registerDependency((i)=> HomeBloc());
    
  }
```

Por fim instanciamos nossa HomeView executamos:

``` dart
HomeView().create()
```

Exemplo mais complexo é encontrado aqui: [exemplo](https://github.com/RafaelBarbosatec/bsev/tree/master/example)

### Used packages

[rxdart](https://pub.dev/packages/rxdart): ^0.21.0

[injector](https://pub.dev/packages/injector): ^1.0.8
