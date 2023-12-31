import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/Model/WorldStatesModel.dart';
import 'package:flutter_covid_tracker_app/Services/StatesServices.dart';
import 'package:flutter_covid_tracker_app/View/countries_list.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldsStatesScreen extends StatefulWidget {
  const WorldsStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldsStatesScreen> createState() => _WorldsStatesScreenState();
}

class _WorldsStatesScreenState extends State<WorldsStatesScreen> with TickerProviderStateMixin{

  late final AnimationController _controller =
  AnimationController(duration: Duration(seconds: 3), vsync: this)
    ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList=<Color>[
    const  Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
               FutureBuilder(
                   future: statesServices.fetchWorldStatesRecord(),
                   builder: (context, AsyncSnapshot<WorldStatesModel>snapshot){
                 if(!snapshot.hasData){
                   return Expanded(
                       flex:1,
                       child: SpinKitFadingCircle(
                         size: 50,
                         controller: _controller,
                         color: Colors.white,
                       )
                   );
                 }else{
                   return Column(
                     children: [
                       PieChart(
                         dataMap: {
                           'Total': double.parse(snapshot.data!.cases.toString()),
                           'Recovered': double.parse(snapshot.data!.recovered.toString()),
                           'Death':double.parse(snapshot.data!.deaths.toString())
                         } ,
                         chartValuesOptions: const ChartValuesOptions(
                           showChartValuesInPercentage: true
                         ),
                         animationDuration: Duration(milliseconds: 1200),
                         chartType: ChartType.ring,
                         colorList: colorList,
                         chartRadius: MediaQuery.of(context).size.width/3.2,
                         legendOptions: LegendOptions(
                             legendPosition: LegendPosition.left
                         ),

                       ),
                       Padding(
                         padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                         child: Card(
                           child: Column(
                             children: [
                               ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString(),),
                               ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                               ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                               ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                               ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                               ReuseableRow(title: 'Today Death', value: snapshot.data!.todayDeaths.toString()),
                               ReuseableRow(title: 'Today Recover', value: snapshot.data!.todayRecovered.toString()),
                             ],
                           ),
                         ),
                       ),
                       Container(
                         width: double.infinity,
                         height: 55,
                         child: ElevatedButton(onPressed: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                         },
                           child: Text('Track Country'),
                           style: ElevatedButton.styleFrom(
                               shape: StadiumBorder(),
                               backgroundColor: Colors.green
                           ),),
                       )
                     ],
                   );
                 }
               }),
            ],
          ),
        ),
      ) ,
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title,value;
   ReuseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)

            ],
          )
        ],
      ),
    );
  }
}
