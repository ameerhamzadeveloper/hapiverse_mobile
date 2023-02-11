import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../logic/feeds/feeds_cubit.dart';
import '../../../utils/constants.dart';
import '../comments_page.dart';
class BookNowAdsWidget extends StatefulWidget {
  final bool isBookNow;
  final String addId;
  final String userName;
  final String profileImage;
  final String date;
  final String image;
  final String title;
  final String description;
  final VoidCallback? onLikeTap;
  final String url;
  final String like;
  final String comment;
  final bool isLiked;
  const BookNowAdsWidget({Key? key,required this.isBookNow,required this.userName,required this.title,required this.profileImage,
  required this.url,required this.date,required this.image,required this.description,
    required this.addId,
    required this.isLiked,
    required this.like,required this.comment,
    required this.onLikeTap,
  }) : super(key: key);

  @override
  State<BookNowAdsWidget> createState() => _BookNowAdsWidgetState();
}

class _BookNowAdsWidgetState extends State<BookNowAdsWidget> {
  final String _errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bloc = context.read<FeedsCubit>();
    final authB = context.read<RegisterCubit>();
    bloc.addViewAd(authB.userID!, widget.addId, authB.accesToken!, false);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FeedsCubit>();
    final authB = context.read<RegisterCubit>();
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
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${widget.profileImage}"),
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
                        Text(widget.userName,style: TextStyle(
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
                Expanded(child: Text(widget.description)),
              ],
            ),
            Divider(),
            AnyLinkPreview(
              onTap: (){
                bloc.addViewAd(authB.userID!, widget.addId, authB.accesToken!, true);
              },
              removeElevation: true,
              borderRadius: 0,
              link: widget.url,
              displayDirection: UIDirection.uiDirectionVertical,
              // showMultimedia: false,
              // bodyMaxLines: 5,
              bodyTextOverflow: TextOverflow.ellipsis,
              errorBody: 'Error While Preview',
              errorTitle: 'Error While Preview',
              errorWidget: Container(
                color: Colors.grey[300],
                child: Text('Oops!'),
              ),
              titleStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              errorImage: _errorImage,
              bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            // Image.network("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",height: 200,width: double.infinity,fit: BoxFit.cover,),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.url),
                  Row(
                    children: [
                      Expanded(child: Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                      OutlinedButton(onPressed: (){}, child: Text(widget.isBookNow ? "BOOK NOW" : "LEARN MORE"))
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
                      onTap: widget.onLikeTap,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          LineIcons.thumbsUpAlt,
                          color: widget.isLiked ? kUniversalColor : Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      NumberFormat.compact().format(int.parse(widget.like)),
                      style: TextStyle(color:widget.isLiked ? kUniversalColor : Colors.grey),
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
                      NumberFormat.compact().format(int.parse(widget.comment)),
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
