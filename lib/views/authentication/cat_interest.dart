import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/config/assets_config.dart';
import '../../utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class CategoryIntrest extends StatefulWidget {
  const CategoryIntrest({Key? key}) : super(key: key);
  @override
  _CategoryIntrestState createState() => _CategoryIntrestState();
}
class _CategoryIntrestState extends State<CategoryIntrest> {
  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().getInterests();
  }
  String search = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit,RegisterState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Interests"),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () => Navigator.pushNamed(context, subCatInterset),
                child: const Text(
                  "Next",
                ),
              )
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoSearchTextField(
                  onChanged: (v){
                    setState(() {
                      search = v;
                    });
                  },
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                  ),
                  child: state.intrest == null || state.intrest!.isEmpty ?
                  const Center(child: CircularProgressIndicator(),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: search == '' ?
                    GridView.builder(
                      itemCount: state.intrest!.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2.5 / 2.3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                          child: Stack(
                            children: [
                              Card(
                                color: state.intrest![i].isSelect ? Colors.grey[300] : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Image.network(state.intrest![i].interestImage, height:120, width:getWidth(context)/2, fit:BoxFit.cover),
                                    Text(state.intrest![i].intrestCategoryTitle)
                                  ],
                                ),
                              ),
                              state.intrest![i].isSelect
                                  ? const Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  LineIcons.check,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                                  : Container()
                            ],
                          ),
                        );
                      },
                    ):
                    GridView.builder(
                      itemCount: state.intrest!.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2.5 / 2.3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemBuilder: (ctx, i) {
                        if(state.intrest![i].intrestCategoryTitle.toLowerCase().contains(search.toLowerCase())){
                          return InkWell(
                            onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                            child: Stack(
                              children: [
                                Card(
                                  color: state.intrest![i].isSelect ? Colors.grey[300] : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Image.network(state.intrest![i].interestImage, height:120, width:getWidth(context)/2, fit:BoxFit.cover),
                                      Text(state.intrest![i].intrestCategoryTitle)
                                    ],
                                  ),
                                ),
                                state.intrest![i].isSelect
                                    ? const Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    LineIcons.check,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                )
                                    : Container()
                              ],
                            ),
                          );
                        }else{
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
