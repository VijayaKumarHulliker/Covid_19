import 'package:covidapp/Model/world_states_model.dart';
import 'package:covidapp/Services/states_services.dart';
import 'package:covidapp/View/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{
 
   late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this)..repeat();
 

  @override
  void dispose() {
    
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff2aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
     StateServices statesServices = StateServices();
    return Scaffold(  
     
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(15),
      child: Column(children: [ 
        SizedBox(height: MediaQuery.of(context).size.height*.01,),

        FutureBuilder(
          future: statesServices.fetchWorldStatesRecords(),
          builder:(context,AsyncSnapshot<WorldStatesModal> snapshot){
            if(!snapshot.hasData){
              return Expanded(
                flex: 1,
                child: SpinKitCircle(color: Colors.white,
                size: 50,
                controller: _controller,
                ),
                
              );
            }else{
              return Column( 
                children: [ 
        PieChart(
          dataMap: {

          "Total":double.parse(snapshot.data!.cases!.toString()),
          "Recovered":double.parse(snapshot.data!.recovered.toString()),
          "Deaths":double.parse(snapshot.data!.deaths.toString()),
        },
        chartValuesOptions: const ChartValuesOptions(
          showChartValuesInPercentage: true
        ),
        legendOptions: const LegendOptions(
          legendPosition: LegendPosition.left
        ),
        chartRadius: MediaQuery.of(context).size.width/3.2,
        animationDuration: const Duration(milliseconds: 1200),
        chartType: ChartType.ring,
        colorList: colorlist,
        
        
        ),

        Padding(
          padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
          child: Card( child: Column( 
            children: [ 
              reusableroe(title: 'Total', value: snapshot.data!.cases!.toString()), 
              reusableroe(title: 'Deaths', value: snapshot.data!.deaths.toString()), 
              reusableroe(title: 'Recovered', value: snapshot.data!.recovered.toString()), 
              reusableroe(title: 'Active', value: snapshot.data!.active!.toString()), 
              reusableroe(title: 'Critical', value: snapshot.data!.critical.toString()),
              reusableroe(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()), 
              reusableroe(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()), 

           
            ],
            

          ),
          
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Country()));
          },
          child: Container( 
            height: 50,
          
            decoration: BoxDecoration( 
              color:const  Color(0xff1aa260),
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Center(
              child: Text("Track Countries"),
            ),
          ),
        )
      
      
                ],
              );
            }
        },  ),
        
        
      ]),
      )),
    );
  }
}

class reusableroe extends StatelessWidget {
  String title,value;
  reusableroe({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column( 
        children: [ 
          Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
                Text(title),
                Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}