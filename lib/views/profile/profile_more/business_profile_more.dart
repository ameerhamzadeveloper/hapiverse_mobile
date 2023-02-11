import 'package:flutter/material.dart';
import 'package:happiverse/views/profile/business_profile_more/jobs.dart';
import 'package:happiverse/views/profile/jobs.dart';
import 'package:happiverse/views/profile/profile_more/add_job.dart';
import 'package:happiverse/views/profile/profile_more/calender_page.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/constants.dart';
import '../business_profile_more/bulliten_boards.dart';
class BusinessProfileMore extends StatefulWidget {
  const BusinessProfileMore({Key? key}) : super(key: key);

  @override
  State<BusinessProfileMore> createState() => _BusinessProfileMoreState();
}

class _BusinessProfileMoreState extends State<BusinessProfileMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              onTap: ()=>nextScreen(context, const BullitenBoards()),
              title: Text("Bulletin Board"),
              leading: Icon(LineIcons.archive),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: ()=>nextScreen(context, const CalenderPage()),
              title: Text("Calender"),
              leading: Icon(LineIcons.calendar),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              onTap: ()=>nextScreen(context, const Jobs()),
              title: Text("Job Opportunity"),
              leading: Icon(LineIcons.briefcase),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
