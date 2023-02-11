import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/utils/constants.dart';

class EditInterests extends StatefulWidget {
  const EditInterests({Key? key}) : super(key: key);

  @override
  State<EditInterests> createState() => _EditInterestsState();
}

class _EditInterestsState extends State<EditInterests> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Interests"),
            actions: [
              isLoading ? Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoActivityIndicator(color: Colors.white,),
              ),):TextButton(onPressed: (){
                setState(() {
                  isLoading = true;
                });
                Future.delayed(Duration(seconds: 3),(){
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(msg: "Interest Updated Successfully");
                });
              }, child: Text("Update",style: TextStyle(color: kSecendoryColor),))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                state.userInterest == null ? Center(child: CircularProgressIndicator(),):
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.userInterest!.length,
                      itemBuilder: (c,i){
                        return ListTile(
                          onTap: (){
                            bloc.selectUnselectInterests(i);
                          },
                          leading: CircleAvatar(),
                          title: Text(state.userInterest![i].interestSubCategoryTitle),
                          trailing: state.userInterest![i].isSelected ?  Icon(Icons.check) : Text(""),
                        );
                      },
                    )
              ],
            ),
          ),
        );
      },
    );
  }
}
