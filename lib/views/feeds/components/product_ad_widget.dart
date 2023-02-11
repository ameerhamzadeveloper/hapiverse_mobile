import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/constants.dart';
import '../comments_page.dart';
class ProductAdWidget extends StatelessWidget {
  final bool isBookNow;
  final String userName;
  final String profileImage;
  final String date;
  final String image;
  final String title;
  final String description;
  final String like;
  final String comment;
  final bool isLiked;
  final VoidCallback? onLikeTap;
  final String _errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";
  final String url;
  const ProductAdWidget({Key? key,required this.isBookNow,required this.userName,required this.title,required this.profileImage,
    required this.url,required this.date,required this.image,required this.description,
    required this.isLiked,
    required this.like,required this.comment,
    required this.onLikeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
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
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${profileImage}"),
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
                            Text(userName,style: TextStyle(
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
            Row(
              children: [
                Expanded(child: Text(description)),
              ],
            ),
            Divider(),
            Image.network("${Utils.baseImageUrl}${image}",height: 200,width: double.infinity,fit: BoxFit.cover,),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(url),
                  Row(
                    children: [
                      Expanded(child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                      OutlinedButton(onPressed: (){}, child: Text(isBookNow ? "ORDER NOW" : "LEARN MORE"))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: onLikeTap,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          LineIcons.thumbsUpAlt,
                          color:isLiked  ? kUniversalColor : Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      NumberFormat.compact().format(int.parse(like)),
                      style: TextStyle(color:isLiked ? kUniversalColor : Colors.grey),
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
                      NumberFormat.compact().format(int.parse(comment)),
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
    );
  }
}
