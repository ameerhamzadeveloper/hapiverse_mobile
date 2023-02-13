part of 'profile_cubit.dart';


class ProfileState {

  String? profileName;
  String? profileImage;
  String? gender;
  String? relationShip;
  String? hobby;
  String? country;
  String? city;
  String? totalPost;
  String? followers;
  String? following;
  String? dateOfBirth;
  String? phoneNo;
  List<String> genderList;
  List<String> relationDropList;
  Response? otherProfileInfoResponse;
  List<GetMyAllPosts>? allOtherPosts;
  List<GetMyAllPosts>? allOtherPhotos;
  List<PaymentCard>? paymentCards;
  List<GetMyAllPosts>? allMyPosts;
  List<GetMyAllPosts>? allMyPhotos;
  File? profileUpdatedImage;
  File? profileUpdatedImageBusiness;
  File? coverUpdatedImageBusiness;
  bool isProfileUpdating;
  String? isFriend;
  List<FetchFriend>? myFriendsList;
  List<FetchFriend>? otherFriendsList;
  String? healthHospital;
  DateTime? healthDate;
  String? healthStatus;
  List<CovidRecord>? covidRecordList;
  BusinessProfile? businessProfile;
  BusinessProfile? otherBusinessProfile;
  double businessRatingValue;
  String? businessRatingFeedBack;
  List<Track>? musicTrack;
  List<Track>? favMusic;
  AudioPlayer? audioPlayer;
  Duration progress;
  bool isPlaying = true;
  String musicTitle;
  String musicImage;
  String musicUrl;
  Duration musicLength;
  List<ImageAlbum>? imageAlbum;
  List<LocationShareToOther>? locationshareToOthers;
  String musicArtist;
  int? musicIndex;
  BusinessRating? businessRating;
  bool? stealthModeEnable;
  String? stealthModeTimeLeft;
  List<RequestLocation>? myLocationRequeststoOther;
  List<RequestLocation>? otherLocationRequestToMe;
  bool notNowClieked;
  String? avatarType;
  String? flatColor;
  String? profileImageText;
  String? gredientColor1;
  String? gredientColor2;
  String? firstGredientColor;
  String? secondGredientColor;
  String? orderStreet;
  String? orderProvince;
  String? orderCity;
  String? orderAddress;
  double? orderLat;
  double? orderLong;
  List<UserOrder>? userOrder;
  bool isMapMoving;
  bool? isStartTimeSelected = false;
  bool? isEndTimeSelected = false;
  TimeOfDay saturdayStartTime = TimeOfDay.now();
  TimeOfDay saturdayEndTime = TimeOfDay.now();
  TimeOfDay sundaryStartTime = TimeOfDay.now();
  TimeOfDay sundayEndTime = TimeOfDay.now();
  TimeOfDay mondayStartTime = TimeOfDay.now();
  TimeOfDay mondayEndTime = TimeOfDay.now();
  TimeOfDay tuesdayStartTime = TimeOfDay.now();
  TimeOfDay tuesdayEndTime = TimeOfDay.now();
  TimeOfDay wednesdayStartTime = TimeOfDay.now();
  TimeOfDay wednesdayEndTime = TimeOfDay.now();
  TimeOfDay thursdayStartTime = TimeOfDay.now();
  TimeOfDay thursdayEndTime = TimeOfDay.now();
  TimeOfDay fridayStartTime = TimeOfDay.now();
  TimeOfDay firdayEndTime = TimeOfDay.now();
  bool? saturday = true;
  bool? sunday = false;
  bool? monday = true;
  bool? tuesday = false;
  bool? wednesday = false;
  bool? thursday = false;
  bool? friday = false;
  bool alwaysOpen;
  bool isHoursSelected;
  bool closedAllDayMonday;
  bool closedAllDayTuesday;
  bool closedAllDayWednesDay;
  bool closedAllDayThursday;
  bool closedAllDayFriday;
  bool closedAllDaySaturday;
  bool closedAllDaySunday;
  List<Job>? jobs;
  Set<Marker>? businessLocationMArker = {};
  static late double currentLat = 24.401716;
  static late double currentLng = 67.822508;
  LatLng initPosition = const LatLng(24.401716, 67.822508);
  Completer<GoogleMapController>? completer = Completer();
  GoogleMapController? controller;
  String? businessAddress;
  bool isLoading;
  String? error;
  String? height;
  String? religion;
  String? workName;
  String? workTitle;
  String? workLocation;
  String? workStartDate;
  String? workDescription;
  String? workEndDate;
  String? currentlyWorking;
  String? educationName;
  String? educationLevel;
  String? educationStartYear;
  String? educationEndYaer;
  String? currentlyReading;
  String? educationLocation;
  String? hasVerified;
  String? badge;
  CardDataModel? card;
  List<UserInterestProfile>? userInterest;
  List<LocationShareToOther>? locationshareToMe;
  List<PhotoAlbum>? photAlbum;
  ProfileState({
    this.imageAlbum,
    this.favMusic,
    this.card,
    this.photAlbum,
    this.locationshareToMe,
    this.profileImage,
    this.profileName,
    this.hobby,
    this.relationShip,
    this.gender,
    this.country,
    this.city,
    this.followers,
    this.following,
    this.totalPost,
    this.dateOfBirth,
    this.phoneNo,
    this.jobs,
    this.paymentCards,
    required this.genderList,
    required this.relationDropList,
    this.otherProfileInfoResponse,
    this.allOtherPosts,
    this.profileUpdatedImage,
    required this.isProfileUpdating,
    this.allMyPosts,
    this.isFriend,
    this.myFriendsList,
    this.otherFriendsList,
    this.healthDate,
    this.healthHospital,
    this.healthStatus,
    this.covidRecordList,
    this.businessProfile,
    this.otherBusinessProfile,
    this.businessRatingFeedBack,
    required this.businessRatingValue,
    this.musicTrack,
    required this.audioPlayer,
    required this.progress,
    required this.isPlaying,
    required this.musicArtist,
    required this.musicImage,
    required this.musicLength,
    required this.musicTitle,
    required this.musicUrl,
    this.musicIndex,
    this.businessRating,
    this.allOtherPhotos,
    this.allMyPhotos,
    this.stealthModeEnable,
    this.stealthModeTimeLeft,
    this.myLocationRequeststoOther,
    this.otherLocationRequestToMe,
    required this.notNowClieked,
    this.avatarType,
    this.flatColor,
    this.gredientColor1,
    this.gredientColor2,
    this.profileImageText,
    this.orderAddress,
    this.orderLat,
    this.orderLong,
    this.userOrder,
    this.error,
    required this.isMapMoving,
    this.orderCity,
    this.orderProvince,
    this.orderStreet,
    this.firstGredientColor,
    this.secondGredientColor,
    this.profileUpdatedImageBusiness,
    this.coverUpdatedImageBusiness,
    this.isEndTimeSelected,
    this.isStartTimeSelected,
    this.friday,
    this.monday,
    this.saturday,
    this.sunday,
    this.thursday,
    this.tuesday,
    this.wednesday,
    required this.alwaysOpen,
    required this.firdayEndTime,
    required this.fridayStartTime,
    required this.mondayEndTime,
    required this.mondayStartTime,
    required this.saturdayEndTime,
    required this.saturdayStartTime,
    required this.sundaryStartTime,
    required this.sundayEndTime,
    required this.thursdayEndTime,
    required this.thursdayStartTime,
    required this.tuesdayEndTime,
    required this.tuesdayStartTime,
    required this.wednesdayEndTime,
    required this.wednesdayStartTime,
    required this.isHoursSelected,
    required this.closedAllDayFriday,
    required this.closedAllDayMonday,
    required this.closedAllDaySaturday,
    required this.closedAllDaySunday,
    required this.closedAllDayThursday,
    required this.closedAllDayTuesday,
    required this.closedAllDayWednesDay,
    this.businessLocationMArker,
    this.controller,
    this.completer,
    this.businessAddress,
    required this.isLoading,
    this.religion,
    this.height,
    this.educationName,
    this.workName,
    this.educationLevel,
    this.workTitle,
    this.currentlyWorking,
    this.educationStartYear,
    this.educationEndYaer,
    this.currentlyReading,
    this.workLocation,
    this.educationLocation,
    this.workStartDate,
    this.workEndDate,
    this.workDescription,
    this.badge,
    this.hasVerified,
    this.locationshareToOthers,
    this.userInterest
});

