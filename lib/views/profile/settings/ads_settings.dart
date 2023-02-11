import 'package:flutter/material.dart';
import '../../../views/components/universal_card.dart';

import '../../../utils/constants.dart';
class AdsSettings extends StatefulWidget {
  const AdsSettings({Key? key}) : super(key: key);

  @override
  _AdsSettingsState createState() => _AdsSettingsState();
}

class _AdsSettingsState extends State<AdsSettings> {
  List<AdsCategory> categoryList = [
    AdsCategory(name: "Arts & Entertainment", status: false),
    AdsCategory(name: "Autos & Vehicles", status: false),
    AdsCategory(name: "Beauty & Personal Care", status: false),
    AdsCategory(name: "Business & Industrial", status: false),
    AdsCategory(name: "Computers & Consumer Electronics", status: false),
    AdsCategory(name: "Dining & Nightlife", status: false),
    AdsCategory(name: "Family & Community", status: false),
    AdsCategory(name: "Finance", status: false),
    AdsCategory(name: "Food & Groceries", status: false),
    AdsCategory(name: "Hobbies, Games & Leisure", status: false),
    AdsCategory(name: "Home & Garden", status: false),
    AdsCategory(name: "Internet & Telecom", status: false),
    AdsCategory(name: "Jobs & Education", status: false),
    AdsCategory(name: "News, Books & Publications", status: false),
    AdsCategory(name: "Occasions & Gifts", status: false),
    AdsCategory(name: "Property", status: false),
    AdsCategory(name: "Sports & Fitness", status: false),
    AdsCategory(name: "Travel & Tourism", status: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ads Settings"),
        actions: [
          TextButton(onPressed: (){}, child: Text("Save",style: TextStyle(color: kSecendoryColor),))
        ],
      ),
      body: UniversalCard(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ads Control & Blocking",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Use this page to allow or block general categories of ads from appearing in your app."),
              SizedBox(height: 20,),
              Container(
                // width: getWidth(context) - 70,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                  // border: Border.all()
                ),
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  onChanged: (val){
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search,size: 20,),
                      onPressed: (){},
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("All categories",style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category name",style: TextStyle(color: Colors.blue),),
                  Text("Status",style: TextStyle(color: Colors.blue),)
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categoryList.length,
                itemBuilder: (ctx,i){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(categoryList[i].name),
                      Column(
                        children: [
                          Switch(
                            activeTrackColor: Colors.red.withOpacity(0.6),
                            inactiveTrackColor: Colors.green.withOpacity(0.6),
                            activeColor: Colors.red,
                            inactiveThumbColor: Colors.green,
                            value: categoryList[i].status, onChanged: (val){
                            print(val);
                            setState(() {
                              categoryList[i].status = val;
                            });
                            print(categoryList[i].status);
                          }),
                          Text(categoryList[i].status ? "Blocked":"Allowed")
                        ],
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
class AdsCategory{
  String name;
  bool status;
  AdsCategory({required this.name,required this.status});
}
