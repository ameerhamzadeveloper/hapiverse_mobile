import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happiverse/data/model/fetch_my_plan.dart';
import 'package:happiverse/utils/user_url.dart';
import 'package:happiverse/views/authentication/loading_page.dart';
import 'package:happiverse/views/authentication/otp_verification.dart';
import 'package:happiverse/views/authentication/sign_up_business.dart';
import 'package:happiverse/views/authentication/sign_up_user.dart';
import 'package:happiverse/views/splash.dart';
import 'package:happiverse/views/splash_normal.dart';
import '../../data/model/intrestes_category.dart';
import '../../data/model/notification_model.dart';
import '../../data/repository/register_repository.dart';
import '../../routes/routes_names.dart';
import '../../views/authentication/enter_email.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../data/model/interest_select_model.dart';
import '../../utils/constants.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit()
      : super(RegisterState(
            errorMessage: '',
            loadingState: false,
            relationVal: relationShip,
            genderVal: gender,
            relationDropList: relationStatusList,
            genderList: genderList,
            dateOfBirth: DateTime.now(),
            isInterseSelect: [],
            isBusiness: isBusiness,
            isCatSelect: false,
            businessLocation: TextEditingController(),
            profileCategoryVal: profileCategory,
            profileCategoryList: profileCategoryList,
            alwaysOpen: false,
            wednesdayStartTime: TimeOfDay.now(),
            wednesdayEndTime: TimeOfDay.now(),
            tuesdayStartTime: TimeOfDay.now(),
            tuesdayEndTime: TimeOfDay.now(),
            thursdayStartTime: TimeOfDay.now(),
            thursdayEndTime: TimeOfDay.now(),
            sundayEndTime: TimeOfDay.now(),
            sundaryStartTime: TimeOfDay.now(),
            saturdayStartTime: TimeOfDay.now(),
            saturdayEndTime: TimeOfDay.now(),
            mondayStartTime: TimeOfDay.now(),
            mondayEndTime: TimeOfDay.now(),
            fridayStartTime: TimeOfDay.now(),
            firdayEndTime: TimeOfDay.now(),
            isHoursSelected : false,
            notificaitionCount: '0',
            closedAllDayWednesDay: false,
            closedAllDayTuesday: false,
            closedAllDayThursday: false,
            closedAllDaySunday: false,
            closedAllDaySaturday: false,
            closedAllDayMonday: false,
            closedAllDayFriday: false,
            isAccountPrivate: false,
            workStartDate: DateTime.now(),
            workEndDate: DateTime.now(),
    educationStartDate: DateTime.now(),
    educationEndDate: DateTime.now(),
    educationLevel: "School",
    currentlyWorking: "0"
        ),);

  final repository = RegisterRepository();
  late SharedPreferences pre;

  List<IntrestCategory> inters = [];
  List<IntrestCategory> subIn = [];

  String? userID;
  String? userEmail;
  String? accesToken;
  String get userId => userID!;
  String get token => accesToken!;
  int? get planID => state.planId;

  double? lat;
  double? long;

  hoursSelected(){
    emit(state.copyWith(isHoursSelectedd:true));
  }
  selectAlwayBusinessHours(bool val){
    emit(state.copyWith(alwaysOpenn: val));
  }

  Future<void> selectSaturdayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.saturdayStartTime) {
      emit(state.copyWith(saturdayStartTimee: newTime));
    }
    print(state.saturdayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }
  Future<void> selectSaturdayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.saturdayEndTime) {
      emit(state.copyWith(saturdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }
  Future<void> selectSundayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.sundaryStartTime) {
      emit(state.copyWith(sundaryStartTimee: newTime));
    }
    print(state.sundaryStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }
  Future<void> selectSundayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.sundayEndTime) {
      emit(state.copyWith(sundayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }
  Future<void> selectMondayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.mondayStartTime) {
      emit(state.copyWith(mondayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }
  Future<void> selectMondayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.mondayEndTime) {
      emit(state.copyWith(mondayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }
  Future<void> selectTuesdayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.tuesdayStartTime) {
      emit(state.copyWith(tuesdayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }
  Future<void> selectTuesdayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.tuesdayEndTime) {
      emit(state.copyWith(tuesdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }
  Future<void> selectWednesdayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.wednesdayStartTime) {
      emit(state.copyWith(wednesdayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }
  Future<void> selectWednesdayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.wednesdayEndTime) {
      emit(state.copyWith(wednesdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }
  Future<void> selectThursdayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.thursdayStartTime) {
      emit(state.copyWith(thursdayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }
  Future<void> selectThursdayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.thursdayEndTime) {
      emit(state.copyWith(thursdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }
  Future<void> selectFridayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.fridayStartTime) {
      emit(state.copyWith(fridayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }
  Future<void> selectFridayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.firdayEndTime) {
      emit(state.copyWith(firdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }

  mondayAllDayOff(){
    emit(state.copyWith(closedAllDayMondayy: !state.closedAllDayMonday));
  }
  tuesdayAllDayOff(){
    emit(state.copyWith(closedAllDayTuesdayy: !state.closedAllDayTuesday));
  }
  wednesdayAllDayOff(){
    emit(state.copyWith(closedAllDayWednesDayy: !state.closedAllDayWednesDay));
  }
  thursdayAllDayOff(){
    emit(state.copyWith(closedAllDayThursdayy: !state.closedAllDayThursday));
  }
  fridayAllDayOff(){
    emit(state.copyWith(closedAllDayFridayy: !state.closedAllDayFriday));
  }
  saturdayAllDayOff(){
    emit(state.copyWith(closedAllDaySaturdayy: !state.closedAllDaySaturday));
  }
  sundayAllDayOff(){
    emit(state.copyWith(closedAllDaySundayy: !state.closedAllDaySunday));
  }

  String? hobby;
  DateTime? dateofBirth;
  static String relationShip = "Single";
  static String profileCategory = "--select category--";
  static String gender = "Male";
  String base64Image = '';
  String authorizationToken = '';
  String get authToken => authorizationToken;

  static List<String> relationStatusList = [
    'Single',
    'Engaged',
    'Married',
    'Dating',
    'Divorced',
  ];

  static List<String> profileCategoryList = [
    '--select category--',
    'Information Technology',
    'Restaurants',
    'Gymnastics',
    'Dance Club',
    'Training Center',
    'PlayGround',
    'Entertainment',
  ];

  changeRelationDrop(val) {
    relationShip = val;
    emit(state.copyWith(relationVall: val));
  }

  changeProfileCategory(val) {
    profileCategory = val;
    emit(state.copyWith(profileCategoryVall: val));
  }

  static List<String> genderList = [
    'Male',
    'Female',
  ];
  static bool isBusiness = false;
  bool? isBusinessShared;

  isBusinessClicked(bool val){
    print("called");
    isBusiness = val;
    emit(state.copyWith(isBusinesss: isBusiness));
    print(state.isBusiness);
  }

  changeGenderDrop(val) {
    gender = val;
    emit(state.copyWith(genderVall: val));
  }

  changeDate(DateTime date){
    emit(state.copyWith(dateofB: date));
  }

  workStartDate(DateTime date){
    emit(state.copyWith(workStartDatee: date));
  }
  workEndDate(DateTime date){
    emit(state.copyWith(workEndDatee: date));
  }
  educationStartDate(DateTime date){
    emit(state.copyWith(educationStartDatee: date));
  }
  educationEndDate(DateTime date){
    emit(state.copyWith(educationEndDatee: date));
  }

  setWorkValueClear(){
    emit(state.copyWith(workDescriptionn: "",jobTitlee: "",workLocationn: "",workNamee: ""));
  }
  setEducationValueClear(){
    emit(state.copyWith(educationNamee: "",));
  }

  assignWorkValue(int offset,String val){
    switch(offset){
      case 1:
        emit(state.copyWith(workNamee: val));
        break;
      case 2:
        emit(state.copyWith(jobTitlee: val));
        break;
      case 3:
        emit(state.copyWith(workLocationn: val));
        break;
      case 4:
        emit(state.copyWith(workDescriptionn: val));
        break;
      case 5:
        emit(state.copyWith(currentlyWorkingg: val));
        break;
    }
  }

  assignEducationValue(int offset,String val){
    switch(offset){
      case 1:
        emit(state.copyWith(educationNamee: val));
        break;
      case 2:
        emit(state.copyWith(educationLocationn: val));
        break;
      case 3:
        emit(state.copyWith(educationLevell: val));
        break;
    }
  }

  getLocation() async {
    await Geolocator.requestPermission();
    Geolocator.checkPermission().then((value) {
      print("perssmsmmsmsmsm ${value.name}");
      if(value.name == "deniedForever"){
        Geolocator.openLocationSettings();
      }
    });
    await Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
    });
  }

  getInterests() {
    repository.getInterests().then((response) {
      final result = intrestModelFromJson(response.body);
      inters = result.data;
      // subIn = result.data;
      print(result.data);
      emit(state.copyWith(intrestt: result.data, subIntres: subIn));
      // print(state.intrest![1].name);
    });
  }

  List<String> subCatId = [];
  List<String> isInterseSelect = [];
  List tempList = [];

  onIntrestSelect(int i) {
    print("selec");
    debugPrint("cvxv");
    inters[i].isSelect = !inters[i].isSelect;
    emit(state.copyWith(subIntres: subIn));
    for(var i in inters){
      if(i.isSelect == true){
        tempList.add(1);
      }else{
        // print("false");
        tempList.clear();
      }
    }
    print("stateeee ${tempList.length}");
  }

  onSubIntSelect(int i, int j) {
    inters[i].intrestSubCategory[j].isSelect =
        !inters[i].intrestSubCategory[j].isSelect;
    subCatId.add(inters[i].intrestSubCategory[j].interestSubCategoryId);
    emit(state.copyWith(intrestt: inters));
  }

  List<UserInterest> intt = [];
  List<UserSubInterestDto> subInt = [];

  String countryName = '';
  String cityName = '';

  getCountryCityName()async{
    http.Response res = await http.get(Uri.parse("http://ip-api.com/json"));
    var de = json.decode(res.body);
    countryName = de['country'];
    cityName = de['city'];
  }

  setLoading(){
    emit(state.copyWith(erro: "",loadingSt: false));
  }
  createProfile(BuildContext context){
    emit(state.copyWith(erro: ""));
    if(state.workName == null){
      emit(state.copyWith(erro: "Work is required"));
    }else if(state.religion == null){
      emit(state.copyWith(erro: "Religion is required"));
    }else if(state.heightInches == null){
      emit(state.copyWith(erro: "Height is required"));
    }else if(state.hairColor == null){
      emit(state.copyWith(erro: "Hair Colour is required"));
    }else if(state.educationName == null) {
      emit(state.copyWith(erro: "Education is required"));
    }else{
      emit(state.copyWith(erro: "",loadingSt: true));
      Map<String,String> mapData = {
        "userName": state.fullName!,
        "email": state.email!,
        "DOB": state.dateOfBirth.toString(),
        "martialStatus": state.relationVal,
        "gender": state.genderVal,
        "country": countryName,
        'city':cityName,
        "lat": lat.toString(),
        "long": long.toString(),
        "password": state.password!,
        'phoneNo':state.phoneNo!,
        'hairColor':state.hairColor!,
        'height':"${state.heightfeet!}.${state.heightInches!}",
        'education_title':state.educationName!,
        'education_level': state.educationLevel!,
        'education_startYear':state.educationStartDate.toString(),
        'education_location':state.educationLocation!,
        'work_title':state.jobTitle!,
        'work_description':state.workDescription!,
        'work_startDate':state.workStartDate.toString(),
        'workspace_name':state.workName ?? "",
        'current_working':state.currentlyWorking!,
        'work_endDate':state.workEndDate.toString(),
        'religion': state.religion!,
        'work_location': state.workLocation ?? "",
        'education_endDate':state.educationEndDate.toString()
      };
      print(mapData);
      repository.createProfile(mapData, File(state.profileImagePath!)).then((value){
        emit(state.copyWith(loadingSt: false,erro: ""));
        print(value.body);
        var dec = json.decode(value.body);
        if(dec['message'] == "registered successfully"){
          print("Well");
          print(dec['data']['userId']);
          userID = dec['data']['userId'];
          print(dec['data']['userId']);
          saveUserIntereseSubCat();
          loginUser(context);
          saveUSerId(dec['data']['userId']);
        }else if(dec['message'] == "required fields are missing"){
          emit(state.copyWith(erro: "Required Fields Are missing"));
        }else if(dec['message'] == "The email has already been taken."){
          emit(state.copyWith(erro: "This email has already been taken."));
        }else{
          emit(state.copyWith(erro: "Something went wrong try again"));
        }
      });
    }


  }


  List<String> days = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];
  createBusinessProfile(BuildContext context){
    print("Clicked");
    emit(state.copyWith(erro: "",loadingSt: true));
    Map<String,String> mapData = {
      "businessName": state.fullName!,
      "email": state.email!,
      "ownerName": state.ownerName.toString(),
      "vatNumber": state.vatNo.toString(),
      "businessContact": state.phoneNo!,
      "country": countryName,
      'city':cityName,
      "latitude": lat.toString(),
      "longitude": long.toString(),
      "password": state.password!,
      "isAlwaysOpen": state.alwaysOpen ? "1":"0",
      "businessType": state.profileCategoryVal,
      "address": state.businessLocation.text,
      'day':"${days[0]},${days[1]},${days[2]},${days[3]},${days[4]},${days[5]},${days[6]}",
      'openTime': "${state.closedAllDaySaturday ? "Closed":state.saturdayStartTime.format(context)},${state.closedAllDaySunday ? "Closed":state.sundaryStartTime.format(context)},${state.closedAllDayMonday ? "Closed":state.mondayStartTime.format(context)},${state.closedAllDayTuesday ? "Closed":state.tuesdayStartTime.format(context)},${state.closedAllDayWednesDay ? "Closed":state.wednesdayStartTime.format(context)},${state.closedAllDayThursday ? "Closed":state.thursdayStartTime.format(context)},${state.closedAllDayFriday ? "Closed":state.fridayStartTime.format(context)}",
      'closeTime': "${state.closedAllDaySaturday ? "Closed":state.saturdayEndTime.format(context)},${state.closedAllDaySunday ? "Closed":state.sundayEndTime.format(context)},${state.closedAllDayMonday ? "Closed":state.mondayEndTime.format(context)},${state.closedAllDayTuesday ? "Closed":state.tuesdayEndTime.format(context)},${state.closedAllDayWednesDay ? "Closed":state.wednesdayEndTime.format(context)},${state.closedAllDayThursday ? "Closed":state.thursdayEndTime.format(context)},${state.closedAllDayFriday ? "Closed":state.firdayEndTime.format(context)}",
    };
    print("open time ${state.saturdayStartTime.format(context)},${state.sundaryStartTime.format(context)},${state.mondayStartTime.format(context)},${state.tuesdayStartTime.format(context)},${state.wednesdayStartTime.format(context)},${state.thursdayStartTime.format(context)},${state.fridayStartTime.format(context)}");
    print("profile${state.profileImagePath!} paht cover ${state.businessCoverPath!}");
    repository.createBusinessProfile(mapData, File(state.profileImagePath!),File(state.businessCoverPath!)).then((value){
      emit(state.copyWith(loadingSt: false,erro: ""));
      print(value.body);
      var dec = json.decode(value.body);
      userID = dec['userId'];
      print(dec['userId']);
      print(value.body);
      saveUSerId(dec['userId']);
      getFromShared();
      saveUserIntereseSubCat();
      loginUser(context);
      if(dec['message'] == "Data successfuly save"){
        print("Well");
        saveUserIntereseSubCat();
        loginUser(context);
        // Navigator.pushNamedAndRemoveUntil(context, loadingPage, (route) => false);
      }else{
        emit(state.copyWith(erro: "Email Already Exist!"));
      }
    });
  }

  imageNotSelected(){
    emit(state.copyWith(erro: "Please Select Profile Image"));
  }

  saveUserIntereseSubCat(){
    Map<String,dynamic> data = {};
    int i = 0;
    subCatId.forEach((element) {
      String interestSubCategoryId = "${element}";
      data['interestSubCategoryId[$i]'] = interestSubCategoryId.toString();
      i++;
    });
    data['userId'] = userID!;
    repository.addSubInterestCat(data).then((value){
      print(value.body);
    });
    print(data);
  }

  FirebaseMessaging fcm = FirebaseMessaging.instance;
  String fcmToken = '';

  getFCM(){
    fcm.getToken().then((value){
      fcmToken = value!;
      print(fcmToken);
    });
  }


  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {

        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
          print(deviceData);
        } else{
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
          print(deviceData);
        }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

      _deviceData = deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release, //yeah chahye
      'board': build.board, //yeah chahye
      'id': build.id, // yeah chahye
    };
  }

  int getRandom(){
    return Random().nextInt(5000);
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName, //yeah chahye
      'systemVersion': data.systemVersion, // yeah chahye
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
 
  intiShared() async {
    pre = await SharedPreferences.getInstance();
  }
  setHobby(String val){
    emit(state.copyWith(hobbyy: val));
  }
  setRelegion(String val){
    emit(state.copyWith(religionn: val));
  }



  saveUSerId(String id) async {
    pre.setString('id', id);
    getFromShared();
  }

  saveUSerEmail(String emaillllllllll) async {
    pre.setString('email', emaillllllllll);
    getFromShared();
  }
  saveisBusiness(bool isBusiness) async {
    pre.setBool('isBusiness', isBusiness);
    getFromShared();
  }

  clearShared(){
    pre.clear();
  }

  clearCallInfo(){
    pre.setString('callerName' ,"");
    pre.setString('callerId','');
    pre.setString('channelId','');
    pre.setString('callTime','');
    pre.setString('avatar','');
    pre.setString('isAudio','false');
  }

  saveAuthToken(String token) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('token', token);
    authorizationToken = token;
  }

  getFromShared(){
    userID = pre.getString('id');
    accesToken = pre.getString('token');
    isBusinessShared = pre.getBool('isBusiness');
    userEmail = pre.getString('email');
    print("User $userID");
    print("Tojekee $accesToken");
  }

  loginUser(BuildContext context) {
    emit(state.copyWith(erro: '', loadingSt: true));
    Map<String, Object> json = {
      "email": state.email!,
      "password": state.password!,
      "deviceUUID": Io.Platform.isAndroid ? _deviceData['id'].toString() : "asdfdvsd${getRandom()}",
      "deviceName": Io.Platform.isAndroid ? _deviceData['device'].toString() : _deviceData['name'],
      "deviceOS": Io.Platform.isAndroid ? "Android" : "IOS",
      "osVersion": Io.Platform.isAndroid ? _deviceData['version.release'].toString() : _deviceData['systemVersion'],
      "fcmToken": fcmToken,
    };
    repository.loginUser(json).then((value) {
      emit(state.copyWith(loadingSt: false));
      print(value.body);
      var deco = jsonDecode(value.body);
      if (deco['message'] == 'Data availabe') {
        accesToken = deco['data']['token'];
        saveAuthToken(deco['data']['token']);
        saveUSerId(deco['data']['userId']);
        saveUSerEmail(deco['data']['email']);
        print("yth");
        saveisBusiness(deco['data']['userTypeId'] == '1' ? false : true);
        //valid confition
          Navigator.pushNamedAndRemoveUntil(context, splashNormal, (route) => false);
      } else {
        emit(state.copyWith(erro: "Email or Password incorrect", loadingSt: false));
      }
    });
  }

  assignName(String name) {
    emit(state.copyWith(fullNamee: name));
  }

  assignEmail(String email) {
    emit(state.copyWith(emaill: email));
  }

  assignPhone(String phone) {
    emit(state.copyWith(phoneNOO: phone));
  }

  assignPassword(String pass) {
    emit(state.copyWith(passwordd: pass));
  }

  assignVat(String vat) {
    emit(state.copyWith(vatNoo: vat));
  }

  assignOwnerName(String name) {
    emit(state.copyWith(ownerNamee: name));
  }

  assignBusinessLocation(String loca) {
    emit(state.copyWith(businessLocationn: TextEditingController(text: loca)));
  }
  assignPhoneNo(String phone) {
    emit(state.copyWith(phoneNOO: phone));
  }

  assignHeightFeet(String height) {
    emit(state.copyWith(heightfeett: height));
  }
  assignHeightInches(String height) {
    emit(state.copyWith(heightInchess: height));
  }

  assignHairColor(String colorTxt,Color color) {
    emit(state.copyWith(hairColorr: colorTxt,hairColorMateriall: color));
  }

  static Uint8List? byteimage;


  getImage(bool isCover) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = Io.File(image!.path).readAsBytesSync();
    byteimage = await image.readAsBytes();
    base64Image = base64Encode(bytes);
    cropImage(File(image.path),isCover);
  }

  getCoverImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = Io.File(image!.path).readAsBytesSync();
    byteimage = await image.readAsBytes();
    base64Image = base64Encode(bytes);
    cropCoverImage(File(image.path));
  }

  getImageCamera(bool isCover) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    final bytes = Io.File(image!.path).readAsBytesSync();
    byteimage = await image.readAsBytes();
    base64Image = base64Encode(bytes);
    cropImage(File(image.path),isCover);
  }

  Future<Null> cropImage(File imageFile,bool isCover)async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      cropStyle: isCover ? CropStyle.rectangle:CropStyle.circle
    );
    if(isCover){
      emit(state.copyWith(businessCoverPathh: croppedFile!.path));
    }else{
    emit(state.copyWith(ProfileImagePathset: croppedFile!.path));
    }
  }

  Future<Null> cropCoverImage(File imageFile)async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle
    );
    if(croppedFile != null){
      emit(state.copyWith(coverImagee: croppedFile.path));
    }else{
      emit(state.copyWith(coverImagee: imageFile.path));
    }
  }


  pushNotification(String userIdd,String tokenn,String reciverId,String notiType,String subject,String body,String id){
    print(userIdd);
    print(tokenn);
    Map<String,dynamic> map = {
      'senderId':userIdd,
      'receiverId': reciverId,
      'notificationTypeId': notiType,
      'subject': subject == "" ? "Hapiverse" : subject,
      'body': body,
      'id':id,
      'token':tokenn
    };
    print(map);
    repository.pushNotification(userIdd, map, tokenn).then((value){
      print("send notifiation response ${value.body}");
    });
  }

  fetchNotificationList(String userIddd,String token){
    int count = 0;
    repository.fetchNotification(userIddd, {'userId':userIddd}, token).then((value){
      print(value.body);
      var data = notificationModelFromJson(value.body);
      for(var i in data.data){
        if(i.haveSeen == '0'){
          count++;
        }
      }
      print("Counttt------- $count");
      emit(state.copyWith(notificationListt: data.data,notificaitionCountt: count.toString()));
    });
  }

  addViewNotification(String userIddd,String token,String notId){
    print("AddView Not");
    repository.addViewNotification(userIddd,notId, token).then((value){
      print("print ${value.body}");
      fetchNotificationList(userIddd, token);
    });
  }

  checkAccountStatus(String userIddd,String token){
    repository.checkAccountStatus(userIddd, token).then((value){
      print(value.body);
      var de = json.decode(value.body);
      emit(state.copyWith(isAccountPrivatee: de['data']['isPrivate'] == "0" ? false:true));
    });
  }

  addRemoveAccountStatus(bool isPrivate){
    print(isPrivate);
    repository.addRemovePrivateAccount(userID!, accesToken!,isPrivate).then((value){
      print(value.body);
      checkAccountStatus(userID!, accesToken!);
    });
  }

  verifyEmail(BuildContext context){
    emit(state.copyWith(erro: "",loadingSt: true));
    try{
    repository.verifyEmail(state.email!).then((response){
      emit(state.copyWith(erro: "",loadingSt: false));
      print(response.body);
      var de = json.decode(response.body);
      if(de['message'] == "Already Exist"){
        emit(state.copyWith(erro: "This email is already registered with diffirent account"));
      }else if(de['message'] == "Data successfuly save"){
        nextScreen(context, OTPVerification());
        Fluttertoast.showToast(msg: "Code sent successfully");
        print(de['verificationCode']);
        var code = de['verificationCode'];
        emit(state.copyWith(verifyEmailErrorr: de['message'],verifyCodee: code.toString()));
      }else{
        emit(state.copyWith(erro: "Something went wrong please Try Again"));
      }
    });
    }catch (e){
      emit(state.copyWith(erro: "Something went wrong $e"));
    }
  }


   stripePaymentSignUp(String amount,bool isBusinessss,BuildContext context,Map<String,dynamic> cardInfo){
     emit(state.copyWith(erro: "",loadingSt: true));
    Map<String,dynamic> map = {
      'card_no': cardInfo['card_no'],
      'expiry_month': cardInfo['expiry_month'],
      'expiry_year': cardInfo['expiry_year'],
      'cvv': cardInfo['cvv'],
      'amount': amount,
      'description': "Plan Payment",
      'email':state.email,
    };
    repository.stripePayment(map).then((value){
      emit(state.copyWith(loadingSt: false));
      print(value.body);
      var de = json.decode(value.body);
      if(de['message'] == "successfully charged"){
          addUserPlanSignUp(cardInfo['planId'],context,isBusinessss);
          // nextScreenPushReplacement(context, LoadingPage());
      }else{
        emit(state.copyWith(erro: de['message']));
      }
    });
  }

  stripePaymentUpgrade(String amount,BuildContext context,Map<String,dynamic> cardInfo){
    emit(state.copyWith(erro: "",loadingSt: true));
    Map<String,dynamic> map = {
      'card_no': cardInfo['card_no'],
      'expiry_month': cardInfo['expiry_month'],
      'expiry_year': cardInfo['expiry_year'],
      'cvv': cardInfo['cvv'],
      'amount': amount,
      'description': "Plan Payment",
      'email':userID,
    };
    print(map);
    repository.stripePayment(map).then((value){
      emit(state.copyWith(loadingSt: false));
      print(value.body);
      var de = json.decode(value.body);
      if(de['message'] == "successfully charged"){
        addUserPlanUpgrade(cardInfo['planId'],context);
        // nextScreenPushReplacement(context, LoadingPage());
      }else{
        emit(state.copyWith(erro: de['message']));
      }
    });
  }


  addUserPlanUpgrade(String planID,BuildContext context){
    DateTime date = DateTime.now();
    Map<String,dynamic> map = {
      'email': userID,
      'planId': planID,
      'planStartDate': date.toString(),
      'planEndDate': DateTime(date.year ,date.month + 1,date.day).toString(),
    };
    repository.addUserPlan(map).then((response){
      print(response.body);
      var de = json.decode(response.body);
      if(de['message'] == "Data successfuly save"){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashNormalPage()), (route) => false);
      }else{

      }
    });
  }

  addUserPlanSignUp(String planID,BuildContext context,bool isBusiess){
    DateTime date = DateTime.now();
    Map<String,dynamic> map = {
      'email': state.email!,
      'planId': planID,
      'planStartDate': date.toString(),
      'planEndDate': DateTime(date.year + 1,date.month,date.day).toString(),
    };
    repository.addUserPlan(map).then((response){
      print(response.body);
      var de = json.decode(response.body);
      if(de['message'] == "Data successfuly save"){
        if(isBusiess){
          nextScreen(context, SignUpBusiness());
        }else{
          nextScreen(context, SignUpUser());
        }
      }else{
        addUserPlanSignUp(planID, context, isBusiess);
      }
    });
  }

  updatePlan(String planIDd,String emaillll,BuildContext context){
    DateTime date = DateTime.now();
    Map<String,dynamic> map = {
      'email': emaillll,
      'planId': planIDd,
      'planStartDate': date.toString(),
      'planEndDate': DateTime(date.year,date.month + 1,date.day).toString(),
    };
    repository.addUserPlan(map).then((response){
      print(response.body);
      var de = json.decode(response.body);
      if(de['message'] == 'Data successfuly save'){
        showDialog(context: context, builder: (c){
          return const CupertinoAlertDialog(
            title: Text("Redirecting to Plan Features"),
            content: CupertinoActivityIndicator(),
          );
        });
        Future.delayed(const Duration(seconds: 2),(){
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SplashNormalPage()), (route) => false);
        });
      }else{
        Fluttertoast.showToast(msg: "Something went wrong try Again");
      }
    });
  }

  checkRefferalCode(String code,BuildContext context){
    showDialog(
      // barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });
    repository.checkRefferalCode(code).then((response){
      print(response.body);
      Navigator.pop(context);
      print(response.body);
      var de = json.decode(response.body);
      print(de);
      if(de['message'] == 'Data availabe'){
        print(de['data']['accountType']);
        emit(state.copyWith(supponsorAccountTypee: de['data']['accountType']));
        nextScreen(context, EnterEmail());
      }else if(de['alreadyAccountCreated'] == "1"){
        emit(state.copyWith(verifyEmailErrorr: "Already Created Account with this code"));
      }else{
        emit(state.copyWith(verifyEmailErrorr: "Invalid referal Code!"));
      }
    });
  }

  FetchPlan? fetchPlanModel;

  fetchPlan(){
    // users plans

    // id    planName
    // 5      goldFreee
    // 6      Platinum
    // 7      Daimond
    // 8      Vip/Celebrity

    // business plans

    // id       planName
    //   1         Local
    //   2         Regional
    //   3          National
    //   4          Global

    print("$fetchMyPlanUrl$userID");
    repository.callGetApi("$fetchMyPlanUrl$userID").then((reponse){
      print("myPlan ${reponse.body}");
      var de = json.decode(reponse.body);
      var planId = de['data'][0]['planId'];
      emit(state.copyWith(planIdd: planId));
    });

  }

}
