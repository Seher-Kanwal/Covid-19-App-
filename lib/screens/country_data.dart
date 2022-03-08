import 'package:covid_app/Services/coutry_data_api.dart';
import 'package:covid_app/screens/details_country_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      //we have to write late in order to use this
      duration: const Duration(seconds: 5),
      vsync: this)
    ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  TextEditingController searchCountry = TextEditingController();
  CountryData countrydata = CountryData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Countries Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                //in order to get data from search field, we have to use onchanged property
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchCountry,
                decoration: InputDecoration(
                  hintText: 'Enter Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  //suffixIcon: Icons.search,
                  suffixIcon: searchCountry.text.isEmpty ? const Icon(Icons.search) :
                  GestureDetector(
                      onTap: (){
                        searchCountry.text = "" ;
                        setState(() {
                        });
                      },
                      child: const Icon(Icons.clear)),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: countrydata.getCountryData(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.grey,
                                      ),
                                      title: Container(
                                        width: 100,
                                        height: 8.0,
                                        color: Colors.grey,
                                      ),
                                      subtitle: Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade800);
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String country = snapshot.data![index]['country'];
                            if (searchCountry.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CountryDetails(
                                                    name: snapshot.data![index]
                                                    ['country'],
                                                    deaths: snapshot
                                                        .data![index]['deaths'],
                                                    image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    test: snapshot.data![index]
                                                    ['tests'],
                                                    todayRecovered:
                                                    snapshot.data![index]
                                                    ['todayRecovered'],
                                                    critical:
                                                    snapshot.data![index]
                                                    ['critical'],
                                                    totalRecovered:
                                                    snapshot.data![index]
                                                    ['recovered'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                  )));
                                    },
                                    child: ListTile(
                                        //we don't create model, so we're simply writing parameters
                                        //data is actually a list so we're passing index
                                        leading: Image(
                                            width: 50,
                                            height: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]['countryInfo']
                                                    ['flag'])),
                                        title:
                                            Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString())),
                                  ),
                                ],
                              );
                              //we create a search variable and compare it with text in the list to show specific country
                            } else if (country.toLowerCase().contains(searchCountry.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                   onTap: (){
                                     Navigator.push(
                                         context,
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 CountryDetails(
                                                   name: snapshot.data![index]
                                                   ['country'],
                                                   deaths: snapshot
                                                       .data![index]['deaths'],
                                                   image: snapshot.data![index]
                                                   ['countryInfo']['flag'],
                                                   active: snapshot
                                                       .data![index]['active'],
                                                   test: snapshot.data![index]
                                                   ['tests'],
                                                   todayRecovered:
                                                   snapshot.data![index]
                                                   ['todayRecovered'],
                                                   critical:
                                                   snapshot.data![index]
                                                   ['critical'],
                                                   totalRecovered:
                                                   snapshot.data![index]
                                                   ['recovered'],
                                                   totalCases: snapshot
                                                       .data![index]['cases'],
                                                 )));
                                   },
                                    child: ListTile(
                                        //we don't create model, so we're simply writing parameters
                                        //data is actually a list so we're passing index
                                        leading: Image(
                                            width: 50,
                                            height: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]['countryInfo']
                                                    ['flag'])),
                                        title:
                                            Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString())),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
