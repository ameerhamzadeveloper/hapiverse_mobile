import 'package:happiverse/data/model/story_id.dart';
import 'package:story_view/story_view.dart';

class StoryModel{
  List<StoryItem> storyItem;
  StoryController controller;
  String title;
  String date;
  String profileImage;
  List<StoryIdModel> storyIdModel;
  StoryModel({required this.controller,required this.storyItem,required this.profileImage,required this.title,required this.date,required this.storyIdModel});
}