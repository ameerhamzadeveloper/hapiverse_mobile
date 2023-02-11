import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:line_icons/line_icons.dart';

class JobDetails extends StatefulWidget {
  final int index;

  const JobDetails({Key? key, required this.index}) : super(key: key);

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var job = state.jobs![widget.index];
        return Scaffold(
          appBar: AppBar(
            title: Text("Job Details"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.jobTitle,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(LineIcons.briefcase),
                    SizedBox(width: 10,),
                    Text(job.jobType)
                  ],
                ),
                Row(
                  children: [
                    Icon(LineIcons.mapPin),
                    SizedBox(width: 10,),
                    Text(job.jobLocation)
                  ],
                ),
                Row(
                  children: [
                    Icon(LineIcons.wordFile),
                    SizedBox(width: 10,),
                    Text(job.workplaceType)
                  ],
                ),
                SizedBox(height: 20,),
                Text("Job Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text(job.jobDescription),
                SizedBox(height: 20,),
                Text("About Business",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(job.businessName),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage("${Utils.baseImageUrl}${job.logoImageUrl}"),
                        ),
                        subtitle: Text(job.address),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
