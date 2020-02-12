[![pub package](https://img.shields.io/pub/v/bsev.svg)](https://pub.dartlang.org/packages/bsev)

# BSEV (BloC,Streams,Events,View)

Set of packages and utilitarian functions that help in the use of BloC pattern with dependency injection.

With bsev you will use the Bloc pattern in a simple, reactive and organized way. Communication between the business logic and the view occurs entirely through two-way streams.

![fluxo_bsev](https://github.com/RafaelBarbosatec/bsev/blob/master/imgs/fluxo_bsev.png)

# Usage
To use this plugin, add `bsev` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

We should initially create the class that represents our `Streams` and `Events`:

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

class IncrementEvent extends EventsBase{}

```

Now we can create our `Bloc`, class that will be centralized the business rule.

#### Bloc

``` dart
import 'package:bsev/bsev.dart';

class HomeBloc extends BlocBase<HomeStreams>{

  //If you need to communicate with some instantiated BloC, regardless of whether part of your tree of widgets can use:
  //dispatchToBloc<OtherBloc>(MsgEvent());
  
  //If you need to send an event to the view:
  //dispatchView(MyEvent());
  
  // If you need send event to all BloCs
  //dispatchAll(MyEvent());

  @override
  void initView() {
  }
  
  @override
  void eventReceiver(EventsBase event) {
  
  // called when the Bloc receives an event
  
    if(event is IncrementEvent){
      streams.count.set(streams.count.value + 1)
    }
    
  }
}

```

In our bloc we have 2 mandatory methods: initState and eventReceiver:

**initView**: In the first buildView this method is invoked;

**eventReceiver**: Invoked whenever the pad receives an event;

#### View

``` dart
import 'package:bsev/bsev.dart';

class HomeView extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    
    return Bsev<HomeBloc,HomeStreams>(
      dataToBloc: "any data", //optional initial data to bloc
      eventReceiver: (event, communication){ //optional
        // performs action received by the bloc
      },
      builder: (context,communication){
      
          return Scaffold(
            appBar: AppBar(),
            body: _buildBody(communication.streams),
            floatingActionButton: FloatingActionButton(
                onPressed: (){
                  communication.dispatcher(IncrementEvent());
                }
            ),
          );
      
      }
    );
    
  }
    
  Widget _buildBody(HomeStreams homeStreams) {

    return streams.count.builder<int>((value) {
        return Text(value.toString());
    });

  }
  
}

```

As our `Bloc` and our `StreamsBase` will be injected automatically, we should configure it in the Injector in the main of our application:

``` dart
  MyApp(){

    registerBloc<HomeBloc, HomeStreams>((i) => HomeBloc(), () => HomeStreams());

    //Example of the register any things.
    //registerDependency((i) => CryptoRepository(i.getDependency()));

    //Example of the register any things Singleton.
    //registerSingleton((i) => CryptoRepository(i.getDependency()));

    //Example get dependency anywhere
    //var dependency = getDependency<CryptoRepository>();
    
  }
```
Questions about how to use the injector consult [documentation](https://pub.dev/packages/injector).

More complex example is found here: [exemplo](https://github.com/RafaelBarbosatec/bsev/tree/master/example)

### Used packages

Packages | pub
--------- | ------
rxdart     | [![Pub](https://img.shields.io/pub/v/rxdart.svg)](https://pub.dartlang.org/packages/rxdart)
injector    | [![Pub](https://img.shields.io/pub/v/injector.svg)](https://pub.dartlang.org/packages/injector)

### User cases

Apps | 
--------- |
[FlutterNews](https://github.com/RafaelBarbosatec/flutter_news)     | 
[DartLangBr](https://github.com/dartlangbr/dart_lang_br_flutter_app)     | 
[Boleiro](http://boleiroapp.com.br/)     | 

