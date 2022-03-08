import 'package:covid_app/Models/world_statics_modal.dart';
import 'package:covid_app/Services/world_statics_api.dart';
import 'package:covid_app/screens/country_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStaticsData extends StatefulWidget {
  const WorldStaticsData({Key? key}) : super(key: key);

  @override
  _WorldStaticsDataState createState() => _WorldStaticsDataState();
}

class _WorldStaticsDataState extends State<WorldStaticsData>
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
// obj of the world statics class in order to call its api fn
  WorldStatics objworldStatics = WorldStatics();
  //list for pie chart
  final colorlist = <Color>[
    const Color.fromARGB(237, 129, 17, 12),
    Colors.amber,
    Colors.red,
    const Color.fromARGB(255, 187, 0, 0),
    //Colors.deepOrange
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('World Statistic',style: TextStyle(color: Colors.white ),), ),*/
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              FutureBuilder(
                  //we create an object of world statics api and than call its fn in future to get data
                  future: objworldStatics.getworldStatics(),
                  builder:
                      //we are getting data from model, so we have to pass type of data in snapshot argument
                      (context, AsyncSnapshot<WorldStaticsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.red,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'Total':
                                  double.parse(snapshot.data!.cases.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered.toString()),
                              'Death': double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                              showChartValueBackground: false,
                            ),
                            chartType: ChartType.ring,
                            chartRadius: MediaQuery.of(context).size.width / 3,
                            colorList: colorlist,
                            animationDuration: const Duration(seconds: 4),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .01),
                            child: Card(
                              elevation: 10,
                              child: Column(
                                children: [
                                  ReUseable(
                                      title: 'Total Cases',
                                      value: snapshot.data!.cases.toString()),
                                  ReUseable(
                                      title: 'Total Deaths',
                                      value: snapshot.data!.deaths.toString()),
                                  ReUseable(
                                      title: 'Total Recovered',
                                      value: snapshot.data!.recovered.toString()),
                                  ReUseable(
                                      title: 'Today\'s Cases',
                                      value:
                                          snapshot.data!.todayCases.toString()),
                                  ReUseable(
                                      title: 'Today\'s Deaths',
                                      value:
                                          snapshot.data!.todayDeaths.toString()),
                                  ReUseable(
                                      title: 'Critical',
                                      value: snapshot.data!.critical.toString()),
                                ],

                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountriesList()));
                            },
                            child: Container(
                              child: const Center(
                                child: Text(
                                  'Track Countries',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUseable extends StatelessWidget {
  String title, value;

  ReUseable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
         // const Divider(),
        ],
      ),
    );
  }
}
