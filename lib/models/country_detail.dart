class CountryDetail {
  final String name;
  final String alpha2Code;
  final String alpha3Code;
  final String callingCodes;
  final String capital;
  final String region;
  final String subregion;
  final int population;
  final double latlng;
  final String demonym;
  final double area;
  final double gini;
  final String timeZones;
  // final List<String> borders;
  final String nativeName;

  CountryDetail({this.name, this.alpha2Code, this.alpha3Code, this.callingCodes, this.capital, this.region, this.subregion, this.population, this.latlng, this.demonym, this.area, this.gini, this.timeZones, this.nativeName});


  factory CountryDetail.fromJson(Map<String, dynamic> json) {
    return CountryDetail(
      name: json['name'],
      // alpha2Code: json['alpha2Code'],
      // alpha3Code: json['alpha3Code'],
      // // callingCodes: json['callingCodes'],
      // capital: json['capital'],
      // region: json['region'],
      // subregion: json['subregion'],
      // population: json['population'],
      // latlng: json['latlng'],
      // demonym: json['demonym'],
      // area: json['area'],
      // gini: json['gini'],
      // timeZones: json['timezones'],
      // // borders: json['borders'],
      // nativeName: json['nativeName'],
    );
  }






}