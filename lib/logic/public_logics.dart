import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PublicLogics{

  Future<File> getImage()async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(image!.path);
  }

}