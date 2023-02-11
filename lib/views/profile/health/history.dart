import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';
import '../../../utils/config/assets_config.dart';
class CovidHistory extends StatefulWidget {
  const CovidHistory({Key? key}) : super(key: key);

  @override
  _CovidHistoryState createState() => _CovidHistoryState();
}

class _CovidHistoryState extends State<CovidHistory> {
  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd MMM yyyy');
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'HISTORY')!),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: Card(
              color: Colors.white.withOpacity(0.8),
              shape: cardRadius,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated(context, 'COVID_19_HISTORY')!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(getTranslated(context, 'PREVENTION')!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(AssetConfig.avoidClose,height: getWidth(context) / 4,),
                              Text(getTranslated(context, 'AVOID_CLOSE_CONTACT')!,textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(AssetConfig.washHand,height: getWidth(context) / 4,),
                              Text(getTranslated(context, 'CLEAN_YOUR_HANDS_OFTEN')!,textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(AssetConfig.useMask,height: getWidth(context) / 4,),
                              Text(getTranslated(context, 'WEAR_A_FACEMASK')!,textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Card(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx,i){
                          return Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 8,bottom: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(state.covidRecordList![i].hospitalName!),
                                        Text("${getTranslated(context, 'EXPIRE_ON_19_MARCH')!} ${format.format(state.covidRecordList![i].date!)}",style: TextStyle(fontSize: 12,color: Colors.grey),)
                                      ],
                                    ),
                            state.covidRecordList![i].covidStatus == "Positive"? Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.red
                                        ),
                                        child: Center(
                                          child: Text(getTranslated(context, 'POSITIVE')!,style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                    ): Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.green
                                  ),
                                  child: Center(
                              child: Text(getTranslated(context, 'NEGATIVE')!,style: TextStyle(color: Colors.white),),
                          ),
                          ),
                          )
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          );
                        },
                        itemCount: state.covidRecordList!.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
