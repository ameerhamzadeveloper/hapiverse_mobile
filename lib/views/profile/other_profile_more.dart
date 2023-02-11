import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/profile/ghost_mode.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

class OtherProfileMore extends StatefulWidget {
  final String userId;
  const OtherProfileMore({Key? key,required this.userId}) : super(key: key);
  @override
  _OtherProfileMoreState createState() => _OtherProfileMoreState();
}

class _OtherProfileMoreState extends State<OtherProfileMore> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("More Options"),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(LineIcons.ghost,color: Colors.black,),
              ),
              title: const Text("Ghost Mode"),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
              onTap: (){
                nextScreen(context, Ghosting());
              },
            ),
            Divider(),
            ListTile(
              onTap: (){
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )
                  ),
                    context: context, builder: (c){
                  return Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          height: 6,
                          width: 25,
                        ),
                        SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                            Navigator.pop(context);
                            showDialog(context: context, builder: (c){
                              return CupertinoAlertDialog(
                                title: Text("Request Current Location Share"),
                                content: Text("Request goes to the user to accpet or reject to share the location"),
                                actions: [
                                  CupertinoDialogAction(child: Text("Request"),onPressed: (){
                                    bloc.requestLocation(authBloc.userID!, authBloc.accesToken!, widget.userId, false);
                                    authBloc.pushNotification(authBloc.userID!, authBloc.accesToken!, widget.userId, '7', "", "want to see your current location",widget.userId);
                                    Navigator.pop(context);
                                  },),
                                  CupertinoDialogAction(child: Text("Cancel"),onPressed: ()=> Navigator.pop(context),),
                                ],
                              );
                            });
                          },
                          leading: CircleAvatar(
                            child: Icon(LineIcons.alternateMapMarked),
                          ),
                          title: Text("Request Current Location",style: TextStyle(color: Colors.blue),),
                        ),
                        Divider(),
                        ListTile(
                          onTap: (){
                            Navigator.pop(context);
                            showDialog(context: context, builder: (c){
                              return CupertinoAlertDialog(
                                title: Text("Request Live Location Share"),
                                content: Text("Request goes to the user to accpet or reject to share the location"),
                                actions: [
                                  CupertinoDialogAction(child: Text("Request"),onPressed: (){
                                    print(widget.userId);
                                    authBloc.pushNotification(authBloc.userID!, authBloc.accesToken!, widget.userId, '7', "Hapiverse", "want to see your live location",widget.userId);
                                    bloc.requestLocation(authBloc.userID!, authBloc.accesToken!, widget.userId, true);
                                    Navigator.pop(context);
                                  },),
                                  CupertinoDialogAction(child: Text("Cancel"),onPressed: ()=> Navigator.pop(context),),
                                ],
                              );
                            });
                          },
                          leading: CircleAvatar(
                            child: Icon(LineIcons.alternateShare),
                          ),
                          title: Text("Request Live Location",style: TextStyle(color: Colors.blue),),
                        )
                      ],
                    ),
                  );
                });
              },
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Icon(LineIcons.mapMarker,color: Colors.black,),
              ),
              title: const Text("Request Location"),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            )
          ],
        ),
      ),
    );
  }
}
