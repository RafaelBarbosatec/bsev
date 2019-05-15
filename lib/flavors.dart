enum Flavor { DEBUG, HOMOLOG, PROD }

class Flavors {
  static final Flavors _singleton = Flavors._internal();
  static Flavor _flavor;

  factory Flavors() {
    return _singleton;
  }

  Flavors._internal();

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  Flavor getFlavor() => _flavor;
}
