import 'package:covidapp/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class DetailScreen extends StatefulWidget {
  String name;
  String image;

  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,tests;

   DetailScreen({
    
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.tests,
    
    });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height* .067),
                    child: Card( 
                      
                      
                      child: SingleChildScrollView(
                        child: Column( 
                          children: [ 
                            SizedBox(height: MediaQuery.of(context).size.height*.065,),
                            reusableroe(title: 'Cases', value: widget.totalCases.toString()),
                            reusableroe(title: 'Active Cases', value: widget.active.toString()),
                            
                            reusableroe(title: 'Recovered', value: widget.totalRecovered.toString()),
                           
                            reusableroe(title: 'Death', value: widget.totalDeaths.toString()),
                            reusableroe(title: 'Critical', value: widget.critical.toString()),
                            reusableroe(title: 'Today Recovered', value: widget.totalRecovered.toString()),
                            
                                         
                        
                                            
                          ],
                        ),
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