import 'package:story_view/story_view.dart';

class StoryItemModel{
  int index;
  String caption;
  List<StoryItem> storyItem;

  StoryItemModel({required this.index,required this.storyItem,required this.caption});
}