  ProfileState copyWith({
    List<Job>? jobss,
    List<PaymentCard>? paymentCardss,
    String? profileNamee,
    String? profileImagee,
    String? genderr,
    String? relationShipp,
    String? hobbyy,
    String? countryy,
    String? cityy,
    String? totalPostt,
    String? followerss,
    String? followingg,
    String? dateOfBirt,
    String? phoneNoo,
    List<String>? genderListt,
    List<String>? relationDropListt,
    Response? otherProfileInfoResponsee,
    List<GetMyAllPosts>? allOtherPostss,
    File? profileUpdatedImagee,
    bool? isProfileUpdatingg,
    List<GetMyAllPosts>? allMyPostss,
    String? isFriendd,
    List<FetchFriend>? myFriendsListt,
    List<FetchFriend>? otherFriendsListt,
    String? healthHospitall,
    DateTime? healthDatee,
    String? healthStatuss,
    List<CovidRecord>? covidRecordListt,
    BusinessProfile? businessProfilee,
    BusinessProfile? otherBusinessProfilee,
    double? businessRatingValuee,
    String? businessRatingFeedBackk,
    List<Track>? musicTrackk,
    List<Track>? favMusicc,
    AudioPlayer? audioPlayerr,
    Duration? progresss,
    bool? isPlayingg,
    String? musicTitlee,
    String? musicImagee,
    String? musicUrll,
    Duration? musicLengthh,
    String? musicArtistt,
    int? musicIndexx,
    BusinessRating? businessRatingg,
    List<GetMyAllPosts>? allOtherPhotoss,
    List<GetMyAllPosts>? allMyPhotoss,
    bool? stealthModeEnablee,
    String? stealthModeTimeLeftt,
    List<RequestLocation>? myLocationRequeststoOtherr,
    List<RequestLocation>? otherLocationRequestToMee,
    bool? notNowClickedd,
    String? avatarTypee,
    String? flatColorr,
    String? profileImageTextt,
    String? gredientColor11,
    String? gredientColor22,
    String? orderAddresss,
    double? orderLatt,
    double? orderLongg,
    List<UserOrder>? userOrderr,
    bool? isMapMovingg,
    String? orderStreett,
    String? orderProvincee,
    String? orderCityy,
    String? firstGredientColorr,
    String? secondGredientColorr,
    File? profileUpdatedImageBusinesss,
    File? coverUpdatedImageBusinesss,
    bool? isStartTimeSelectedd,
    bool? isEndTimeSelectedd,
    bool? saturdayy,
    bool? sundayy,
    bool? mondayy,
    bool? tuesdayy,
    bool? wednesdayy,
    bool? thursdayy,
    bool? fridayy,
    bool? alwaysOpenn,
    TimeOfDay? saturdayStartTimee,
    TimeOfDay? saturdayEndTimee,
    TimeOfDay? sundaryStartTimee,
    TimeOfDay? sundayEndTimee,
    TimeOfDay? mondayStartTimee,
    TimeOfDay? mondayEndTimee,
    TimeOfDay? tuesdayStartTimee,
    TimeOfDay? tuesdayEndTimee,
    TimeOfDay? wednesdayStartTimee,
    TimeOfDay? wednesdayEndTimee,
    TimeOfDay? thursdayStartTimee,
    TimeOfDay? thursdayEndTimee,
    TimeOfDay? fridayStartTimee,
    TimeOfDay? firdayEndTimee,
    bool? isHoursSelectedd,
    bool? closedAllDayMondayy,
    bool? closedAllDayTuesdayy,
    bool? closedAllDayWednesDayy,
    bool? closedAllDayThursdayy,
    bool? closedAllDayFridayy,
    bool? closedAllDaySaturdayy,
    bool? closedAllDaySundayy,
    Set<Marker>? businessMarker,
    Completer<GoogleMapController>? completerr,
    GoogleMapController? controllerr,
    String? businessAddresss,
    bool? isLoadingg,
    String? errorr,
    String? heightt,
    String? religionn,
    String? workNamee,
    String? workTitlee,
    String? workLocationn,
    String? workStartDatee,
    String? workEndDatee,
    String? currentlyWorkingg,
    String? educationNamee,
    String? educationLevell,
    String? educationStartYearr,
    String? educationEndYaerr,
    String? currentlyReadingg,
    String? educationLocationn,
    String? workDescriptionn,
    String? hasVerifiedd,
    String? badgee,
    List<LocationShareToOther>? locationshareToOtherss,
    List<LocationShareToOther>? locationshareToMee,
    List<UserInterestProfile>? userInterestt,
    List<PhotoAlbum>? photAlbumm,
    CardDataModel? cardd,
    List<ImageAlbum>? imageAlbumm,
  }){
    return ProfileState(
       hobby: hobbyy ?? hobby,
      city: cityy ?? city,
      country: countryy ?? country,
      followers: followerss ?? followers,
      following: followingg ?? following,
      gender: genderr ?? gender,
      profileImage: profileImagee ?? profileImage,
      profileName: profileNamee ?? profileName,
      relationShip: relationShipp ?? relationShip,
      totalPost: totalPostt ?? totalPost,
      dateOfBirth: dateOfBirt ?? dateOfBirth,
      phoneNo: phoneNoo ?? phoneNo,
      genderList: genderListt ?? genderList,
      relationDropList: relationDropListt ?? relationDropList,
      otherProfileInfoResponse: otherProfileInfoResponsee ?? otherProfileInfoResponse,
      allOtherPosts: allOtherPostss ?? allOtherPosts,
      profileUpdatedImage: profileUpdatedImagee ?? profileUpdatedImage,
      isProfileUpdating: isProfileUpdatingg ?? isProfileUpdating,
      allMyPosts: allMyPostss ?? allMyPosts,
      isFriend: isFriendd ?? isFriend,
      myFriendsList: myFriendsListt ?? myFriendsList,
      otherFriendsList: otherFriendsListt ?? otherFriendsList,
      healthDate: healthDatee ?? healthDate,
      healthHospital: healthHospitall ?? healthHospital,
      healthStatus: healthStatuss ?? healthStatus,
      covidRecordList: covidRecordListt ?? covidRecordList,
      businessProfile: businessProfilee ?? businessProfile,
      otherBusinessProfile: otherBusinessProfilee ?? otherBusinessProfile,
      businessRatingValue: businessRatingValuee ?? businessRatingValue,
      businessRatingFeedBack: businessRatingFeedBackk ?? businessRatingFeedBack,
      musicTrack: musicTrackk ?? musicTrack,
      audioPlayer: audioPlayerr ?? audioPlayer,
      isPlaying: isPlayingg ?? isPlaying,
      progress: progresss ?? progress,
      musicArtist: musicArtistt ?? musicArtist,
      musicImage: musicImagee ?? musicImage,
      musicLength: musicLengthh ?? musicLength,
      musicTitle: musicTitlee ?? musicTitle,
      musicUrl: musicUrll ?? musicUrl,
      musicIndex: musicIndexx ?? musicIndex,
      businessRating: businessRatingg ?? businessRating,
      allOtherPhotos: allOtherPhotoss ?? allOtherPhotos,
      allMyPhotos: allMyPhotoss ?? allMyPhotos,
      stealthModeEnable: stealthModeEnablee ?? stealthModeEnable,
      stealthModeTimeLeft: stealthModeTimeLeftt ?? stealthModeTimeLeft,
      otherLocationRequestToMe: otherLocationRequestToMee ?? otherLocationRequestToMe,
      myLocationRequeststoOther: myLocationRequeststoOtherr ?? myLocationRequeststoOther,
      notNowClieked: notNowClickedd ?? notNowClieked,
      avatarType: avatarTypee ?? avatarType,
      flatColor: flatColorr ?? flatColor,
      gredientColor1: gredientColor11 ?? gredientColor1,
      gredientColor2: gredientColor22 ?? gredientColor2,
      profileImageText: profileImageTextt ?? profileImageText,
      orderAddress: orderAddresss ?? orderAddress,
      orderLat: orderLatt ?? orderLat,
      orderLong: orderLongg ?? orderLong,
      userOrder: userOrderr ?? userOrder,
      isMapMoving: isMapMovingg ?? isMapMoving,
      orderCity: orderCityy ?? orderCity,
      orderProvince: orderProvincee ?? orderProvince,
      orderStreet: orderStreett ?? orderStreet,
      firstGredientColor: firstGredientColorr ?? firstGredientColor,
      secondGredientColor: secondGredientColorr ?? secondGredientColor,
      coverUpdatedImageBusiness: coverUpdatedImageBusinesss ?? coverUpdatedImageBusiness,
      profileUpdatedImageBusiness: profileUpdatedImageBusinesss ?? profileUpdatedImageBusiness,
      isStartTimeSelected: isStartTimeSelectedd ?? isStartTimeSelected,
      isEndTimeSelected: isEndTimeSelectedd ?? isEndTimeSelected,
      friday: fridayy ?? friday,
      monday: mondayy ?? monday,
      saturday: saturdayy ?? saturday,
      sunday: sundayy ?? sunday,
      thursday: tuesdayy ?? thursday,
      tuesday: tuesdayy ?? tuesday,
      wednesday: wednesdayy ?? wednesday,
      alwaysOpen: alwaysOpenn ?? alwaysOpen,
      firdayEndTime: firdayEndTimee ?? firdayEndTime,
      fridayStartTime: fridayStartTimee ?? fridayStartTime,
      mondayEndTime: mondayEndTimee ?? mondayEndTime,
      mondayStartTime: mondayStartTimee ?? mondayStartTime,
      saturdayEndTime: saturdayEndTimee ?? saturdayEndTime,
      saturdayStartTime: saturdayStartTimee ?? saturdayStartTime,
      sundaryStartTime: sundaryStartTimee ?? sundaryStartTime,
      sundayEndTime: sundayEndTimee ?? sundayEndTime,
      thursdayEndTime: thursdayEndTimee ?? thursdayEndTime,
      thursdayStartTime: thursdayStartTimee ?? thursdayStartTime,
      tuesdayEndTime: tuesdayEndTimee ?? tuesdayEndTime,
      tuesdayStartTime: tuesdayStartTimee ?? tuesdayStartTime,
      wednesdayEndTime: wednesdayEndTimee ?? wednesdayEndTime,
      wednesdayStartTime: wednesdayStartTimee ?? wednesdayEndTime,
      isHoursSelected : isHoursSelectedd ?? isHoursSelected,
      closedAllDayFriday: closedAllDayFridayy ?? closedAllDayFriday,
      closedAllDayMonday: closedAllDayMondayy ?? closedAllDayMonday,
      closedAllDaySaturday: closedAllDaySaturdayy ?? closedAllDaySaturday,
      closedAllDaySunday: closedAllDaySundayy ?? closedAllDaySunday,
      closedAllDayThursday: closedAllDayThursdayy ?? closedAllDayThursday,
      closedAllDayTuesday: closedAllDayTuesdayy ?? closedAllDayTuesday,
      closedAllDayWednesDay: closedAllDayWednesDayy ?? closedAllDayWednesDay,
      businessLocationMArker: businessMarker ?? businessLocationMArker,
      completer: completerr ?? completer,
      controller: controllerr ?? controller,
      businessAddress: businessAddresss ?? businessAddress,
      isLoading: isLoadingg ?? isLoading,
      error: errorr ?? error,
      religion: religionn ?? religion,
      height: heightt ?? height,
      currentlyWorking: currentlyWorkingg ?? currentlyWorking,
      educationLevel: educationLevell ?? educationLevel,
      educationName: educationNamee ?? educationName,
      educationLocation: educationLocationn ?? educationLocation,
      workEndDate: workEndDatee ?? workEndDate,
      workStartDate: workStartDatee ?? workStartDate,
      workName: workNamee ?? workName,
      workLocation: workLocationn ?? workLocation,
      currentlyReading: currentlyReadingg ?? currentlyReading,
      educationEndYaer:educationEndYaerr ?? educationEndYaer ,
      educationStartYear: educationStartYearr ?? educationStartYear,
      workTitle: workTitlee ?? workTitle,
      workDescription: workDescriptionn ?? workDescription,
      badge: badgee ?? badge,
      hasVerified: hasVerifiedd ?? hasVerified,
      locationshareToOthers: locationshareToOtherss ?? locationshareToOthers,
      locationshareToMe: locationshareToMee ?? locationshareToMe,
      paymentCards: paymentCardss ?? paymentCards,
      userInterest: userInterestt ?? userInterest,
      jobs: jobss ?? jobs,
      photAlbum: photAlbumm ?? photAlbum,
      card: cardd ?? card,
      imageAlbum: imageAlbumm ?? imageAlbum,
      favMusic: favMusicc ?? favMusic
    );
}

}
