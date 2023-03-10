part of 'story_cubit.dart';

class StoryState {
  TextEditingController message;
  TextStyle textStyle;
  TextStyle textStyle1;
  bool isEmojiOpen;
  List<Color> pageColor;
  XFile? storyImage;
  XFile? storyVideo;
  VideoPlayerController? videoController;
  bool? isUploaded;
  String captionVal;
  TextEditingController storyCommentController;

  StoryState({required this.textStyle,required this.message,
    required this.isEmojiOpen,required this.textStyle1,
    required this.pageColor,this.storyImage,
    this.storyVideo,this.videoController,this.isUploaded,
    required this.captionVal,required this.storyCommentController});

  StoryState copyWith({
    TextEditingController? messagee,
    TextStyle? textStylee,
    TextStyle? textStyle11,
    bool? isEmojiOpenn,
    List<Color>? pageColorr,
    XFile? storyImagee,
    XFile? storyVideoe,
    VideoPlayerController? videoControllerr,
    bool? isUploadedd,
    String? captionVall,
    TextEditingController? storyCommentControllerr

  }){
    return StoryState(
      textStyle: textStylee ?? textStyle,
      message: messagee ?? message,
      isEmojiOpen: isEmojiOpenn ?? isEmojiOpen,
      textStyle1: textStyle11 ?? textStyle1,
      pageColor: pageColorr ?? pageColor,
      storyImage: storyImagee ?? storyImage,
      storyVideo: storyVideoe ?? storyVideo,
      videoController: videoControllerr ?? videoController,
      isUploaded: isUploadedd ?? isUploaded,
      captionVal: captionVall ?? captionVal,
      storyCommentController: storyCommentControllerr ?? storyCommentController
    );
  }
}
