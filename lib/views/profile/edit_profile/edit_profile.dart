import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:happiverse/views/profile/edit_profile/edit_interest.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../routes/routes_names.dart';
import '../../../utils/utils.dart';
import '../../../views/components/secondry_button.dart';
import '../../../utils/constants.dart';
import 'edit_education.dart';
import 'edit_occupation.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateFormat df = DateFormat('yyyy-mm-dd');
  GlobalKey<FormState> key = GlobalKey<FormState>();
  getColors(int i){
    switch(i){
      case 1:
        return Colors.blue;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.deepOrangeAccent;
      case 4:
        return Colors.green;
      case 5:
        return Colors.yellowAccent;
    }
  }

  String profileName = '';
  String city = '';
  // String country = '';
  String phoneNumber = '';
  String religion = '';
  RangeValues _distance = const RangeValues(0, 13000);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authB = context.read<RegisterCubit>();
    final profCubit = context.read<ProfileCubit>();
    profCubit.fetchInterests(authB.userID!);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text("Edit Profile"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Profile Image",style: TextStyle(fontSize: 20,),),
                        TextButton(onPressed: ()=>Navigator.pushNamed(context, editProfileImage), child: const Text("Edit"))
                      ],
                    ),
                    Center(
                      child:state.avatarType == "0"? CircleAvatar(radius: 35,backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage!}")): state.avatarType  == "1" ? InkWell(
                        onTap: (){
                          // nextScreen(context, PreviewProfileAvatar(flatColor: data['flatColor'], avatarType: data['avatarType'], text: data['profileImageText'], gredient1: data['firstgredientcolor'], gredient2: data['secondgredientcolor'], profileUrl: data['profile_url']));
                        },
                        child: SizedBox(
                          width: 100,
                          child: Stack(
                            children: [
                              Center(
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 8,
                                              color: getColors(int.parse(state.flatColor!)).withOpacity(0.8)
                                          ),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage("${Utils.baseImageUrl}${state.profileImage!}")
                                          )
                                      ),
                                    ),
                                  )
                              ),
                              state.profileImageText! == null ? Container():Center(
                                child: CircularText(
                                  children: [
                                    TextItem(
                                      text: Text(
                                        state.profileImageText!.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 7,
                                          color: Colors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      space: 10,
                                      startAngle: 90,
                                      startAngleAlignment: StartAngleAlignment.center,
                                      direction: CircularTextDirection.anticlockwise,
                                    ),
                                  ],
                                  radius: 35,
                                  position: CircularTextPosition.inside,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ): InkWell(
                        onTap: (){
                          // nextScreen(context, PreviewProfileAvatar(flatColor: data['flatColor'], avatarType: data['avatarType'], text: data['profileImageText'], gredient1: data['firstgredientcolor'], gredient2: data['secondgredientcolor'], profileUrl: data['profile_url']));
                        },
                        child: SizedBox(
                          width: 100,
                          child: Stack(
                            children: [
                              Center(
                                  child: CircleAvatar(
                                    radius: 35,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              colors: [
                                                getColors(int.parse(state.firstGredientColor!)),
                                                getColors(int.parse(state.secondGredientColor!)),
                                              ]
                                          )
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage("${Utils.baseImageUrl}${state.profileImage!}")
                                            )
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                              Center(
                                child: CircularText(
                                  children: [
                                    TextItem(
                                      text: Text(
                                        state.profileImageText == null ?"": state.profileImageText!.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 7,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      space: 10,
                                      startAngle: 90,
                                      startAngleAlignment: StartAngleAlignment.center,
                                      direction: CircularTextDirection.anticlockwise,
                                    ),
                                  ],
                                  radius: 35,
                                  position: CircularTextPosition.inside,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Interests"),
                                TextButton(onPressed: (){
                                  nextScreen(context, EditInterests());
                                }, child: Text("Edit"))
                              ],
                            ),
                            state.userInterest == null ? Center(child: CircularProgressIndicator(),):
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(state.userInterest!.length > 4 ? 4:state.userInterest!.length, (index){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Chip(label: Text(state.userInterest![index].interestSubCategoryTitle)),
                                  );
                                }).toList()
                              ),
                            ),
                            state.userInterest == null ? Center():state.userInterest!.length > 4 ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(state.userInterest!.length > 8 ? 4:state.userInterest!.length, (index){
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Chip(label: Text(state.userInterest![index + 4].interestSubCategoryTitle)),
                                    );
                                  }).toList()
                              ),
                            ):Container()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Personal Info",style: TextStyle(fontSize: 20,),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (val){
                        if(val!.isEmpty){
                          return "Please Enter Profile Name";
                        }else{
                          return null;
                        }
                      },
                      controller: TextEditingController(text: state.profileName),
                      decoration: const InputDecoration(
                          hintText: "Profile Name"
                      ),
                      onChanged: (val){
                        profileName = val;
                        // bloc.setProfileName(val);
                        print("called");
                      },

                    ),
                    TextField(
                      controller: TextEditingController(text: state.city),
                      decoration: const InputDecoration(
                        hintText: "City"
                      ),
                      onChanged: (val){
                        city = val;

                      },
                    ),
                    TextField(
                      onTap: (){
                        showCountryPicker(
                          // showWorldWide: true,
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                            // bottomSheetHeight: 500, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius:const  BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country)
                          {
                            bloc.setCountryVal(country.name);
                            // bloc.addAdsLocations(country.name);
                            print('Select country: ${country.name}');
                          },
                        );
                      },
                      decoration: const InputDecoration(
                          hintText: "Country"
                      ),
                      controller: TextEditingController(text: state.country),
                      onChanged: (val){
                        bloc.setCountryVal(val);
                      },
                    ),
                    TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                          hintText: "Phone No"
                      ),
                      controller: TextEditingController(text: state.phoneNo),
                      onChanged: (val){
                        phoneNumber = val;
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Education",style: TextStyle(fontSize: 20,),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    state.educationName != null ?
                    ListTile(
                      title: Text(state.educationName ?? ""),
                      leading: const Icon(LineIcons.graduationCap),
                      subtitle: Text("${state.educationLevel} - ${df.format(state.educationStartYear == null ? DateTime.now():DateTime.parse(state.educationStartYear!))} - ${state.currentlyReading == "1" ? "Present" : df.format(state.educationEndYaer == null ? DateTime.now():DateTime.parse(state.educationEndYaer!))}"),
                      trailing: IconButton(
                        onPressed: (){
                          nextScreen(context, EditEducation());
                        },
                        icon: Icon(Icons.edit),
                      ),
                    )
                        :Container(),
                    Divider(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Occupation",style: TextStyle(fontSize: 20,),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    state.workTitle != null ?
                    ListTile(
                      title: Text(state.workTitle ?? ""),
                      leading: Icon(LineIcons.briefcase),
                      subtitle: Text("${state.workLocation} - ${state.workStartDate} - ${state.currentlyWorking == "1" ? "Present" : state.workEndDate}"),
                      trailing: IconButton(
                        onPressed: (){
                          nextScreen(context, EditOccupations());
                        },
                        icon: Icon(Icons.edit),
                      ),
                    )
                        :Container(),
                    Divider(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Material Status",style: TextStyle(fontSize: 20,),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 45,
                      child: DropdownButton<String>(
                        underline: const Divider(color: Colors.grey,thickness: 1.5,),
                        isExpanded: true,
                        iconEnabledColor: kUniversalColor,
                        items: state.relationDropList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: state.relationShip,
                        onChanged: (val)=>bloc.changeRelationDrop(val),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 45,
                      child: DropdownButton<String>(
                        underline: const Divider(color: Colors.grey,thickness: 1.5,),
                        isExpanded: true,
                        iconEnabledColor: kUniversalColor,
                        items: state.genderList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                        ).toList(),
                        value: state.gender,
                        onChanged: (val)=>bloc.changeGenderDrop(val),
                        isDense: true,
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      decoration: const InputDecoration(
                          hintText: "Height"
                      ),
                      controller: TextEditingController(text: state.height),
                      onChanged: (val){
                        // phoneNumber = val;
                      },
                    ),
                    SizedBox(height: 20,),
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
                    const SizedBox(height: 20,),
                   state.isProfileUpdating ? CupertinoActivityIndicator() :
                   SecendoryButton(text: "Save", onPressed: (){
                     if(profileName != ''){
                       bloc.setProfileName(profileName);
                     }
                     if(city != ''){
                       bloc.setCityVal(city);
                     }
                     if(phoneNumber != ''){
                       bloc.setPhoneNum(phoneNumber);
                     }
                     bloc.updateUserProfileInfo(authBloc.userID!, authBloc.accesToken!);
                   })
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
