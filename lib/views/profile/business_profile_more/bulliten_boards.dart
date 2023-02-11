import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/profile/business_profile_more/add_bulliten_board.dart';
import 'package:happiverse/views/profile/business_profile_more/view_bulletin.dart';

import '../../../logic/register/register_cubit.dart';

class BullitenBoards extends StatefulWidget {
  const BullitenBoards({Key? key}) : super(key: key);

  @override
  State<BullitenBoards> createState() => _BullitenBoardsState();
}

class _BullitenBoardsState extends State<BullitenBoards> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pro = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    pro.fetchBullitenBoards(authB.userID!, authB.accesToken!);
  }

  @override
  Widget build(BuildContext context) {
    final pro = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Bulletin Board"),
            actions: [
              IconButton(onPressed: (){
                nextScreen(context, AddBullitinBoard());
              },icon: Icon(Icons.add),)
            ],
          ),
          body: Column(
            children: [
              state.bullitens == null ? Center(child: CircularProgressIndicator(),):state.bullitens!.isEmpty ? Center(child: Text("No Bulletin Board"),):
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.bullitens!.length,
                    itemBuilder: (c,i){
                      var dat = state.bullitens![i];
                      return ListTile(
                        onTap: (){
                          nextScreen(context, ViewBulliten(i:i,id:dat.bullitenId));
                        },
                        title: Text(dat.title),
                        trailing: IconButton(onPressed: (){
                          showDialog(context: context, builder: (c){
                            return AlertDialog(
                              title: Text("Do you want to delete bulletin?"),
                              actions: [
                                TextButton(onPressed: ()=> Navigator.pop(context), child: Text("No")),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  pro.deleteBulletin(authB.userID!, authB.accesToken!, dat.bullitenId);
                                }, child: Text("Delete")),
                              ],
                            );
                          });

                        },icon: Icon(Icons.delete),),
                        subtitle: Text("see board"),
                        leading: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz_r0wT1mYShUgtQEtHDqN_9jN0z8ODOhHNHAlxVUR&s",width: 80,),
                      );
                    },
                  )
            ],
          ),
        );
      },
    );
  }
}
