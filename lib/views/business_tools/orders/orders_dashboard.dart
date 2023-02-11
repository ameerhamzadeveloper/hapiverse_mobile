import 'package:flutter/material.dart';
import 'package:happiverse/views/business_tools/orders/canceled.dart';
import '../../../views/business_tools/orders/delivered.dart';
import '../../../views/business_tools/orders/in_que.dart';
import '../../../views/business_tools/orders/shipped.dart';
class OrdersDashboard extends StatefulWidget {
  @override
  _OrdersDashboardState createState() => _OrdersDashboardState();
}

class _OrdersDashboardState extends State<OrdersDashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Orders Dashboard"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("In Que"),),
              Tab(child: Text("Shipped"),),
              Tab(child: Text("Delivered"),),
              Tab(child: Text("Canceled"),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InQueOrders(),
            ShippedOrders(),
            DeliveredOrders(),
            CanceledOrders()
          ],
        ),
      ),
    );
  }
}
