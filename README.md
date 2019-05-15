[![pub package](https://img.shields.io/pub/v/bsev.svg)](https://pub.dartlang.org/packages/bsev)

# BSEV (BloC,Streams,Events,View)

Useful to aid in the use of BloC pattern with dependency injection

![fluxo_bsev](https://github.com/RafaelBarbosatec/bsev/blob/master/imgs/fluxo_bsev.png)

# Usage
To use this plugin, add `bsev` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

We should initially create the class that represents our Streams and Events:

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

Now we can create our Bloc, class that will be centralized the business rule.

#### Bloc

``` dart
import 'package:bsev/bsev.dart';

class HomeBloc extends BlocBase<HomeStreams,HomeEvents>{

  @override
  void initView() {
    //If you need to get a Bloc from the top widget hierarchy you can use:
    //ATTENTION: Do not call this method (getBloc) in the block constructor. Only in the initView or after the initView is called at least once.
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

In our bloc we have 2 mandatory methods: initState and eventReceiver:

**initView**: In the first buildView this method is invoked;

**eventReceiver**: Invoked whenever the pad receives an event;

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
  
    //If you need to get a Bloc from the top widget hierarchy you can use:
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

As our Bloc and our StreamsBase will be injected automatically, we should configure it in the Injector in the main of our application:

``` dart
  MyApp(){

    var injector = Injector.appInstance;
    injector.registerDependency((i)=> HomeBloc());
    injector.registerDependency((i)=> HomeStreams());
    
  }
```

Finally we instantiate our HomeView running:

``` dart
HomeView().create()
```

More complex example is found here: [exemplo](https://github.com/RafaelBarbosatec/bsev/tree/master/example)

### Used packages

[rxdart](https://pub.dev/packages/rxdart): ^0.21.0

[injector](https://pub.dev/packages/injector): ^1.0.8

[provider](https://pub.dev/packages/provider): ^2.0.1
