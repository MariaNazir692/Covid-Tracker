import 'package:flutter/material.dart';
import 'package:flutter_covid_tracker_app/Services/StatesServices.dart';
import 'package:flutter_covid_tracker_app/View/details.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: "Search for country",
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: statesServices.fetchcountriesListRecord(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                                children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              )
                            ]),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];

                          if (_searchController.text.isEmpty) {
                            return Column(children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          test: snapshot.data![index]['tests'])
                                  )
                                  );
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                  ),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              )
                            ]);
                          } else if (name .toLowerCase().contains(_searchController.text.toLowerCase())) {
                            return Column(
                                children: [
                              InkWell(
                                onTap:(){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          test: snapshot.data![index]['tests'])
                                  )
                                  );
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                    snapshot.data![index]['cases'].toString(),
                                  ),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag'])),
                                ),
                              )
                            ]);
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
