import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/business_product/business_product_cubit.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../components/secondry_button.dart';
import '../job_details.dart';
class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pro = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    pro.fetchMyJobs(authB.userId, authB.token);
  }

  @override
  Widget build(BuildContext context) {
    final pro = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, proState) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Jobs"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Jobs you posted"),
                SizedBox(height: 10,),
                state.jobs == null ? Center(child: CircularProgressIndicator(),):
                state.jobs!.isEmpty ? Center(child: Text("No any Jobs"),):
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.jobs!.length,
                  itemBuilder: (c,i){
                    var jb = state.jobs![i];
                    return InkWell(
                      onTap: (){
                        nextScreen(context, JobDetails(index: i));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Image.network("${Utils.baseImageUrl}${proState.businessProfile!.logoImageUrl}",height: 80,)
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(jb.jobTitle,style: const TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold)),
                                      subtitle: Text(jb.companyName,style: const TextStyle(),),
                                    ),
                                  ),
                                  // Expanded(
                                  //   child: ListTile(
                                  //     subtitle: Text("${jb.jobLocation} (${jb.jobType})",style: TextStyle(color: Colors.grey),),
                                  //   ),
                                  // )
                                ],
                              ),
                              SecendoryButton(text: "Delete Job", onPressed: (){
                                showCupertinoDialog(context: context, builder: (c){
                                  return CupertinoAlertDialog(
                                    title: Text("Do you want to delet ${jb.jobTitle}?"),
                                    actions: [
                                      CupertinoDialogAction(child: Text("No"), onPressed: (){
                                        Navigator.pop(context);
                                      },),
                                      CupertinoDialogAction(child: Text("Yes"), onPressed: (){
                                        pro.deletJob(authB.userID!, authB.accesToken!, jb.jobId);
                                        Navigator.pop(context);
                                      },),
                                    ],
                                  );
                                });

                              })
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  },
);
  }
}
