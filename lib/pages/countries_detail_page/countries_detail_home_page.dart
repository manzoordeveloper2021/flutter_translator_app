import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/providers/country_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/country_item_widget.dart';
import 'widgets/country_list_item_widget.dart';
import 'widgets/country_picker_widget.dart';

class CountriesDetailPage extends StatelessWidget {
  static const String ROUTE_NAME = '/countries_detail_home_page';


  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    return Container(
      height: pageHeight,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Strings.text_translator_page_bg),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          CountryPickerWidget(),
          Expanded(
            flex: 10,
            child: Consumer<CountryDetailsProvider>(
              builder: (context, countryProvider, child) {
                return countryProvider.country == null
                    ? Center(
                        child: Text(
                        'Select Country',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ))
                    : Column(
                        children: [
                          Expanded(
                            child: ListView(children: items(countryProvider)

                                ),
                          ),
                        ],
                      );
              },
            ),
          )
        ],
      ),
    );
  }


  List<Widget> items(CountryDetailsProvider countryProvider) {
    return [
      Container(
        height: 100,
        // width: 100,
        child: SvgPicture.network(
          countryProvider.country.flag,
          semanticsLabel: 'Flag',
          placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator()),
        ),
      ),
      CountryItemWidget(
        text: 'Name',
        value: countryProvider.country.name,
      ),
      CountryItemWidget(
        text: 'Calling code',
        value: countryProvider.country.callingCodes?.first,
      ),
      CountryItemWidget(
        text: 'Capital',
        value: countryProvider.country.capital,
      ),
      CountryItemWidget(
        text: 'Region',
        value: countryProvider.country.region,
      ),
      CountryItemWidget(
        text: 'Alpha2 Code',
        value: countryProvider.country.alpha2Code,
      ),
      CountryItemWidget(
        text: 'Alpha3 Code',
        value: countryProvider.country.alpha3Code,
      ),
      CountryItemWidget(
        text: 'Area',
        value: countryProvider.country.area.toString(),
      ),
      CountryListItemWidget("Domain",
          countryProvider.country.topLevelDomain.map((e) => e).toList()),
      CountryItemWidget(
        text: 'Demonym',
        value: countryProvider.country.demonym,
      ),
      CountryItemWidget(
        text: 'Timezone',
        value: countryProvider.country.timezones?.first,
      ),
      CountryItemWidget(
        text: 'Calling code',
        value: countryProvider.country.callingCodes?.first,
      ),
      CountryItemWidget(
        text: 'Numeric Code',
        value: countryProvider.country.numericCode,
      ),
      CountryItemWidget(
        text: 'CIOS',
        value: countryProvider.country.cioc,
      ),
      CountryListItemWidget("Currency Name",
          countryProvider.country.currencies?.map((x) => x?.name)?.toList()),
      CountryListItemWidget("Currency code",
          countryProvider.country.currencies?.map((x) => x?.code)?.toList()),
      CountryListItemWidget("Currency Symbol",
          countryProvider.country.currencies?.map((x) => x?.symbol)?.toList()),
      CountryListItemWidget("Lat Long",
          countryProvider.country.latlng.map((e) => e.toString()).toList()),
      CountryListItemWidget("Language",
          countryProvider.country.languages.map((e) => e.name).toList()),
      CountryListItemWidget("Lang Naiive Name",
          countryProvider.country.languages.map((e) => e.nativeName).toList()),
      CountryListItemWidget("Lang iso6391 Code",
          countryProvider.country.languages.map((e) => e.iso6391).toList()),
      CountryListItemWidget("Lang iso6392 Code",
          countryProvider.country.languages.map((e) => e.iso6392).toList()),
      CountryListItemWidget("Regional Blocs",
          countryProvider.country.regionalBlocs.map((e) => e.name).toList()),
      CountryListItemWidget("Regional Blocs Aacronym",
          countryProvider.country.regionalBlocs.map((e) => e.acronym).toList()),
      CountryListItemWidget("Borders", countryProvider.country.borders),
      CountryListItemWidget(
          "Alt Spellings", countryProvider.country.altSpellings),
      CountryListItemWidget(
          "Name Translations",
          countryProvider.country.translations
              .toJson()
              .cast<String, String>()
              .values
              .toList()),
    ];
  }


}
