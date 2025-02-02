import 'package:covidapp/Services/states_services.dart';
import 'package:covidapp/View/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Country extends StatefulWidget {
  const Country({super.key});

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices statesServices = StateServices();
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
              controller: searchController,

              onChanged: (value){
                setState(() {
                  
                });
              },
              decoration: InputDecoration( 
                border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(50.0)
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search With country name'
              ),
            ),
          ),
           Expanded(
             child: FutureBuilder(
              future: statesServices.countriesListApi(),
              builder: (context,AsyncSnapshot<List<dynamic>> snapshot){

                    if(!snapshot.hasData){
                       return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context,index){
                          return Shimmer.fromColors(
                             baseColor: Colors.grey.shade700, highlightColor: Colors.grey.shade100,
                             child: Column( 
                              children: [ 
                                ListTile( 
                                  title: Container(height: 10,width: 89,color: Colors.white,),
                                  subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                  leading: Container(height: 50,width: 50,color: Colors.white,),
                                )
                              ],
                             ),
                             );
                        });
                    }else{
                      return ListView.builder(

                        itemCount: snapshot.data!.length,
                        //itemCount: 1,
                        itemBuilder: (context,index)
                        {
                            String name = snapshot.data![index]['country'];
                      if(searchController.text.isEmpty){
                          return Column(
                        children: [ 
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                name: snapshot.data![index]['country'],
                                image: snapshot.data![index]['countryInfo']['flag'],
                                totalCases: snapshot.data![index]['cases'],
                                totalRecovered: snapshot.data![index]['recovered'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                active: snapshot.data![index]['active'],
                                tests: snapshot.data![index]['tests'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                critical: snapshot.data![index]['critical'],
                              )));
                            },
                            child: ListTile( 
                              title: Text(snapshot.data![index]['country'],),
                              subtitle: Text(snapshot.data![index]['cases'].toString(),),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage( 
                                   snapshot.data![index]['countryInfo']['flag'],
                                )),
                            ),
                          ),
                        ],
                      );
                      }
                      else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                        children: [ 
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                name: snapshot.data![index]['country'],
                                image: snapshot.data![index]['countryInfo']['flag'],
                                totalCases: snapshot.data![index]['cases'],
                                totalRecovered: snapshot.data![index]['recovered'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                active: snapshot.data![index]['active'],
                                tests: snapshot.data![index]['tests'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                critical: snapshot.data![index]['critical'],
                              )));
                            },

                            child: ListTile( 
                              title: Text(snapshot.data![index]['country'],),
                              subtitle: Text(snapshot.data![index]['cases'].toString(),),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage( 
                                   snapshot.data![index]['countryInfo']['flag'],
                                )),
                            ),
                          ),
                        ],
                      );
                      }
                      else{
                        return Container();
                      }
                      
                  });

                    }
                 
                  
              },
              ),
              ),
        ]),
      ),
    );
  }
}