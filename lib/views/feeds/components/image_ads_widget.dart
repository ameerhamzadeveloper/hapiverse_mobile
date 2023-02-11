import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/constants.dart';
import '../comments_page.dart';
class ImageAdsWidget extends StatelessWidget {
  const ImageAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        color: Colors.white,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(15)
        // ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Pirbul Water Ballon",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("🌎",style: TextStyle(fontSize: 12),),
                              SizedBox(width: 5,),
                              Text(
                                "Suponsored",
                                style: TextStyle(color: kSecendoryColor,fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down_sharp))
                ],
              ),
              SizedBox(height: 10,),
              Text("Geolocation refers to any type of technology that is capable of identifying the geographic location of a device. By locating an asset tracking device in real time, you can locate an important asset,\n\n such as a container, a trailer, a pallet, etc.Often the tracking device is a mobile phone or an internet-connected device (Internet of Things). Let’s dive a little deeper into four different types of geolocation technologies and their pros and cons."),
              Divider(),
              Image.network("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",height: 200,width: double.infinity,fit: BoxFit.cover,),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            LineIcons.thumbsUpAlt,
                            color: 1 == 1 ? kUniversalColor : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        NumberFormat.compact().format(int.parse("22344")),
                        style: TextStyle(color:1 == 2 ? kUniversalColor : Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(postId: "postId",userId: 'userId',)));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            LineIcons.facebookMessenger,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        NumberFormat.compact().format(int.parse("2332")),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Share.share("https://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/posts");
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        LineIcons.share,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
