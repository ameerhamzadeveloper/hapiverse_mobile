import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
class ViewAd extends StatefulWidget {
  @override
  _ViewAdState createState() => _ViewAdState();
}

class _ViewAdState extends State<ViewAd> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  late TooltipBehavior locationTolTip;
  late TooltipBehavior placementToolBehaviour;
  final List<ChartData> placementData = <ChartData>[
  ChartData('Mobile', 46),
  ChartData('Leptop',27),
  ];
  final List<ChartData> chartData = <ChartData>[
    ChartData('USA', 46),
    ChartData('Great Britain',27),
    ChartData('China',  26),
    ChartData('Russia',  19),
    ChartData('Germany',  17),
    ChartData('Japan', 12),
    ChartData( 'France',10),
    ChartData('Korea',9),
    ChartData('Italy', 8),
    ChartData('Australia',8),
    ChartData('Netherlands', 8),
    ChartData('Hungary',  8),
    ChartData('Brazil',  7),
    ChartData('Spain', 7),
    ChartData('Kenya', 6),
    ChartData('Jamaica',6),
    ChartData('Croatia', 5),
    ChartData('Cuba', 5),
    ChartData('New Zealand',4)
  ];
  @override
  void initState() {
    data = [
      _ChartData('13-18', 234),
      _ChartData('18-25', 15),
      _ChartData('25-40', 30),
      _ChartData('40-60', 6.4),
      _ChartData('60+', 14)
    ];

    _tooltip = TooltipBehavior(enable: true,);
    locationTolTip = TooltipBehavior(enable: true,);
    placementToolBehaviour = TooltipBehavior(enable: true,);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Campaign"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("Yesterday",style: TextStyle(fontFamily: '',color: Colors.blue),)),
                    Text("7 Day",style: TextStyle(fontFamily: ''),),
                    Text("28 Day",style: TextStyle(fontFamily: ''),),
                    Text("Custom",style: TextStyle(fontFamily: ''),),
                  ],
                ),
              ),
              Divider(),
              Text("Performance",style: TextStyle(fontSize: 18),),
              Text("yesterday",style: TextStyle(color: Colors.grey,fontSize: 12),),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("Clicks",style: TextStyle(fontFamily: '',color: Colors.blue),)),
                    Text("Impressions",style: TextStyle(fontFamily: ''),),
                    Text("Reach",style: TextStyle(fontFamily: ''),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: getWidth(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("0",style: TextStyle(fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5,),
                              Text("Click",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: getWidth(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("0",style: TextStyle(fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5,),
                              Text("Click",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: SfCartesianChart(
                    // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                          // Bind data source
                            dataSource:  <SalesData>[
                              SalesData('Jan', 3),
                              SalesData('Feb', 28),
                              SalesData('Mar', 34),
                              SalesData('Apr', 32),
                              SalesData('May', 40)
                            ],
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales
                        )
                      ]
                  )
              ),
              Divider(),
              Text("Demographics",style: TextStyle(fontSize: 18),),
              Text("yesterday",style: TextStyle(color: Colors.grey,fontSize: 12),),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("All",style: TextStyle(fontFamily: ''),),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("Men",style: TextStyle(fontFamily: '',color: Colors.blue),)),
                    Text("Women",style: TextStyle(fontFamily: ''),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: getWidth(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("0",style: TextStyle(fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5,),
                              Text("Click",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: getWidth(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("0",style: TextStyle(fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5,),
                              Text("Click",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                  tooltipBehavior: _tooltip,
                  series: <ChartSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                        dataSource: data,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        name: 'Age',
                        color: Color.fromRGBO(8, 142, 255, 1))
                  ],
              ),
              Divider(),
              Text("Location",style: TextStyle(fontSize: 18),),
              Text("yesterday",style: TextStyle(color: Colors.grey,fontSize: 12),),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("Cities",style: TextStyle(fontFamily: '',color: Colors.blue),)),
                    Text("Countries",style: TextStyle(fontFamily: ''),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: getWidth(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("0",style: TextStyle(fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5,),
                              Text("Click",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: getWidth(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("0",style: TextStyle(fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5,),
                              Text("Click",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: SfCircularChart(
                      series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<ChartData, String>(
                            dataSource: chartData,
                            pointColorMapper:(ChartData data, _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            dataLabelMapper: (ChartData data, _) => data.x,
                            dataLabelSettings: DataLabelSettings(
                              // Renders the data label
                                isVisible: true
                            ),
                        ),
                      ],
                    legend: Legend(
                        isVisible: true,
                        // Border color and border width of legend
                    ),
                    tooltipBehavior: locationTolTip,
                  )
              ),
              Divider(),
              Text("Placement",style: TextStyle(fontSize: 18),),
              Text("yesterday",style: TextStyle(color: Colors.grey,fontSize: 12),),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("Mobile",style: TextStyle(fontFamily: '',color: Colors.blue),)),
                    Text("Desktop",style: TextStyle(fontFamily: ''),),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: getWidth(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("0",style: TextStyle(fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5,),
                              Text("Click",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    width: getWidth(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("0",style: TextStyle(fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5,),
                              Text("Click",style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  child: SfCircularChart(
                    tooltipBehavior: placementToolBehaviour,
                    legend: Legend(isVisible: true),
                      series: <CircularSeries>[
                        // Renders radial bar chart
                        RadialBarSeries<ChartData, String>(
                            dataSource: placementData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            dataLabelSettings: DataLabelSettings(
                              // Renders the data label
                                isVisible: true
                            ),
                        )
                      ]
                  )
              ),
              Divider(),
              Text("Setup",style: TextStyle(fontSize: 18),),
              ListTile(
                leading: Icon(LineIcons.toolbox),
                title: Text("Campagin Name"),
                subtitle: Text("post: this si campagin name"),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: Icon(LineIcons.wallet),
                title: Text("Budget"),
                subtitle: Text("USD 1200"),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: Icon(LineIcons.calendar),
                title: Text("Shcedule"),
                subtitle: Text("4 April 2022 - 5 june 2022"),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: Icon(LineIcons.mobilePhone),
                title: Text("Placement"),
                subtitle: Text("Hapiverse feeds, stories, mobile ,desktop"),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: Icon(LineIcons.users),
                title: Text("Audience"),
                subtitle: Text("men, women and 18+ or 40+"),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: Icon(LineIcons.newspaper),
                title: Text("Post Type"),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}