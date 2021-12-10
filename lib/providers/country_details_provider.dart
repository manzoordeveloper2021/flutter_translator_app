import 'package:country_provider/country_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:office_flutter_translate_app/models/country_detail.dart';

class CountryDetailsProvider extends ChangeNotifier {

  Country _country;

  Country get country => _country;



  getCountry(String name) async {
    _country =
    await CountryProvider.getCountryByFullname(name,
        filter: CountryFilter());
    notifyListeners();


    print('Country name : ${country.name}');
    print('Country Details : ${country.numericCode}');
    print('Country capital : ${country.capital}');
    print('Country Details : ${country.region}');
  }



  // Dio dio = Dio();
  //   List<CountryDetail> countriesDetails;
  //
  //  getCountryDetails(String countryName) async {
  //    countriesDetails = [];
  //   String url = 'https://restcountries.eu/rest/v2/name/$countryName';
  //   final Response response = await dio.get(url);
  //   if (response.statusCode == 200) {
  //     final List jsonArray = response.data;
  //     jsonArray.forEach((element) {
  //       countriesDetails.add(CountryDetail.fromJson(element));
  //     });
  //
  //     // print('Countries Names: ${cou}')
  //   }
  //
  //
  //   // return countriesDetails;
  // }
  //
  //
  // List<Country> _countriesList = [];
  //
  // List<Country> get countriesList => _countriesList;


  //
  // getCountries() {
  //   countries.forEach((element) {
  //
  //     print('Element: $element');
  //     _countriesList.add(Country.fromJson(element));
  //
  //   });
  //
  // }


  List<Map<String, String>> countries = [
    {
      "Name": "Albania",
      "Code": "+355"
    },
    {
      "Name": "Argentina",
      "Code": "+54"
    },
    {
      "Name": "Armenia",
      "Code": "+374"
    },
    {
      "Name": "Australia",
      "Code": "+61"
    },
    {
      "Name": "Austria",
      "Code": "+43"
    },
    {
      "Name": "Azerbaijan",
      "Code": "+994"
    },
    {
      "Name": "Belarus",
      "Code": "+375"
    },
    {
      "Name": "Belgium",
      "Code": "+32"
    },
    {
      "Name": "Bosnia Herzegovina",
      "Code": "+387"
    },
    {
      "Name": "Brazil",
      "Code": "+55"
    },
    {
      "Name": "Bulgaria",
      "Code": "+359"
    },
    {
      "Name": "Canada",
      "Code": "+1"
    },
    {
      "Name": "Croatia",
      "Code": "+385"
    },
    {
      "Name": "Cuba",
      "Code": "+53"
    },
    {
      "Name": "Cyprus",
      "Code": "+357"
    },
    {
      "Name": "Czech Republic",
      "Code": "+420"
    },
    {
      "Name": "Denmark",
      "Code": "+45"
    },
    {
      "Name": "Estonia",
      "Code": "+372"
    },
    {
      "Name": "Finland",
      "Code": "+358"
    },
    {
      "Name": "France",
      "Code": "+33"
    },
    {
      "Name": "Georgia",
      "Code": "+995"
    },
    {
      "Name": "Germany",
      "Code": "+49"
    },
    {
      "Name": "Greece",
      "Code": "+30"
    },
    {
      "Name": "Greenland",
      "Code": "+299"
    },
    {
      "Name": "Hungary",
      "Code": "+36"
    },
    {
      "Name": "Iceland",
      "Code": "+354"
    },
    {
      "Name": "Ireland",
      "Code": "+353"
    },
    {
      "Name": "Italy",
      "Code": "+39"
    },
    {
      "Name": "Japan",
      "Code": "+81"
    },
    {
      "Name": "Kazakhstan",
      "Code": "+7"
    },

    {
      "Name": "Kosovo",
      "Code": "+383"
    },
    {
      "Name": "Kyrgyzstan",
      "Code": "+996"
    },
    {
      "Name": "Latvia",
      "Code": "+371"
    },
    {
      "Name": "Liechtenstein",
      "Code": "+423"
    },
    {
      "Name": "Lithuania",
      "Code": "+370"
    },
    {
      "Name": "Luxembourg",
      "Code": "+352"
    },
    {
      "Name": "Macedonia",
      "Code": "+389"
    },
    {
      "Name": "Mexico",
      "Code": "+52"
    },
    {
      "Name": "Moldova",
      "Code": "+373"
    },
    {
      "Name": "Monaco",
      "Code": "+377"
    },
    {
      "Name": "Montenegro",
      "Code": "+382"
    },
    {
      "Name": "Netherlands",
      "Code": "+31"
    },
    {
      "Name": "New Zealand",
      "Code": "+64"
    },
    {
      "Name": "Nicaragua",
      "Code": "+505"
    },

    {
      "Name": "Norway",
      "Code": "+47"
    },
    {
      "Name": "Philippines",
      "Code": "+63"
    },
    {
      "Name": "Poland",
      "Code": "+48"
    },
    {
      "Name": "Portugal",
      "Code": "+351"
    },
    {
      "Name": "Romania",
      "Code": "+40"
    },
    {
      "Name": "Russia",
      "Code": "+7"
    },
    {
      "Name": "Scotland",
      "Code": "+44"
    },
    {
      "Name": "Serbia",
      "Code": "+381"
    },
    {
      "Name": "Slovakia",
      "Code": "+421"
    },
    {
      "Name": "Slovenia",
      "Code": "+386"
    },
    {
      "Name": "South Korea",
      "Code": "+82"
    },
    {
      "Name": "Spain",
      "Code": "+34"
    },
    {
      "Name": "Sweden",
      "Code": "+46"
    },
    {
      "Name": "Switzerland",
      "Code": "+41"
    },
    {
      "Name": "Thailand",
      "Code": "+66"
    },
    {
      "Name": "Turkey",
      "Code": "+90"
    },
    {
      "Name": "Ukraine",
      "Code": "+380"
    },
    {
      "Name": "United Kingdom",
      "Code": "+44"
    },
    {
      "Name": "United States",
      "Code": "+1"
    },
    {
      "Name": "Venezuela",
      "Code": "+58"
    }
  ];
}
