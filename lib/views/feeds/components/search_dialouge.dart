import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiverse/views/components/secondry_button.dart';

import '../../../utils/constants.dart';
enum Gender { Male, Female }

Map<Gender, Color> skyColors = <Gender, Color>{
  Gender.Male: kUniversalColor,
  Gender.Female: kUniversalColor,
};
enum MaterialStatus { Single, Engaged, Married,Divorced}

Map<MaterialStatus, Color> material = <MaterialStatus, Color>{
  MaterialStatus.Single: kUniversalColor,
  MaterialStatus.Engaged: kUniversalColor,
  MaterialStatus.Married: kUniversalColor,
  MaterialStatus.Divorced: kUniversalColor,
};
class SearchDialogue extends StatefulWidget {
  const SearchDialogue({Key? key}) : super(key: key);

  @override
  State<SearchDialogue> createState() => _SearchDialogueState();
}

class _SearchDialogueState extends State<SearchDialogue> {
  RangeValues _currentRangeValues = const RangeValues(13, 80);
  RangeValues _currentHeight = const RangeValues(3, 10);
  RangeValues _distance = const RangeValues(0, 13000);
  Gender _selectedSegment = Gender.Male;
  MaterialStatus _selectedMaterial = MaterialStatus.Single;
  int hairColor = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getHeight(context) / 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.clear))
                  ],
                ),
                Row(
                  children: [
                    Text("Filter",style: TextStyle(fontSize: 18),),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Age ${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round()}",style: TextStyle(fontSize: 16,),),
                  ],
                ),
                const SizedBox(height: 10,),
                RangeSlider(
                  values: _currentRangeValues,
                  min: 13,
                  max: 80,
                  divisions: 30,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                      // bloc.setAdsAudionce("${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}",_currentRangeValues.start.round().toString(),'${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}');
                    });
                  },
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Gender",style: TextStyle(fontSize: 16,),),
                  ],
                ),
                SizedBox(height: 10,),
                CupertinoSlidingSegmentedControl<Gender>(
                  backgroundColor: CupertinoColors.systemGrey2,
                  thumbColor: skyColors[_selectedSegment]!,
                  // This represents the currently selected segmented control.
                  groupValue: _selectedSegment,
                  // Callback that sets the selected segmented control.
                  onValueChanged: (Gender? value) {
                    if (value != null) {
                      setState(() {
                        _selectedSegment = value;
                      });
                    }
                  },
                  children: const <Gender, Widget>{
                    Gender.Male: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Male',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    Gender.Female: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Female',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  },
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Material Status",style: TextStyle(fontSize: 16,),),
                  ],
                ),
                SizedBox(height: 10,),
                CupertinoSlidingSegmentedControl<MaterialStatus>(
                  backgroundColor: CupertinoColors.systemGrey2,
                  thumbColor: skyColors[_selectedSegment]!,
                  // This represents the currently selected segmented control.
                  groupValue: _selectedMaterial,
                  // Callback that sets the selected segmented control.
                  onValueChanged: (MaterialStatus? value) {
                    if (value != null) {
                      setState(() {
                        _selectedMaterial = value;
                      });
                    }
                  },
                  children: const <MaterialStatus, Widget>{
                    MaterialStatus.Single: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Single',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    MaterialStatus.Engaged: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Engage',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    MaterialStatus.Married: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Married',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    MaterialStatus.Divorced: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Divorce',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  },
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Hair Color",style: TextStyle(fontSize: 16,),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          hairColor = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: hairColor == 0 ? Border.all(width: 2) : Border.all(width: 0)
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          hairColor = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: hairColor == 1 ? Border.all(width: 2,color: Colors.brown) : Border.all(width: 0)
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          hairColor = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: hairColor == 2 ? Border.all(width: 2) : Border.all(width: 0)
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          hairColor = 3;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: hairColor == 3 ? Border.all(width: 2) : Border.all(width: 0)
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.brown,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          hairColor = 4;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: hairColor == 4 ? Border.all(width: 2) : Border.all(width: 0)
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Height ${_currentHeight.start.round().toString()} ft - ${_currentHeight.end.round() == 65 ? '65+' :_currentHeight.end.round().toString()} ft",style: TextStyle(fontSize: 16,),),
                  ],
                ),
                const SizedBox(height: 10,),
                RangeSlider(
                  values: _currentHeight,
                  min: 3,
                  max: 10,
                  divisions: 3,
                  labels: RangeLabels(
                    _currentHeight.start.round().toString(),
                    _currentHeight.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentHeight = values;
                      // bloc.setAdsAudionce("${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}",_currentRangeValues.start.round().toString(),'${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}');
                    });
                  },
                ),
                const SizedBox(height: 10,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Distance ${_distance.start.round().toString()} km - ${_distance.end.round().toString()} km",style: TextStyle(fontSize: 16,),),
                  ],
                ),
                const SizedBox(height: 10,),
                RangeSlider(
                  values: _distance,
                  min: 0,
                  max: 13000,
                  divisions: 300,
                  labels: RangeLabels(
                    _distance.start.round().toString(),
                    _distance.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _distance = values;
                      // bloc.setAdsAudionce("${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}",_currentRangeValues.start.round().toString(),'${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}');
                    });
                  },
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: ()=> Navigator.pop(context), child: Text("Cancel")),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: 130,
                        child: SecendoryButton(text: "Apply Filters", onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
