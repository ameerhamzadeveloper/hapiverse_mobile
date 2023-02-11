part of 'register_cubit.dart';

class RegisterState {
  String? fullName;
  String? email;
  String? password;
  String errorMessage;
  bool loadingState;
  List<IntrestCategory>? intrest;
  List<IntrestCategory>? subIntrest;
  String? profileImagePath;
  String? coverImage;
  List<String> genderList;
  List<String> relationDropList;
  List<String> profileCategoryList;
  String profileCategoryVal;
  String genderVal;
  String relationVal;
  DateTime dateOfBirth;
  String? hobby;
  List<String>? isInterseSelect = [];
  bool isBusiness;
  String? ownerName;
  String? vatNo;
  TextEditingController businessLocation;
  bool isCatSelect;
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
  String? phoneNo;
  List<NotificationList>? notificationList;
  String notificaitionCount;
  bool closedAllDayMonday;
  bool closedAllDayTuesday;
  bool closedAllDayWednesDay;
  bool closedAllDayThursday;
  bool closedAllDayFriday;
  bool closedAllDaySaturday;
  bool closedAllDaySunday;
  String? verifyEmailError;
  String? verifyCode;
  String? businessCoverPath;
  String? supponsorAccountType;
  String? religion;
  int? planId;
  bool isAccountPrivate;
  String? workName;
  String? jobTitle;
  String? workLocation;
  String? workDescription;
  String? currentlyWorking;
  DateTime? workStartDate;
  DateTime? workEndDate;

  String? educationLocation;
  String? educationName;
  String? educationLevel;
  DateTime? educationStartDate;
  DateTime? educationEndDate;
  String? heightInches;
  String? heightfeet;
  String? hairColor;
  Color? hairColorMaterial;

  RegisterState(
      {this.fullName,
      this.email,
      this.password,
      required this.errorMessage,
      required this.loadingState,
      this.intrest,
      this.subIntrest,
      this.profileImagePath,
      required this.genderList,
      required this.genderVal,
      required this.relationDropList,
      required this.relationVal,
      required this.dateOfBirth,
        this.hobby,
        this.isInterseSelect,
        required this.isBusiness,
        this.ownerName,
        this.vatNo,
        required this.isCatSelect,
        required this.businessLocation,
        required this.profileCategoryList,
        required this.profileCategoryVal,
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
        this.phoneNo,
        this.notificationList,
        required this.notificaitionCount,
        required this.closedAllDayFriday,
        required this.closedAllDayMonday,
        required this.closedAllDaySaturday,
        required this.closedAllDaySunday,
        required this.closedAllDayThursday,
        required this.closedAllDayTuesday,
        required this.closedAllDayWednesDay,
        this.verifyEmailError,
        this.verifyCode,
        this.businessCoverPath,
        this.supponsorAccountType,
        this.planId,
        required this.isAccountPrivate,
        this.religion,
        this.workName,
        this.jobTitle,
        this.workLocation,
        this.workDescription,
        this.currentlyWorking,
        this.workStartDate,
        this.workEndDate,
        this.educationEndDate,
        this.educationLevel,
        this.educationLocation,
        this.educationName,
        this.educationStartDate,
        this.coverImage,
        this.heightfeet,
        this.heightInches,
        this.hairColor,
        this.hairColorMaterial
      });

