part of 'post_cubit.dart';

class PostState {
  String dropVal;
  List<String> dropList;
  List<String>? images;
  List<String>? showImages;
  double initChildSize;
  List<Widget> bottomSheetWidgets;
  List<Widget> basicPlanBottomSheetWidgets;
  String? postBGImage;
  TextEditingController postController;
  TextEditingController textController;
  TextStyle captionTextStyle;
  Uint8List? videoFile;
  Uint8List? showVideoFile;
  PlaceNearby? places;
  String? currentPlace;
  String? videoFilePath;
  FlickManager? videoController;
  Duration? videoTotalDuration = Duration();
  Duration? videoProgress = Duration();
  bool? isVideoLoading = true;
  int? isUploaded;
  bool? isUploadingPost = false;
  String? showText;
  String fontColor;
  bool isMyNewPostLiked;
  List<String> myTemperaryComments;
  String? postId;
  bool? showVideo;


  PostState(
      {required this.dropList,
      required this.dropVal,
      this.images,
      required this.initChildSize,
      required this.bottomSheetWidgets,
      this.postBGImage,
      required this.postController,
      required this.captionTextStyle,
      this.videoFile,
        this.places,
        this.currentPlace,
        required this.textController,
        this.videoFilePath,
        this.videoController,
        this.isVideoLoading,
        this.videoProgress,
        this.videoTotalDuration,
        this.isUploaded,
        this.isUploadingPost,
        this.showImages,
        this.showText,
        this.showVideoFile,
        required this.fontColor,
        required this.isMyNewPostLiked,
        required this.myTemperaryComments,
        this.postId,
        required this.basicPlanBottomSheetWidgets,
        this.showVideo
      });

  PostState copyWith({
    String? dropVall,
    List<String>? imagese,
    List<String>? showImagess,
    double? initChildSizee,
    List<Widget>? bottomSheetWidget,
    String? postBGImagee,
    TextStyle? captionTextStylee,
    Uint8List? videoFil,
    PlaceNearby? placess,
    String? currentPlacee,
    TextEditingController? textControllerr,
    TextEditingController? postControllerr,
    String? videoFilePathh,
    FlickManager? videoControllerr,
    Duration? videoTotalDurationn,
    Duration? videoProgresss,
    bool? isVideoLoadingg,
    int? isUplaodeed,
    bool? isUploadingPostt,
    String? showTextt,
    Uint8List? showVideoFilee,
    String? fontColorrr,
    bool? isMyNewPostLikedd,
    List<String>? myTemperaryCommentss,
    String? postIdd,
    List<Widget>? basicPlanBottomSheetWidgetss,
    bool? showVideoo,
  }) {
    return PostState(
      postBGImage: postBGImagee ?? postBGImage,
      initChildSize: initChildSizee ?? initChildSize,
      images: imagese ?? images,
      dropList: dropList,
      dropVal: dropVall ?? dropVal,
      bottomSheetWidgets: bottomSheetWidget ?? bottomSheetWidgets,
      postController: postControllerr ?? postController,
      captionTextStyle: captionTextStylee ?? captionTextStyle,
      videoFile: videoFil ?? videoFile,
      places: placess ?? places,
      currentPlace: currentPlacee ?? currentPlace,
      textController: textControllerr ?? textController,
      videoFilePath: videoFilePathh ?? videoFilePath,
      videoController: videoControllerr ?? videoController,
      isVideoLoading: isVideoLoadingg ?? isVideoLoading,
      videoProgress: videoProgresss ?? videoProgress,
      videoTotalDuration: videoTotalDurationn ?? videoTotalDuration,
      isUploaded: isUplaodeed ?? isUploaded,
      isUploadingPost: isUploadingPostt ?? isUploadingPost,
      showImages: showImagess ?? showImages,
      showText: showTextt ?? showText,
      showVideoFile: showVideoFilee ?? showVideoFile,
      fontColor: fontColorrr ?? fontColor,
      isMyNewPostLiked: isMyNewPostLikedd ?? isMyNewPostLiked,
      myTemperaryComments: myTemperaryCommentss ?? myTemperaryComments,
      postId: postIdd ?? postId,
      basicPlanBottomSheetWidgets: basicPlanBottomSheetWidgetss ?? basicPlanBottomSheetWidgets,
      showVideo: showVideoo ?? showVideo
    );
  }
}
