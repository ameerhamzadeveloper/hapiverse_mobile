import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/profile/business_profile_more/comments.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../logic/register/register_cubit.dart';

class ViewNotes extends StatefulWidget {
  final int i;
  const ViewNotes({Key? key, required this.i}) : super(key: key);

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  @override
  Widget build(BuildContext context) {
    final pro = context.read<BusinessProductCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        var d = state.bullitenNots![widget.i];
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(d.title),
          ),
          body: Card(
            child: TextField(
              maxLines: 20,
              controller: TextEditingController(text: d.body),
              decoration: InputDecoration(
                border: InputBorder.none
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kUniversalColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.save,color: Colors.white,)),
                      Text("Save",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(onPressed: (){
                        nextScreen(context, NotsComments());
                      }, icon: Icon(Icons.comment,color: Colors.white,)),
                      Text("Comments",style: TextStyle(color: Colors.white),)
                    ],
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
