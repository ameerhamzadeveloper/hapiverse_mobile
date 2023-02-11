import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/views/business_tools/events/events.dart';
import 'package:happiverse/views/profile/profile_more/orders_page.dart';
import 'package:happiverse/views/profile/profile_more/translator.dart';
import 'package:translator/translator.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../views/components/secondry_button.dart';
import '../../../views/components/universal_card.dart';
import '../../../views/plans/user_plan.dart';
import '../../../views/profile/profile_more/movies.dart';
import '../../../views/profile/profile_more/music/music.dart';
import '../../../views/profile/profile_more/other_location_tracing.dart';
import '../../../views/profile/profile_more/stealth_ghosting.dart';
import 'package:line_icons/line_icons.dart';
import '../../../utils/constants.dart';
import '../jobs.dart';
import '../photo_album/images_albumbs.dart';
import 'calender_page.dart';

class ProfileMore extends StatefulWidget {
  const ProfileMore({Key? key}) : super(key: key);

  @override
  _ProfileMoreState createState() => _ProfileMoreState();
}

class _ProfileMoreState extends State<ProfileMore> {

  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("More info"),
      ),
      body: UniversalCard(
        widget: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                authB.planID == 1 ? Container(
                  child: Column(
                    children: [
                      Text("To Access These Features Please Upgrade Your Plan",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      SecendoryButton(text: "Upgrade Plan", onPressed: ()=> nextScreen(context, UserPlans()))
                    ],
                  ),
                ):Container(),
                authB.planID == 5 || authB.planID == 6 ? Container():Column(
                  children: [
                    ListTile(
                      onTap: ()=>nextScreen(context, const ImageAlbums()),
                      title: Text("Photo Album"),
                      leading: Icon(LineIcons.image),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      onTap: ()=>nextScreen(context, const MyOrdersUser()),
                      title: Text("My Orders"),
                      leading: Icon(LineIcons.box),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                  ],
                ),
                authB.planID == 8 ? Column(
                  children: [
                    ListTile(
                      onTap: ()=>nextScreen(context, const StealthGhosting()),
                      title: Text("Stealth"),
                      leading: Icon(LineIcons.eyeSlash),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                  ],
                ) :Container(),

                authB.planID == 5 ? Container():Column(
                  children: [
                    ListTile(
                      onTap: ()=>nextScreen(context, const OtherLocationTracing()),
                      title: Text("Location Tracking"),
                      leading: Icon(LineIcons.mapMarker),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                  ],
                ),
                authB.planID == 8 ? Column(
                  children: [
                    ListTile(
                      onTap: ()=>nextScreen(context, const MusicPage()),
                      title: Text("Music"),
                      leading: Icon(LineIcons.music),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                  ],
                ):Container(),
                authB.planID == 5 || authB.planID == 6 ? Container():ListTile(
                  onTap: ()=>nextScreen(context, MoviesPage()),
                  title: Text("Movies"),
                  leading: Icon(LineIcons.film),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
                authB.planID == 7 ||  authB.planID == 8 ? Column(
                  children: [
                    ListTile(
                      onTap: ()=>nextScreen(context, const BusinessEvents()),
                      title: Text("Events"),
                      leading: Icon(LineIcons.calendar),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(),
                  ],
                ):Container(),
                ListTile(
                  onTap: ()=>nextScreen(context, TranslatorLanguage()),
                  title: Text("Translator"),
                  leading: Icon(LineIcons.language),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
                ListTile(
                  onTap: ()=>nextScreen(context, CalenderPage()),
                  title: Text("Calender"),
                  leading: Icon(LineIcons.calendar),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
                ListTile(
                  onTap: ()=>nextScreen(context, JobsSections()),
                  title: Text("Jobs"),
                  leading: Icon(LineIcons.briefcase),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
