class Cripto {
  String id;
  String name;
  String symbol;
  String rank;
  String priceUsd;
  String priceBtc;
  String s24hVolumeUsd;
  String marketCapUsd;
  String availableSupply;
  String totalSupply;
  String maxSupply;
  String percentChange1h;
  String percentChange24h;
  String percentChange7d;
  String lastUpdated;
  String priceBrl;
  String s24hVolumeBrl;
  String marketCapBrl;

  Cripto(
      {this.id,
        this.name,
        this.symbol,
        this.rank,
        this.priceUsd,
        this.priceBtc,
        this.s24hVolumeUsd,
        this.marketCapUsd,
        this.availableSupply,
        this.totalSupply,
        this.maxSupply,
        this.percentChange1h,
        this.percentChange24h,
        this.percentChange7d,
        this.lastUpdated,
        this.priceBrl,
        this.s24hVolumeBrl,
        this.marketCapBrl});

  Cripto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    rank = json['rank'];
    priceUsd = json['price_usd'];
    priceBtc = json['price_btc'];
    s24hVolumeUsd = json['24h_volume_usd'];
    marketCapUsd = json['market_cap_usd'];
    availableSupply = json['available_supply'];
    totalSupply = json['total_supply'];
    maxSupply = json['max_supply'];
    percentChange1h = json['percent_change_1h'];
    percentChange24h = json['percent_change_24h'];
    percentChange7d = json['percent_change_7d'];
    lastUpdated = json['last_updated'];
    priceBrl = json['price_brl'];
    s24hVolumeBrl = json['24h_volume_brl'];
    marketCapBrl = json['market_cap_brl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['rank'] = this.rank;
    data['price_usd'] = this.priceUsd;
    data['price_btc'] = this.priceBtc;
    data['24h_volume_usd'] = this.s24hVolumeUsd;
    data['market_cap_usd'] = this.marketCapUsd;
    data['available_supply'] = this.availableSupply;
    data['total_supply'] = this.totalSupply;
    data['max_supply'] = this.maxSupply;
    data['percent_change_1h'] = this.percentChange1h;
    data['percent_change_24h'] = this.percentChange24h;
    data['percent_change_7d'] = this.percentChange7d;
    data['last_updated'] = this.lastUpdated;
    data['price_brl'] = this.priceBrl;
    data['24h_volume_brl'] = this.s24hVolumeBrl;
    data['market_cap_brl'] = this.marketCapBrl;
    return data;
  }
}