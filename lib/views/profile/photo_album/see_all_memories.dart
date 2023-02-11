import 'package:flutter/material.dart';
import '../../../views/components/universal_card.dart';
import '../../../views/profile/photo_album/page_view.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../../authentication/scale_navigation.dart';
class SeeAllMemoeires extends StatefulWidget {
  @override
  _SeeAllMemoeiresState createState() => _SeeAllMemoeiresState();
}

class _SeeAllMemoeiresState extends State<SeeAllMemoeires> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memories"),
      ),
      body: UniversalCard(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: ()=>  Navigator.push(context, ScaleRoute(page: PageViewPhoto(id:''))),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 6.0,
                  child: Container(
                    width: double.infinity,
                    height: getHeight(context) / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                AssetConfig.demoNetworkImage
                            )
                        )
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,))
                          ],
                        ),
                        Spacer(),
                        Text("13 March",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
                          Shadow( // bottomLeft
                              offset: Offset(-1.0, -1.0),
                              color: Colors.grey
                          ),
                          Shadow( // bottomRight
                              offset: Offset(1.0, -1.0),
                              color: Colors.grey
                          ),
                          Shadow( // topRight
                              offset: Offset(1.0, 1.0),
                              color: Colors.grey
                          ),
                          Shadow( // topLeft
                              offset: Offset(-1.0, 1.0),
                              color: Colors.grey
                          ),
                        ]),),
                        Text("2022",style: TextStyle(fontFamily: '',color: Colors.white),),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("12 items",style: TextStyle(color: Colors.grey),),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                elevation: 6.0,
                child: Container(
                  width: double.infinity,
                  height: getHeight(context) / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              AssetConfig.demoNetworkImage
                          )
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,))
                        ],
                      ),
                      Spacer(),
                      Text("13 March",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
                        Shadow( // bottomLeft
                            offset: Offset(-1.0, -1.0),
                            color: Colors.grey
                        ),
                        Shadow( // bottomRight
                            offset: Offset(1.0, -1.0),
                            color: Colors.grey
                        ),
                        Shadow( // topRight
                            offset: Offset(1.0, 1.0),
                            color: Colors.grey
                        ),
                        Shadow( // topLeft
                            offset: Offset(-1.0, 1.0),
                            color: Colors.grey
                        ),
                      ]),),
                      Text("2022",style: TextStyle(fontFamily: '',color: Colors.white),),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("12 items",style: TextStyle(color: Colors.grey),),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                elevation: 6.0,
                child: Container(
                  width: double.infinity,
                  height: getHeight(context) / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              AssetConfig.demoNetworkImage
                          )
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,))
                        ],
                      ),
                      Spacer(),
                      Text("13 March",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
                        Shadow( // bottomLeft
                            offset: Offset(-1.0, -1.0),
                            color: Colors.grey
                        ),
                        Shadow( // bottomRight
                            offset: Offset(1.0, -1.0),
                            color: Colors.grey
                        ),
                        Shadow( // topRight
                            offset: Offset(1.0, 1.0),
                            color: Colors.grey
                        ),
                        Shadow( // topLeft
                            offset: Offset(-1.0, 1.0),
                            color: Colors.grey
                        ),
                      ]),),
                      Text("2022",style: TextStyle(fontFamily: '',color: Colors.white),),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("12 items",style: TextStyle(color: Colors.grey),),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
