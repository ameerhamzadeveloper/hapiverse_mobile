import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/views/components/secondry_button.dart';
import '../../../logic/register/register_cubit.dart';

class AddJob extends StatefulWidget {
  const AddJob({Key? key}) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  String title = '';
  String companyName = '';
  String workplaceType = '';
  String jobtype = '';
  String description = '';

  GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pro = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Job"),
      ),
      body: Form(
        key: form,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Job Title"
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return "Job Title is required";
                    }
                  },
                  onChanged: (v){
                    title = v;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Company Name"
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return "Company Name is required";
                    }
                  },
                  onChanged: (v){
                    companyName = v;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "workplaceType"
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return "workplaceType is required";
                    }
                  },
                  onChanged: (v){
                    workplaceType = v;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Job Type"
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return "Job Type is required";
                    }
                  },
                  onChanged: (v){
                    jobtype = v;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Job Description"
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return "Job Description is required";
                    }
                  },
                  onChanged: (v){
                    description = v;
                  },
                ),
                SizedBox(height: 10,),
                SecendoryButton(text: "Create Job", onPressed: (){
                  if(form.currentState!.validate()){
                    pro.addJob(authB.userID!, authB.accesToken!, title, companyName, workplaceType, jobtype, description);
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Job has been added successfully");
                  }

                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
