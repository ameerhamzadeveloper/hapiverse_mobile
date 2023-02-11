import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../../../views/components/secondry_button.dart';
import '../../../views/profile/health/components/add_record_widget.dart';
import '../../../views/profile/health/components/qr_widget.dart';
import 'package:line_icons/line_icons.dart';

import '../../../routes/routes_names.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  bool val = false;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    bloc.fetchCovidRecord(authB.userID!, authB.accesToken!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(getTranslated(context, 'MY_SCAN')!),
              actions: [
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, addRecordPAge);
                }, icon: Icon(Icons.add))
              ],
            ),
            body: state.covidRecordList == null ? Center(child: CupertinoActivityIndicator(),)
            : state.covidRecordList!.isEmpty ? AddRecordsWidget() : QRWidget()
        );
      },
    );
  }
}
