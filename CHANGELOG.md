## [2.0.0] - 01/07/2020 - BREAKING CHANGES

* Unifies Streams and Communication.

## [1.0.3] - 28/06/2020

* update rxdart.
* replace injector with getIt.
* Update example.
* simplifies package.

## [1.0.2] - 11/05/2020

* update rxdart
* add safe set in StreamCreate

## [1.0.1] - 21/02/2020

* export rxdart

## [1.0.0] - 16/02/2020

### Breaking Changes: 
- 'eventReceiver: (context, event, dispatcher)' in Bsev Widget to 'eventReceiver: (event, communication)';
- 'builder: (context, dispatcher, streams)' in Bsev Widget to 'builder: (context,communication)';
- add extension in BaseStreams called 'builder' or use StreamListener to build your view.

## [0.9.3] - 8/02/2020

* add getDependency

## [0.9.2] - 8/02/2020

* fix conflict imports streamBuilder

## [0.9.1] - 27/01/2020

* add registerSingleton

## [0.9.0] - 27/01/2020

* add dispatcherAll
* add methods to inject BloCs and dependencies
* add StreamListener

## [0.8.7] - 26/09/2019

* removes need for custom EventBase

## [0.8.6] - 15/09/2019

* version without context in Bloc

## [0.8.5] - 15/09/2019

* update rxdart
* version with context in Bloc

## [0.8.4] - 14/06/2019

* update example
* remove access context in bloc

## [0.8.3] - 17/06/2019

* add context in eventReceiver

## [0.8.2] - 14/06/2019

* remove need from package provider

## [0.8.1] - 14/06/2019

* Otimizations

## [0.8.0] - 14/06/2019

* Version with Widget

## [0.7.1] - 12/06/2019

* Remove context from view in bloc

## [0.7.0] - 12/06/2019

* Fix bug dispatcher multiple instance same bloc

## [0.6.5] - 15/05/2019

* Remove context from view in bloc

## [0.6.1] - 15/05/2019

* Fixin warns pub

## [0.6.0] - 15/05/2019

* Optimizations BlocViewMixin

## [0.5.5] - 15/05/2019

* Optimizations BlocView

## [0.5.0] - 15/05/2019

* ADD Dispatcher

## [0.1.0] - 15/05/2019

* ADD provider
* Optimizations

## [0.0.5] - 11/05/2019

* ADD injector

## [0.0.1] - TODO: Add release date.

* TODO: Describe initial release.
