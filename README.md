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
  void initView() {
    //Caso precise obter um Bloc da hierarquia superior de widget você pode usar:
    //var otherBloc = getBloc<Bloc>();
    //otherBloc.dispatch(Event());

  }
  
  @override
  void eventReceiver(EventsBase event) {
    if(event is IncrementEvent){
      streams.count.set(streams.count.value + 1)
    }
  }
}

```

Em nosso bloc temos 2 métodos obrigatórios: initState e eventReceiver:

**initView**: No primeiro buildView esse método é invocado;

**eventReceiver**: invocado tava ves que o bloc recebe um evento;

#### View

``` dart
import 'package:bsev/bsev.dart';

class HomeView extends BlocStatelessView<HomeBloc,HomeStreams> {

   @override
  void eventReceiver(HomeEvents event) {
    // performs action received by the bloc
  }
  
  @override
  Widget buildView(BuildContext context) {
  
    //Caso precise obter um Bloc da hierarquia superior de widget você pode usar:
    //var otherBloc = getBloc<Bloc>(context);
    //otherBloc.dispatch(Event());

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

Como nosso Bloc e nosso StreamsBase será injetado em nossa view automaticamente, devemos configura-ló no Injector na main de nosso projeto:

``` dart
  MyApp(){

    var injector = Injector.appInstance;
    injector.registerDependency((i)=> HomeBloc());
    injector.registerDependency((i)=> HomeStreams());
    
  }
```

Por fim instanciamos nossa HomeView executando:

``` dart
HomeView().create()
```

Exemplo mais complexo é encontrado aqui: [exemplo](https://github.com/RafaelBarbosatec/bsev/tree/master/example)

### Used packages

[rxdart](https://pub.dev/packages/rxdart): ^0.21.0

[injector](https://pub.dev/packages/injector): ^1.0.8

[provider](https://pub.dev/packages/provider): ^2.0.1
