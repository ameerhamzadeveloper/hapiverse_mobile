import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../logic/feeds/feeds_cubit.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../views/profile/my_profile.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import '../components/secondry_button.dart';
import 'other_profile/other_profile_page.dart';

class CommentPage extends StatefulWidget {
  final String postId;
  final String userId;

  const CommentPage({Key? key, required this.postId,required this.userId}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  showBottom(BuildContext context){
    showModalBottomSheet(context: context, builder: (ctx,){
      return Container(
        height: 300,
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 10,),
            Icon(LineIcons.checkCircle,size: 50,color: kUniversalColor,),
            SizedBox(height: 10,),
            Text("Thanks for letting us know",style: TextStyle(fontSize: 22),),
            SizedBox(height: 10,),
            Text("your feedback is important in helping us keep the hapiverse community safe",style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SecendoryButton(text: "Done", onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              }),
            )
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    final authB = context.read<RegisterCubit>();
    final feedsB = context.read<FeedsCubit>();
    feedsB.fetchFeedsComments(authB.userID!, authB.accesToken!, widget.postId);
    print(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    TextEditingController message = TextEditingController();
    final authB = context.read<RegisterCubit>();
    final feedsB = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, profileState) {
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Add Comment"),
          ),
          body: SafeArea(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: state.postCommentMap == null || state.postCommentMap!.isEmpty ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: getWidth(context) / 2,),
                        Container(
                          height: 100,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                                  image: NetworkImage(
                                      "https://freepikpsd.com/file/2019/10/comment-png-icon-8-1-Transparent-Images.png"
                                  )
                              )
                          ),
                        ),
                        const Text("No Commnet Yet", style: TextStyle(
                            color: Colors.grey),),
                      ],
                    ),
                  ):
                  ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx,i){
                      return ListTile(
                        leading: InkWell(
                          onTap: ()async{
                            print(state.postCommentMap![i].userId);
                            print(authB.userID);
                            if(authB.userID == state.postCommentMap![i].userId){
                              nextScreen(context, const MyProfile());
                            }else if(state.postCommentMap![i].userName == "Happiverse User"){

                            }else{
                              profileBloc.fetchOtherProfile(state.postCommentMap![i].userId!, authB.accesToken!,authB.userID!);
                              profileBloc.fetchOtherAllPost(state.postCommentMap![i].userId!, authB.accesToken!,authB.userID!);
                              nextScreen(context, OtherProfilePage(userId: state.postCommentMap![i].userId!));
                            }

                          },
                          child: state.postCommentMap![i].profileImageUrl == null ? CircleAvatar():CircleAvatar(
                            backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.postCommentMap![i].profileImageUrl!}"),
                          ),
                        ),
                        title: state.postCommentMap![i].userName == null ? Text(""):Text(state.postCommentMap![i].userName!),
                        subtitle: Text(state.postCommentMap![i].comment!),
                        trailing: IconButton(
                          onPressed: (){
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                context: context,
                                builder: (ctx){
                                  return Container(
                                    height: authB.userID == state.postCommentMap![i].userId ? 250 : 200,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Row(
                                          children: [
                                            Expanded(child: InkWell(
                                              onTap:(){
                                                Clipboard.setData(ClipboardData(text: state.postCommentMap![i].comment));
                                                Fluttertoast.showToast(msg: "Text Copied");
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey[300]
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Icon(LineIcons.copy),
                                                      Text("Copy")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ),
                                            authB.userID == state.postCommentMap![i].userId ? Container():SizedBox(width: 10,),
                                            authB.userID == state.postCommentMap![i].userId ? Container():Expanded(child: InkWell(
                                              onTap: (){
                                                showModalBottomSheet(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15.0),
                                                    ),
                                                    context: context, builder: (ctx){
                                                  return Container(
                                                    // height: 200,
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(height: 10,),
                                                          Container(
                                                            width: 40,
                                                            height: 5,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              color: Colors.grey[300],
                                                            ),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Text("Report",style: TextStyle(fontSize: 18),),
                                                          SizedBox(height: 10,),
                                                          Divider(),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("Why are you reporting this post?",style: TextStyle(fontSize: 18),),
                                                                SizedBox(height: 10,),
                                                                Text("Posts are shown in feeds based on many things include your interest your location based your activity based.",
                                                                    style: TextStyle(color: Colors.grey)),
                                                                SizedBox(height: 10,)
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Divider(),
                                                          ListTile(
                                                            onTap: (){
                                                              showBottom(context);
                                                            },
                                                            title: Text("It's spam"),
                                                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                          ),
                                                          Divider(),
                                                          ListTile(
                                                            onTap: (){
                                                              showBottom(context);
                                                            },
                                                            title: Text("Nudity or sexual activity"),
                                                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                          ),
                                                          Divider(),
                                                          ListTile(
                                                            onTap: (){
                                                              showBottom(context);
                                                            },
                                                            title: Text("I just don't like it"),
                                                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                          ),
                                                          Divider(),
                                                          ListTile(
                                                            onTap: (){
                                                              showBottom(context);
                                                            },
                                                            title: Text("Nudity or sexual activity"),
                                                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                          ),
                                                          Divider(),
                                                          ListTile(
                                                            onTap: (){
                                                              showBottom(context);
                                                            },
                                                            title: Text("Hate speech or symbols"),
                                                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                          ),
                                                          Divider(),
                                                          ListTile(
                                                            onTap: (){
                                                              showBottom(context);
                                                            },
                                                            title: Text("False information"),
                                                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                          ),
                                                          Divider(),
                                                          ListTile(
                                                            onTap: (){
                                                              showBottom(context);
                                                            },
                                                            title: Text("Scam or fraud"),
                                                            trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey[300]
                                                ),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Icon(LineIcons.exclamationCircle,color: Colors.red,),
                                                      Text("Report")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        authB.userID == state.postCommentMap![i].userId ? Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey[300],
                                          ),
                                          padding: EdgeInsets.all(12),
                                          child: Center(child: Text("Edit")),
                                        ):Container(),
                                        SizedBox(height: 10,),
                                        authB.userID == state.postCommentMap![i].userId ?InkWell(
                                          onTap: (){
                                            feedsB.deleteComment(authB.userID!, authB.accesToken!, state.postCommentMap![i].postCommentId!, widget.postId);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey[300],
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: Center(child: Text("Delete",style: TextStyle(color: Colors.red),)),
                                          ),
                                        ):Container(),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: Icon(Icons.more_vert),
                        ),
                      );
                    },
                    itemCount: state.postCommentMap!.length,
                  ),),
                  Wrap(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: AutoSizeTextField(
                            maxLines: null,
                            controller: message,
                            onChanged: (val) {
                              text = val;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write Something',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  feedsB.addPostComment(authB.userID!, authB.accesToken!, widget.postId, message.text,widget.userId == authB.userID! ? "":widget.userId);
                                  message.clear();
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: kUniversalColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]
            ),
          ),
        );
      },
    );
  },
);
  }
}
