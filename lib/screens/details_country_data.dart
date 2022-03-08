import 'package:covid_app/screens/world_statics_data.dart';
import 'package:flutter/material.dart';
class CountryDetails extends StatefulWidget {
  String image, name;
  int totalCases, deaths, totalRecovered,active, critical, todayRecovered, test;
   CountryDetails({
    Key? key,
  required this.name,
    required this.deaths,
    required this.image,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.totalCases,
    required this.test,

  }) : super(key: key);

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [

                  Padding(
                    padding:EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                    child: Card(
                      elevation: 8,
                      child: Column(
                        children: [
                          ReUseable(title: 'Cases', value: widget.totalCases.toString()),
                          ReUseable(title: 'Test', value: widget.test.toString()),
                          ReUseable(title: 'Today\' s recovered', value: widget.todayRecovered.toString()),
                          ReUseable(title: 'Death', value: widget.deaths.toString()),
                          ReUseable(title: 'Critical', value: widget.critical.toString()),
                          ReUseable(title: 'Recovered', value: widget.totalRecovered.toString()),
                          ReUseable(title: 'Active', value: widget.active.toString()),
                          ReUseable(title: 'Cases', value: widget.totalCases.toString()),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Positioned(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(widget.image),
                    ),
                  ),


                ],
              ),
            ],

          ),
        ),
      ),
    );
  }
}

