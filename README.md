[![pub package](https://img.shields.io/pub/v/bsev.svg)](https://pub.dartlang.org/packages/bsev)

# BSEV (BloC,Streams,Events,View)

Set of packages and utilitarian functions that help in the use of BloC pattern with dependency injection.

With bsev you will use the Bloc pattern in a simple, reactive and organized way. Communication between the business logic and the view occurs entirely through two-way streams.

# Usage
To use this plugin, add `bsev` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

We should initially create the class `Communication` and `Events`:

#### Streams

``` dart
import 'package:bsev/bsev.dart';

class HomeCommunication extends CommunicationBase{

  var count = BehaviorSubjectCreate<Int>(initValue: 0);
  //var count = StreamCreate<Int>();
  //var count = PublishSubjectCreate<Int>();
  //var count = ReplaySubjectCreate<Int>();

  @override
  void dispose() {
    count.close();
    super.dispose();
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

class HomeBloc extends BlocBase<HomeCommunication>{

  // If you need to communicate with some instantiated BloC, regardless of whether part of your tree of widgets can use:
  // dispatchToBloc<OtherBloc>(MsgEvent());

  // If you need send event to all BloCs
  // dispatchToAllBlocs(MyEvent());
  
  // If you need to send an event to the view:
  // dispatchView(MyEvent());

  @override
  void initView() {
  // execute something when view is ready.
  }
  
  @override
  void eventReceiver(EventsBase event) {
  
  // called when the Bloc receives an event
  
    if(event is IncrementEvent){
      communication.count.set(streams.count.value + 1)
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
    
    return Bsev<HomeBloc,HomeCommunication>(
      dataToBloc: "any data", //optional initial data to bloc
      eventReceiver: (event, communication){ //optional
        // performs action received by the bloc
      },
      builder: (context,communication){
      
          return Scaffold(
            appBar: AppBar(),
            body: communication.count.builder<int>((value) {
                return Text(value.toString());
            }),
            floatingActionButton: FloatingActionButton(
                onPressed: (){
                  communication.dispatcher(IncrementEvent());
                }
            ),
          );
      
      }
    );
    
  }
  
}

```

As our `Bloc` and our `StreamsBase` will be injected automatically, we should configure it in the Injector in the main of our application:

``` dart
  MyApp(){

    registerBloc<HomeBloc, HomeCommunication>((i) => HomeBloc(i.get()), () => HomeCommunication());

    //Example of the register any things.
    //registerDependency((i) => CryptoRepository(i.get()));

    //Example of the register any things Singleton.
    //registerSingletonDependency((i) => CryptoRepository(i.get()));

    //Example get dependency anywhere
    //var dependency = getDependency<CryptoRepository>();
    
  }
```
Questions about how to use the get_it consult [documentation](https://pub.dev/packages/get_it).

More complex example is found [here](https://github.com/RafaelBarbosatec/bsev/tree/master/example)

# Testing HomeBloc
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  HomeBloc _homeBloc;
  HomeCommunication _homeCommunication;

  setUp(() {
    _homeCommunication = HomeCommunication();
    _homeBloc = HomeBloc()..setCommunication(_homeCommunication);
  });

  tearDown(() {
    _homeBloc?.dispose();
  });
  
  test('initial streams', () {
    expect(_homeCommunication.count.value, 0);
  });
  
  test('increment value', () {
    _homeCommunication.dispatcher(IncrementEvent());
    expect(_homeCommunication.count.value, 1);
  });

  test('increment value 3 times', () {
    _homeCommunication.dispatcher(IncrementEvent());
    _homeCommunication.dispatcher(IncrementEvent());
    _homeCommunication.dispatcher(IncrementEvent());
    expect(_homeCommunication.count.value, 3);
  });
  
}
```

Test example with asynchronous call: [here](https://github.com/RafaelBarbosatec/bsev/blob/develop/example/test/home_bloc_test.dart)


### Used packages

Packages | pub
--------- | ------
rxdart     | [![Pub](https://img.shields.io/pub/v/rxdart.svg)](https://pub.dartlang.org/packages/rxdart)
get_it    | [![Pub](https://img.shields.io/pub/v/get_it.svg)](https://pub.dev/packages/get_it)

### User cases

Apps | 
--------- |
[FlutterNews](https://github.com/RafaelBarbosatec/flutter_news)     | 
[DartLangBr](https://github.com/dartlangbr/dart_lang_br_flutter_app)     | 
[Boleiro](http://boleiroapp.com.br/)     | 

