import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/profile/job_details.dart';

class JobsSections extends StatefulWidget {
  const JobsSections({Key? key}) : super(key: key);

  @override
  State<JobsSections> createState() => _JobsSectionsState();
}

class _JobsSectionsState extends State<JobsSections> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pro = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    pro.fetchJobs(authB.userId, authB.token);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Jobs"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text("Jobs for you"),
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
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Image.network("${Utils.baseImageUrl}${jb.logoImageUrl}",height: 80,)
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(jb.jobTitle,style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold)),
                                          subtitle: Text(jb.companyName,style: TextStyle(),),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: ListTile(
                                      //     subtitle: Text("${jb.jobLocation} (${jb.jobType})",style: TextStyle(color: Colors.grey),),
                                      //   ),
                                      // )
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
  }
}
