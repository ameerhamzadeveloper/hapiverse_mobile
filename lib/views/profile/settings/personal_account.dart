import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';
class PersonalAccount extends StatefulWidget {
  const PersonalAccount({Key? key}) : super(key: key);

  @override
  _PersonalAccountState createState() => _PersonalAccountState();
}

class _PersonalAccountState extends State<PersonalAccount> {
  bool privateAccount = false;

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<RegisterCubit>();
    authBloc.checkAccountStatus(authBloc.userID!, authBloc.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<RegisterCubit>();
     return BlocBuilder<RegisterCubit,RegisterState>(
       builder: (context,state){
         return Scaffold(
           appBar: AppBar(
             title: Text(getTranslated(context, 'PERSONAL_ACCOUNT')!),
           ),
           body: UniversalCard(
             widget: Column(
               children: [
                 Text(getTranslated(context, 'ACCOUNT_PRIVACY')!,style: TextStyle(fontSize: 18),),
                 ListTile(
                   title: Text(getTranslated(context, 'PRIVATE_ACCOUNT')!),
                   trailing: Container(
                     height: 5,
                     child: CupertinoSwitch(
                       value: state.isAccountPrivate,
                       onChanged: (va){
                         if(state.isAccountPrivate == false){
                           showDialog(
                               context: context,
                               builder: (context) {
                                 return CupertinoAlertDialog(
                                   title: const Text("Do you want to go with private account?"),
                                   content: const Text("Private Account will not be visible to all Hapivese community only visible to your friends"),
                                   actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text(getTranslated(context, 'YES')!),
                                       onPressed: () async{
                                         Navigator.pop(context);
                                         authBloc.addRemoveAccountStatus(true);
                                         Fluttertoast.showToast(msg: "Your Account is Private");
                                       },),
                                     CupertinoDialogAction(
                                       child: Text(getTranslated(context, 'NO')!),
                                       onPressed: () {
                                         Navigator.of(context).pop();
                                       },),
                                   ],
                                 );
                               }
                           );
                         }else{
                           showDialog(
                               context: context,
                               builder: (context) {
                                 return CupertinoAlertDialog(
                                   title: const Text("Back to Public Account?"),
                                   content: const Text("Private Account will be visible to all Hapivese community anyone can see your profile publicaly"),
                                   actions: <Widget>[
                                     CupertinoDialogAction(
                                       child: Text(getTranslated(context, 'YES')!),
                                       onPressed: () async{
                                         Navigator.pop(context);
                                         authBloc.addRemoveAccountStatus(false);
                                         Fluttertoast.showToast(msg: "Back to Public Account");
                                       },),
                                     CupertinoDialogAction(
                                       child: Text(getTranslated(context, 'NO')!),
                                       onPressed: () {
                                         Navigator.of(context).pop();
                                       },),
                                   ],
                                 );
                               }
                           );
                         }
                       },
                     ),
                   ),
                   leading: Icon(LineIcons.lock),
                 )
               ],
             ),
           ),
         );
       },
     );
  }
}
