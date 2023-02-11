import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiverse/data/model/user_interest_model_profile.dart';
import 'package:happiverse/data/model/user_order_model.dart';
import 'package:happiverse/utils/user_url.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/business_tools/business_tools.dart';
import 'package:happiverse/views/profile/profile_more/orders_page.dart';
import '../../data/model/CardDataModel.dart';
import '../../data/model/business_profile_model.dart';
import '../../data/model/covid_record_model.dart';
import '../../data/model/fetch_business_meeting.dart';
import '../../data/model/fetch_card_model.dart';
import '../../data/model/fetch_friend_model.dart';
import '../../data/model/fetch_job_model.dart';
import '../../data/model/fetch_photo_album.dart';
import '../../data/model/get_all_my_post_model.dart';
import '../../data/model/interest_select_model.dart';
import '../../data/model/location_share_to_other.dart';
import '../../data/model/music_model.dart';
import '../../data/model/request_location_model.dart';
import '../../data/repository/business_tools_repository.dart';
import '../../data/repository/profile_repository.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import '../../views/bottom_nav.dart';
import '../register/register_cubit.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(
    relationDropList: relationStatusList,
    genderList: genderList,
    isProfileUpdating: false,
    businessRatingValue: 2.5,
    audioPlayer: audioPlayer,
    isPlaying: false,
    progress: Duration(),
    musicUrl: "",
    musicTitle: "Unknown Music",
    musicLength: Duration(),
    musicImage: "https://static.vecteezy.com/system/resources/previews/001/200/758/original/music-note-png.png",
    musicArtist: "Unknown Artist",
    notNowClieked: true,
    isMapMoving: false,
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
    closedAllDayWednesDay: false,
    closedAllDayTuesday: false,
    closedAllDayThursday: false,
    closedAllDaySunday: false,
    closedAllDaySaturday: false,
    closedAllDayMonday: false,
    closedAllDayFriday: false,
    businessLocationMArker: {},
    isLoading: false
  ));

  static AudioPlayer audioPlayer = AudioPlayer();

  final repository = ProfileRepository();
  final businessToolRepository = BusinessToolsRepository();
  final registerBloc = RegisterCubit();
  static List<String> relationStatusList = [
    'Single',
    'Engaged',
    'Married',
    'Dating',
    'Divorced',
  ];

  String get userName => state.profileName!;
  String get userImage => state.profileImage!;
  String get businessLogo => state.businessProfile!.logoImageUrl!;
  String get businessEmail => state.businessProfile!.email!;
  // String get userEmail => state!;
  bool get isPlaying => state.isPlaying;
  int get musicIndex => state.musicIndex!;

  String? newCityVal;
  String? newCountryVal;


  changeRelationDrop(val) {
    emit(state.copyWith(relationShipp: val));
  }

  static List<String> genderList = [
    'Male',
    'Female',
  ];

  changeGenderDrop(val) {
    emit(state.copyWith(genderr: val));
  }

  setNotNowClicked(){
    emit(state.copyWith(notNowClickedd: true));
  }

  hoursSelected(){
    emit(state.copyWith(isHoursSelectedd:true));
  }
  selectAlwayBusinessHours(bool val){
    emit(state.copyWith(alwaysOpenn: val));
  }

  setBusinessMarker(bool isFromProfile,{Marker? marker})async{
    Set<Marker> markers = {};
    String address = "";
    if(isFromProfile){
      print("LATILOGN ${LatLng(double.parse(state.businessProfile!.latitude!),double.parse(state.businessProfile!.longitude!))}");
      animateCamera(LatLng(double.parse(state.businessProfile!.latitude!),double.parse(state.businessProfile!.longitude!)));
      markers.add(Marker(markerId: MarkerId(DateTime.now().toString()),position: LatLng(double.parse(state.businessProfile!.latitude!),double.parse(state.businessProfile!.longitude!))));
       await http.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${state.businessProfile!.latitude!},${state.businessProfile!.longitude!}&key=AIzaSyCRez6eZn33IUzPg54m-BZnL5yfPePMBLU")).then((value){
        var de = jsonDecode(value.body);
        address = de['results'][0]['formatted_address'];
        emit(state.copyWith(businessAddresss: address));
      });
    }else{
      markers.add(marker!);
      animateCamera(marker.position);
      await http.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${marker.position.latitude},${marker.position.longitude}&key=AIzaSyCRez6eZn33IUzPg54m-BZnL5yfPePMBLU")).then((value){
        var de = jsonDecode(value.body);
        address = de['results'][0]['formatted_address'];
        emit(state.copyWith(businessAddresss: address));
      });
    }
    emit(state.copyWith(businessMarker: markers));
  }

  Completer<GoogleMapController> completer = Completer();
  GoogleMapController? controllerr;

  onMapCreated(GoogleMapController controller) {
    controllerr = controller;
    completer.complete(controller);
    emit(state.copyWith(controllerr: controller,completerr: completer));

  }


  void animateCamera(LatLng position) async {
    controllerr!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 17.0,
    )));
    emit(state.copyWith(controllerr: controllerr));
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

  List<UserInterestProfile> userInterest = [];

  fetchInterests(String userId)async{
    http.Response response = await http.post(Uri.parse("https://www.hapiverse.com/ci_api/API/v1/user/FetchUserInterest"),body: {
      'userId':userId
    });
    var data = userInterestModelProfileFromJson(response.body);
    userInterest = data.data;
    emit(state.copyWith(userInterestt: userInterest));
  }

  selectUnselectInterests(int i){
    userInterest[i].isSelected =  !userInterest[i].isSelected;
    emit(state.copyWith(userInterestt: userInterest));
  }

  fetchMyPRofile(String id,String token){
    print(id);
    print(token);
    repository.getProfile(id,token).then((response){
      print(response.body);
      var deco = json.decode(response.body);
      var d = deco['data'];
      emit(state.copyWith(hobbyy: "FootBall",cityy: d['city'].toString(),
        countryy: d['country'],followerss: d['follower'],followingg: d['following'],
        genderr: d['gender'],profileImagee: d['profileImageUrl'],
        profileNamee: d['userName'],
      relationShipp: d['martialStatus'],totalPostt: d['totalPosts'],
        dateOfBirt: d['DOB'],
        phoneNoo: d['phoneNo'],
        avatarTypee: d['avatarType'],
        flatColorr: d['flatColor'],
        profileImageTextt: d['profileImageText'],
        firstGredientColorr: d['firstgredientcolor'],
        secondGredientColorr: d['secondgredientcolor'],
        heightt: d['height'],
        religionn: d['religion'],
        workNamee: d['occupation'][0]['title'],
        workLocationn: d['occupation'][0]['location'],
        workEndDatee: d['occupation'][0]['endDate'],
        workStartDatee: d['occupation'][0]['startDate'],
        workDescriptionn: d['occupation'][0]['description'],
        workTitlee: d['occupation'][0]['title'],
        currentlyWorkingg: d['occupation'][0]['current_working'],
        educationEndYaerr: d['education'][0]['endYear'],
        educationLevell: d['education'][0]['level'],
        educationLocationn: d['education'][0]['location'],
        educationNamee: d['education'][0]['title'],
        educationStartYearr: d['education'][0]['startDate'],
        currentlyReadingg: d['education'][0]['currently_studying'],
        hasVerifiedd: d['hasVerified'],
        badgee: d['badge'],
        ),
      );
      print(state.city);
      Future.delayed(const Duration(milliseconds: 100),(){
        if(d['country'] == null || d['country'] == '' || d['city'] == null || d['city'] == ''){
          emit(state.copyWith(notNowClickedd: false));
          print("This Called pppppp");
        }
      });
    });
  }

  List<FetchFriend> myFriendsList = [];
  List<FetchFriend> otherFriendsList = [];

  getMyFriendList(String id,String token){
    repository.fetchMyFriend(id,token).then((response){
      var dec = json.decode(response.body);
      if(dec['message'] == "Data not availabe"){
        emit(state.copyWith(myFriendsListt: []));
      }else{
        var data = fetchFriendModelFromJson(response.body);
        myFriendsList = data.data;
        emit(state.copyWith(myFriendsListt: data.data));
        print(response.body);
      }
    });
  }

  getOtherFriends(String id,String token,String otherUserid){
    repository.fetchOtherFriend(id,token,otherUserid).then((response){
      var dec = json.decode(response.body);
      print("Other Friend${response.body}");
      if(dec['message'] == "Data not availabe"){
        emit(state.copyWith(otherFriendsListt: []));
      }else{
        var data = fetchFriendModelFromJson(response.body);
        otherFriendsList = data.data;
        emit(state.copyWith(otherFriendsListt: data.data));
        print(response.body);
      }

    });
  }

  fetchOtherProfile(String id,String token,String myUserId){
    repository.getOtherProfile(id,token,myUserId).then((response){
      print("sdf ${response.body}");
      emit(state.copyWith(otherProfileInfoResponsee:response));
    });
  }
  List<GetMyAllPosts> allOtherPosts = [];

  addFollow(String userId,String followerId,String token,BuildContext context,bool isBusiness){
    showDialog(context: context, builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });

    // authBloc.pushNotification(userId,token, reciverID,"2", "liked your post", "${DateTime.now()}",postId);
    registerBloc.pushNotification(userId, token, followerId, "1", "Hapiverse", "${isBusiness ? state.businessProfile!.businessName : state.profileName} Follow you", userId);
    repository.addFollower(followerId, token, userId).then((response){
      print(response.body);
      fetchOtherProfile(followerId, token, userId);
      Navigator.pop(context);
    });
  }
  List<GetMyAllPosts>? allPhotos = [];
  fetchOtherAllPost(String id,String token,String myUserId){
    allPhotos!.clear();
    repository.getOtherAllPorst(id,token,myUserId).then((response){
      var data = getAllMyPostsModelFromJson(response.body);
      print("other post${response.body}");
      for(var i in data.data){
        if(i.postType == "image"){
          print("YEs");
          allPhotos!.add(i);
        }
      }
      emit(state.copyWith(allOtherPostss:data.data,allOtherPhotoss: allPhotos));
    });
  }

  List<GetMyAllPosts> allMYphotos = [];
  fetchAllMyPosts(String token,String myUserId){
    repository.fetchMyPosts(token,myUserId).then((response){
      var data = getAllMyPostsModelFromJson(response.body);
      for(var i in data.data){
        if(i.postType == 'image'){
          allMYphotos.add(i);
        }
      }
      print(response.body);
      emit(state.copyWith(allMyPostss:data.data,allMyPhotoss: allMYphotos));
    });
  }

  XFile? profileImage;
  getImageGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(state.copyWith(profileUpdatedImagee: File(image!.path)));
  }
  getImageCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    emit(state.copyWith(profileUpdatedImagee: File(image!.path)));
  }

  Future<Null> cropImage()async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: state.profileUpdatedImage!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
    );
    emit(state.copyWith(profileUpdatedImagee: File(croppedFile!.path)));
  }

  updateUserProfileImage(String userId,String token,BuildContext context){
    emit(state.copyWith(isProfileUpdatingg: true));
    repository.editUserProfileImage(userId, File(state.profileUpdatedImage!.path), token).then((response){
      var dec = json.decode(response.body);
      if(dec['message'] == "Data successfuly save"){
        Fluttertoast.showToast(msg: "Profile Image Updated");
        fetchMyPRofile(userId, token);
        emit(state.copyWith(isProfileUpdatingg: false));
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }

  setProfileName(String profileName){
    emit(state.copyWith(profileNamee: profileName));
  }
  setCityVal(String cityVal){
    newCityVal = cityVal;
    // emit(state.copyWith(cityy: cityVal));
    print("setted");
  }
  setCountryVal(String countryVal){
    newCountryVal = countryVal;
    emit(state.copyWith(countryy: countryVal));
  }
  setPhoneNum(String phoneNo){
    emit(state.copyWith(phoneNoo: phoneNo));
  }

  updateUserProfileInfo(String userId,String accessToken){
    print(newCityVal);
    print(state.city);
    emit(state.copyWith(isProfileUpdatingg: true));
    Map<String,String> map = {
      'userName': state.profileName!,
      'city': newCityVal ?? state.city!,
      'country': newCountryVal ?? state.country ?? "",
      'phoneNo':state.phoneNo!,
      'gender': state.gender!,
      'martialStatus':state.relationShip ?? "",
      'userId': userId
    };
    repository.updateUserProfileInfo(map, userId, accessToken).then((response){
      emit(state.copyWith(isProfileUpdatingg: false));
      var dec = json.decode(response.body);
      print(dec);
      if(dec['message'] == 'Data successfuly save'){
        Fluttertoast.showToast(msg: "Profile Update Successfully");
      }else{
        Fluttertoast.showToast(msg: "Something went wrong try again");
      }
      fetchMyPRofile(userId, accessToken);
    });
  }

  addCovidRecord(String userId,String accressToken){
    Map<String,dynamic> map = {
      'userId': userId,
      'hospitalName': state.healthHospital!,
      'date': state.healthDate.toString(),
      'covidStatus': state.healthStatus!,
    };
    repository.addCovidRecord(map, userId, accressToken).then((response){
      print(response.body);
      fetchCovidRecord(userId, accressToken);
    });
   }

   fetchCovidRecord(String userId,String accressToken){
    repository.fetchCovidRecord(userId, accressToken).then((response){
      print(response.body);
      print("Covid Data");
      var de = json.decode(response.body);
      if(de['data'].length <= 0){
        print("DAta khali hai chill kro ");
        emit(state.copyWith(covidRecordListt: []));
      }else{
        print("sub ok hai ");
        var data = covidRecordModelFromJson(response.body);
        emit(state.copyWith(covidRecordListt: data.data));
      }
    });
   }

   assignHospitalName(String val){
    emit(state.copyWith(healthHospitall: val));
   }

  assignHealthDate(DateTime val){
    emit(state.copyWith(healthDatee: val));
  }
  assignCovidStatus(String val){
    emit(state.copyWith(healthStatuss: val));
  }

  playMusic(String url,int length,int index){
    audioPlayer.play(url);
    emit(state.copyWith(audioPlayerr: audioPlayer,musicLengthh: Duration(milliseconds: length),isPlayingg: true,musicIndexx: index));
    audioPlayer.onDurationChanged.listen((Duration  p) => {
      emit(state.copyWith(progresss: p))
    });
    // audioPlayer.setNotification(title: state.musicTitle,imageUrl: state.musicImage,duration: state.progress);
  }

  pauseMusic(){
    audioPlayer.pause();
    emit(state.copyWith(audioPlayerr: audioPlayer));
  }
  resumeMusic(){
    audioPlayer.resume();
    emit(state.copyWith(audioPlayerr: audioPlayer));
  }

  seekMusic(Duration progress){
    audioPlayer.seek(progress);
    emit(state.copyWith(progresss: progress,audioPlayerr: audioPlayer));
  }

  musicPlayingState(bool val){
    if(val){
      audioPlayer.resume();
    }else{
      audioPlayer.pause();
    }
    emit(state.copyWith(isPlayingg: val,audioPlayerr: audioPlayer));
  }

  setCurrentMusicVal(String title,String artist,String image,String url){
    emit(state.copyWith(musicTitlee: title,musicArtistt: artist,musicUrll: url,musicImagee: image));
  }

  playNextMusic(){
    if(state.musicTrack!.length > state.musicIndex!){
      var music = state.musicTrack![state.musicIndex! + 1];
      setCurrentMusicVal(music.album!.name!,music.artists![0].name!,music.album!.images![0].url!,music.previewUrl!);
      playMusic(music.previewUrl!,music.durationMs!,state.musicIndex! + 1);
    }
  }
  playPreviousMusic(){
    if(state.musicIndex! > 0){
      var music = state.musicTrack![state.musicIndex! - 1];
      setCurrentMusicVal(music.album!.name!,music.artists![0].name!,music.album!.images![0].url!,music.previewUrl!);
      playMusic(music.previewUrl!,music.durationMs!,state.musicIndex! - 1);
    }
  }

  replayMusic(){
    audioPlayer.seek(const Duration(seconds: 0));
    emit(state.copyWith(audioPlayerr: audioPlayer));
  }
  getStealthStatus(String userId,String token){
    repository.getStealthStatus(userId, token, false).then((response){
      print(response.body);
      var de = json.decode(response.body);
      emit(state.copyWith(stealthModeEnablee: de['data']['isStealth'] == '0' ? false:true,stealthModeTimeLeftt: de['data']['stealthDuration']));
    });

  }
  addRemoveStealthStatus(String userId,String token,String duration){
    repository.addRemoveStealthStatus(userId, token, state.stealthModeEnable! ? true:false,false,duration).then((response){
      print(response.body);
      getStealthStatus(userId,token);
    });
    // emit(state.copyWith(stealthModeEnablee: !state.stealthModeEnable!));
  }

  fetchLocationRequest(String userId,String token,bool isMyRequests){
    repository.fetchLocationRequests(userId, token, isMyRequests ? '1':'0').then((response){
      print(response.body);
      var de = json.decode(response.body);
      print(de);
      if(de['message'] == 'Data availabe'){
        var data = requestLocationModelFromJson(response.body);
        if(isMyRequests){
          emit(state.copyWith(myLocationRequeststoOtherr: data.data));
        }else{
          emit(state.copyWith(otherLocationRequestToMee: data.data));
        }
      }else{
        emit(state.copyWith(myLocationRequeststoOtherr: [],otherLocationRequestToMee: []));
      }

    });
  }

  rejectLocationRequest(String userID,String token,String requestId){
    repository.rejectLocationRequest(userID, token, requestId).then((response){
      print(response.body);
      fetchLocationRequest(userID, token, false);
    });
  }

  acceptLocationRequest(String userID,String token,double lat,double long,String? requestId,BuildContext context)async{
    print(requestId);
    print(lat);
    await http.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${long}&key=${Utils.placesAPIKey}")).then((value){
      var de = jsonDecode(value.body);
      print(de);
      var address = de['results'][0]['formatted_address'];
      Map<String,dynamic> map = {
        'address':address,
        'lat': lat.toString(),
        'long': long.toString(),
        'requestId': requestId ?? "",
      };
      repository.acceptLocationRequest(userID, token, map).then((response){
        print(response.body);
        var de = json.decode(response.body);
        if(de['message'] == 'Data successfuly save'){
          fetchLocationRequest(userID, token, false);
          Fluttertoast.showToast(msg: "Location Shared Successfully");
          Navigator.pop(context);
        }else{
          Fluttertoast.showToast(msg: "Something went wrong try again!");
        }
      });
    });

  }

  requestLocation(String userId,String token,String requesterId,bool isLive){
    Map<String,dynamic> map = {
      'userId': userId,
      'token': token,
      'requesterId': requesterId,
      'locationType':isLive ? '1':'0',
      'status':'pending',
    };
    repository.requestLocation(map).then((response){
      var de = json.decode(response.body);
      if(de['message'] == 'Data successfuly save'){
        Fluttertoast.showToast(msg: "Location Request Has been sent");
      }
    });
  }

  deleteLocationRequest(String userId,String token,String requestId){
    repository.deleteLocationRequest(userId, token, requestId).then((response){
      var de = json.decode(response.body);
      print(de);
      fetchLocationRequest(userId, token, false);
      if(de['message'] == ''){}
    });
  }

  deleteLocationSharingSingle(String userId,String token,String id){
    print("$deleteLocationRequestUrl$id");
    repository.callDeletApi({'userId':userId,'token':token},"$deletLocationSharingUrl$id").then((response){
      print(response.body);
      var de = json.decode(response.body);
      print(de);
      fetchMyLocationSharing(userId, token, true);
    });
  }

  deleteLocationSharingAll(String userId,String token){
    // print("$deleteLocationRequestUrl$id");
    repository.callDeletApi({'userId':userId,'token':token},"$deletLocationSharingAllUrl$userId").then((response){
      print(response.body);
      // var de = json.decode(response.body);
      // print(de);
      fetchMyLocationSharing(userId, token, true);
    });
  }
// <============== business ===============>


  fetchMyBusinessProfile(String userId,String token){
    repository.fetchMyBusinessPRofile(userId, token).then((reponse){
      print(reponse.body);
      var data = businessProfileModelFromJson(reponse.body);
      emit(state.copyWith(businessProfilee: data.data));
    });
    // fetchBusinessRating(userId, token);
  }

  fetchOtherBusinessProfile(String userId,String token,String otherId){
    repository.fetchOtherBusinessProfile(userId, token,otherId).then((reponse){
      print(reponse.body);
      var data = businessProfileModelFromJson(reponse.body);
      emit(state.copyWith(otherBusinessProfilee: data.data));
    });
  }

  updateRating(double val){
    print(val);
    emit(state.copyWith(businessRatingValuee: val));
  }
  updateRatingFeedBack(String val){
    emit(state.copyWith(businessRatingFeedBackk: val));
  }

  fetchMusic(){
    repository.fetchMusic().then((response){
      print(response.body);
      var data = musicModelFromJson(response.body);
      emit(state.copyWith(musicTrackk: data.tracks));
    });
  }

  fetchBusinessRating(String userId,String token,String bussId){
    repository.fetchBusinessRating(userId, token,bussId).then((response){
      print(response.body);
      var data = fetchBusinesRatingModelFromJson(response.body);
      emit(state.copyWith(businessRatingg: data.data));
    });
  }

  setOrderLatLong(LatLng lat)async{
    List<Placemark> placemarks = await placemarkFromCoordinates(lat.latitude, lat.longitude);
    print(placemarks);
    var address = "${placemarks[0].street},${placemarks[0].locality} ${placemarks[0].administrativeArea} ${placemarks[0].country}" ;
    emit(state.copyWith(orderLatt: lat.latitude,orderLongg: lat.longitude,orderAddresss: address,orderStreett: placemarks[0].street,orderCityy: placemarks[0].locality,orderProvincee: "${placemarks[0].administrativeArea} ${placemarks[0].country}"));
  }
  setAddress(String address){
    emit(state.copyWith(orderAddresss: address));
  }

  addOrder(String productId,String businessId,String userId,String token,String orderCost,BuildContext context,String productName){
    showDialog(context: context,barrierDismissible: false, builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    Map<String,dynamic> map = {
      'businessId': businessId,
      'userId': userId,
      'productId': productId,
      'orderCost': orderCost,
      'shippingCost': '',
      'shippingAddress': state.orderAddress,
      'token': token,
    };
    businessToolRepository.addOrder(map).then((response){
      Navigator.pop(context);
      var de = json.decode(response.body);
      print("reesss  ${response.body}");
      if(de['message'] == 'Data successfuly save'){
        registerBloc.pushNotification(userId, token, businessId, "5", "Congrats! you got new order", "$productName ${state.orderAddress}", "5");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> BottomNavBar()), (route) => false);
        Future.delayed(Duration(seconds: 1),(){
          nextScreen(context, MyOrdersUser());
        });
      }
    } );
  }

  fetchMyOrderUser(String userId,String token){
    repository.fetchMyOrdersUser(userId, token).then((response){
      print(response.body);
      var data = userOrdersModelFromJson(response.body);
      emit(state.copyWith(userOrderr: data.data));
    });
  }

  fetchMyLocationSharing(String userId,String token,bool myLocationToOthers){
    Map<String,dynamic> map = {
      'userId':userId,
      'requestType':myLocationToOthers ? '1' :'0',
      'token':token,
    };
    repository.callPostApiCI(map, fetchMyLocationSharingtoOtherUrl).then((response){
      print(response.body);
      var data = locationSharToOtherModelFromJson(response.body);
      if(myLocationToOthers){
        emit(state.copyWith(locationshareToOtherss: data.data));
      }else{
        emit(state.copyWith(locationshareToMee: data.data));
      }

    });
  }

  setIsMapMoving(bool val){
    emit(state.copyWith(isMapMovingg: val));
  }


  getBusinessProfileImage(bool isCover,bool isCamera) async {
    XFile? image = await ImagePicker().pickImage(source:isCamera ? ImageSource.camera: ImageSource.gallery);
    if(image != null){
      cropBusinessProfile(isCover,File(image.path));
    }
  }

  Future<Null> cropBusinessProfile(bool isCover,File file)async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: isCover ? CropStyle.rectangle : CropStyle.circle
    );
    if(croppedFile != null){
      if(isCover){
        emit(state.copyWith(coverUpdatedImageBusinesss: File(croppedFile.path)));
      }else{
        emit(state.copyWith(profileUpdatedImageBusinesss: File(croppedFile.path)));
      }
    }

  }

  cancelUserOrder(String userId,String token,String orderId,BuildContext context){
    emit(state.copyWith(isLoadingg: true));
    Map<String,dynamic> body = {
      'userId':userId,
      'token':token,
      'orderId':orderId,
      'status':'3',
    };
    repository.callPostApi(body, cancelOrderUrl).then((response) {
      emit(state.copyWith(isLoadingg: false));
      var de = json.decode(response.body);
      print(response.body);
      if(de['message'] == "Order status updated successfully"){
        Fluttertoast.showToast(msg: "Order Cancelled");
        Navigator.pop(context);
        fetchMyOrderUser(userId, token);
      }else{
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  List<PaymentCard> card = [];
  fetchPaymentCard(String userId,String token){
    repository.callGetApi({'token':token,'userId':userId},"$fetchCardsUrl$userId").then((response){
      print(response.body);
      var data = fetchCardModelFromJson(response.body);
      card = data.data;
      card[0].isSelected = true;
      emit(state.copyWith(paymentCardss: card));
      print(state.paymentCards![0].isSelected);
    });
  }

  selectPaymenCard(int ind){
    print(card[ind].isSelected);
    print(card[ind].isSelected);
    for(var i in card){
      i.isSelected = false;
    }
    card[ind].isSelected = true;
    emit(state.copyWith(paymentCardss: card));
  }

  addCard(String cardNo,String cardName,String cvc,String expiry,String userId,String token,BuildContext context){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    print(expiry.substring(0,2));
    print(expiry.substring(3,5));
    Map<String,dynamic> body = {
      'card_no': cardNo,
      'expiry_month': expiry.substring(0,2),
      'cvv': cvc,
      'userId': userId,
      'card_holder_name': cardName,
      'expiry_year': "20${expiry.substring(3,5)}",
      'token': token,
    };
    repository.callPostApi(body, addCardUrl).then((response){
      Navigator.pop(context);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Card Added Successfull");
      fetchPaymentCard(userId,token);
    });
  }

  fetchJobs(String userId,String token){
    repository.callPostApiCI({'userId':userId,'token':token,'totalPerPage':'20','startFrom':'0'}, fetchJobsUrl).then((value){
      print(value.body);
      var data = fetchJobsModelFromJson(value.body);
      emit(state.copyWith(jobss: data.data));
    });
  }

  fetchAlbums(String userId,String token){
    repository.callPostApiCI({'userId':userId,'token':token,}, fetchAlbumUrl).then((value){
      print(value.body);
      var da = fetchPhotoAlbumFromJson(value.body);
      emit(state.copyWith(photAlbumm: da.data));
    });
  }

  fetchAlbumsImages(String userId,String token,String id){
    repository.callPostApiCI({'userId':userId,'token':token,'albumId':id}, fetchAlbumImagesUrl).then((value){
      print(value.body);
      // var da = fetchPhotoAlbumFromJson(value.body);
      // emit(state.copyWith(photAlbumm: da.data));
    });
  }

  createAlbum(String userId,String token,String name,BuildContext context){
    emit(state.copyWith(isLoadingg: true));
    repository.callPostApiCI({'userId':userId,'token':token,'albumName':name}, addAlbumUrl).then((value){
      print(value.body);
      emit(state.copyWith(isLoadingg: false));
      // Navigator.pop(context);
      var de = json.decode(value.body);
      if(de['message'] == "Data successfuly save"){
        Fluttertoast.showToast(msg: "Album created successfully");
        fetchAlbums(userId,token);
      }else{
        Fluttertoast.showToast(msg: "Something went wrong try again");
      }
    });
  }

  addImagesInAlbum(String userId,String token,String albumbId,BuildContext context,String imageId){
    emit(state.copyWith(isLoadingg: true));
    repository.callPostApiCI({'userId':userId,'token':token,'albumId':albumbId,'imageId':imageId}, addAlbumUrl).then((value){
      print(value.body);
      emit(state.copyWith(isLoadingg: false));
      // Navigator.pop(context);
      var de = json.decode(value.body);
      if(de['message'] == "Data successfuly save"){
        Fluttertoast.showToast(msg: "Album created successfully");
        fetchAlbums(userId,token);
      }else{
        Fluttertoast.showToast(msg: "Something went wrong try again");
      }
    });
  }


  editOcupation(String userId,String token,Map<String,dynamic> body,BuildContext context){
    repository.callPostApiCI(body, editOcupationUrl).then((value){
      print(value.body);
      fetchMyPRofile(userId, token);
      var de = json.decode(value.body);
      if(de['message'] == 'Data successfuly save'){
        Fluttertoast.showToast(msg: "Occupation Edit Successfully");
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  editEducation(String userId,String token,Map<String,dynamic> body,BuildContext context){
    repository.callPostApiCI(body, editEducationUrl).then((value){
      print(value.body);
      fetchMyPRofile(userId, token);
      var de = json.decode(value.body);
      if(de['message'] == 'Data successfuly save'){
        Fluttertoast.showToast(msg: "Education Edit Successfully");
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  fetchCard(String userId,String token){
    repository.callGetApiCi({'userId':userId,'token':token}, fetchCardUrl).then((value) {
      print("cards ${value.body}");
      var data = cardDataModelFromJson(value.body);
      emit(state.copyWith(cardd: data));
    });
  }

}
