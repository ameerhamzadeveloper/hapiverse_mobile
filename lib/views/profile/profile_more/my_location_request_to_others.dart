import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants.dart';

import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/utils.dart';
import '../../components/universal_card.dart';
class MyLocationRequestToOthers extends StatefulWidget {
  @override
  _MyLocationRequestToOthersState createState() => _MyLocationRequestToOthersState();
}

class _MyLocationRequestToOthersState extends State<MyLocationRequestToOthers> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.fetchLocationRequest(authBloc.userID!, authBloc.accesToken!, true);
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("My Location Requests"),
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Location Requests you sent to others to see their location"),
                  state.myLocationRequeststoOther == null ? const Center(child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CupertinoActivityIndicator(),
                  )):state.myLocationRequeststoOther!.isEmpty ? const Center(child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Text("No Location Requests"),
                  ),):ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.myLocationRequeststoOther!.length,
                    separatorBuilder: (c,i){
                      return const Divider();
                    },
                    itemBuilder: (c,i){
                      var d = state.myLocationRequeststoOther![i];
                      return ListTile(
                        title: Text(d.userName),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl}"),
                        ),
                        subtitle: Text(d.locationType == '1' ? "Live Location":"Current Location"),
                        trailing:Text(d.status,style: TextStyle(color:d.status == "rejected"? Colors.red:kSecendoryColor),)
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
