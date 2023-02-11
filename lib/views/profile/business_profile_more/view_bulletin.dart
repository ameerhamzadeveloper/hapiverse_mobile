import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/components/secondry_button.dart';
import 'package:happiverse/views/profile/business_profile_more/add_bulletin_notes.dart';
import 'package:happiverse/views/profile/business_profile_more/view_nots.dart';

import '../../../logic/business_product/business_product_cubit.dart';
import '../../../logic/register/register_cubit.dart';

class ViewBulliten extends StatefulWidget {
  final int i;
  final String id;
  const ViewBulliten({Key? key, required this.i,required this.id}) : super(key: key);

  @override
  State<ViewBulliten> createState() => _ViewBullitenState();
}

class _ViewBullitenState extends State<ViewBulliten> {
  void initState() {
    // TODO: implement initState
    super.initState();
    final pro = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    pro.fetchBullitenNotes(authB.userID!, authB.accesToken!,widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        var d = state.bullitens![widget.i];
        return Scaffold(
          appBar: AppBar(
            title: Text(d.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SecendoryButton(text: "Add Notes", onPressed: (){
                  nextScreen(context, AddBullitinNotes(i: d.bullitenId));
                }),
                SizedBox(height: 20,),
                state.bullitenNots == null ? Center(child: CircularProgressIndicator(),):state.bullitenNots!.isEmpty ? Center(child: Text("No Bullitin Board"),):
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: state.bullitenNots!.length,
                  itemBuilder: (ctx,i){
                    var prod = state.bullitenNots![i];
                    return InkWell(
                      onTap: (){
                        nextScreen(context, ViewNotes(i: i));
                      },
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(prod.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),maxLines: 1,),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(prod.body,style: TextStyle(fontSize: 15,color: Colors.grey),),
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            )
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
