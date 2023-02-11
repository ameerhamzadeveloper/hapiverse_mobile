import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/post_cubit/post_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';

class PickBusinessLocation extends StatefulWidget {
  const PickBusinessLocation({Key? key}) : super(key: key);

  @override
  _PickBusinessLocationState createState() => _PickBusinessLocationState();
}

class _PickBusinessLocationState extends State<PickBusinessLocation> {

  @override
  void initState() {
    super.initState();
    context.read<PostCubit>().getNeabyLocations();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit,PostState>(
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.black,
              ),
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Text(getTranslated(context, 'ADD_LOCATION')!,style: TextStyle(color: Colors.black),),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      // Divider(),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        padding: const EdgeInsets.only(left: 8.0),
                        child:  TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: getTranslated(context, 'SEARCH')!
                          ),
                        ),
                      ),
                      state.places == null ? const Center(child: CircularProgressIndicator(),):
                      Expanded(
                        child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.places!.results.length,
                          itemBuilder: (ctx,i){
                            return ListTile(
                              onTap: (){
                                context.read<RegisterCubit>().assignBusinessLocation(state.places!.results[i].name!);
                                Navigator.pop(context);
                              },
                              leading: Icon(Icons.location_on,color: Colors.red,),
                              title: Text(state.places!.results[i].name!),
                              subtitle: Text(state.places!.results[i].vicinity!),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