  RegisterState copyWith({
    String? fullNamee,
    String? emaill,
    String? passwordd,
    String? erro,
    bool? loadingSt,
    List<IntrestCategory>? intrestt,
    List<IntrestCategory>? subIntres,
    String? ProfileImagePathset,
    String? genderVall,
    String? relationVall,
    DateTime? dateofB,
    String? hobbyy,
    List<String>? isInterseSelectt,
    bool? isBusinesss,
    String? ownerNamee,
    String? vatNoo,
    bool? isCatSelectt,
    TextEditingController? businessLocationn,
    List<String>? profileCategoryListt,
    String? profileCategoryVall,
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
  String? phoneNOO,
  List<NotificationList>? notificationListt,
    String? notificaitionCountt,
    bool? closedAllDayMondayy,
    bool? closedAllDayTuesdayy,
    bool? closedAllDayWednesDayy,
    bool? closedAllDayThursdayy,
    bool? closedAllDayFridayy,
    bool? closedAllDaySaturdayy,
    bool? closedAllDaySundayy,
    String? verifyEmailErrorr,
    String? verifyCodee,
    String? businessCoverPathh,
    String? supponsorAccountTypee,
    int? planIdd,
    bool? isAccountPrivatee,
    String? religionn,
    String? workNamee,
    String? jobTitlee,
    String? workLocationn,
    String? workDescriptionn,
    String? currentlyWorkingg,
    DateTime? workStartDatee,
    DateTime? workEndDatee,
    String? educationLocationn,
    String? educationNamee,
    String? educationLevell,
    DateTime? educationStartDatee,
    DateTime? educationEndDatee,
    String? coverImagee,
    String? heightInchess,
    String? heightfeett,
    String? hairColorr,
    Color? hairColorMateriall,
  }) {
    return RegisterState(
      email: emaill ?? email,
      fullName: fullNamee ?? fullName,
      password: passwordd ?? password,
      errorMessage: erro ?? errorMessage,
      loadingState: loadingSt ?? loadingState,
      intrest: intrestt ?? intrest,
      subIntrest: subIntres ?? subIntrest,
      profileImagePath: ProfileImagePathset ?? profileImagePath,
      genderList: genderList,
      genderVal: genderVall ?? genderVal,
      relationDropList: relationDropList,
      relationVal: relationVall ?? relationVal,
      dateOfBirth: dateofB ?? dateOfBirth,
      hobby: hobbyy ?? hobby,
      isInterseSelect: isInterseSelectt ?? isInterseSelect,
      isBusiness: isBusinesss ?? isBusiness,
      ownerName: ownerNamee ?? ownerName,
      vatNo: vatNoo ?? vatNo,
      isCatSelect: isCatSelectt ?? isCatSelect,
      businessLocation: businessLocationn ?? businessLocation,
      profileCategoryList: profileCategoryListt ?? profileCategoryList,
      profileCategoryVal: profileCategoryVall ?? profileCategoryVal,
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
      phoneNo: phoneNOO ?? phoneNo,
      notificationList: notificationListt ?? notificationList,
      notificaitionCount: notificaitionCountt ?? notificaitionCount,
      closedAllDayFriday: closedAllDayFridayy ?? closedAllDayFriday,
      closedAllDayMonday: closedAllDayMondayy ?? closedAllDayMonday,
      closedAllDaySaturday: closedAllDaySaturdayy ?? closedAllDaySaturday,
      closedAllDaySunday: closedAllDaySundayy ?? closedAllDaySunday,
      closedAllDayThursday: closedAllDayThursdayy ?? closedAllDayThursday,
      closedAllDayTuesday: closedAllDayTuesdayy ?? closedAllDayTuesday,
      closedAllDayWednesDay: closedAllDayWednesDayy ?? closedAllDayWednesDay,
      verifyEmailError: verifyEmailErrorr ?? verifyEmailError,
      verifyCode: verifyCodee ?? verifyCode,
      businessCoverPath: businessCoverPathh ?? businessCoverPath,
      supponsorAccountType: supponsorAccountTypee ?? supponsorAccountType,
      planId: planIdd ?? planId,
      isAccountPrivate: isAccountPrivatee ?? isAccountPrivate,
      religion: religionn ?? religion,
      currentlyWorking: currentlyWorkingg ??currentlyWorking,
      jobTitle: jobTitlee ?? jobTitle,
      workDescription: workDescriptionn ?? workDescription,
      workEndDate: workEndDatee ?? workEndDate,
      workLocation: workLocationn ?? workLocation,
      workName: workNamee ?? workName,
      workStartDate: workStartDatee ?? workStartDate,
      educationEndDate: educationEndDatee ?? educationEndDate,
      educationLevel: educationLevell  ?? educationLevel,
      educationLocation: educationLocationn ??educationLocation ,
      educationName: educationNamee ?? educationName,
      educationStartDate: educationStartDatee ?? educationStartDate,
      coverImage: coverImagee ?? coverImage,
      heightfeet: heightfeett ?? heightfeet,
      heightInches: heightInchess ?? heightInches,
      hairColor: hairColorr ?? hairColor,
      hairColorMaterial: hairColorMateriall ?? hairColorMaterial
    );
  }
}
