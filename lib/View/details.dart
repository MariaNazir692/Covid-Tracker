import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/View/word_states.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths,totalRecovered,active, critical, todayRecovered, test;

 DetailsScreen({Key? key,
   required this.name,
   required this.image,
   required this.totalCases,
   required this.totalDeaths,
   required this.todayRecovered,
   required this.active,
   required this.critical,
   required this.totalRecovered,
   required this.test
 }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
                      ReuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReuseableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                      ReuseableRow(title: 'Active', value: widget.active.toString()),
                      ReuseableRow(title: 'Tests', value: widget.test.toString())
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
