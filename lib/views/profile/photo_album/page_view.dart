import 'package:flutter/material.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/profile/photo_album/add_image_in_album.dart';
import 'package:image_picker/image_picker.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/config/assets_config.dart';
import '../../../views/profile/photo_album/images_albumbs.dart';
import '../../../logic/register/register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PageViewPhoto extends StatefulWidget {
  final String id;
  const PageViewPhoto({Key? key,required this.id}) : super(key: key);
  @override
  _PageViewPhotoState createState() => _PageViewPhotoState();
}

class _PageViewPhotoState extends State<PageViewPhoto> {
  PageController controller = PageController();
  var currentPageValue = 0.0;
  int pos = 0;

  Future<String> getImage(int offset,BuildContext context)async{
    XFile? im = await ImagePicker().pickImage(source: offset == 1 ? ImageSource.camera : ImageSource.gallery);

    if(im != null){
      nextScreen(context, AddImageInAlbum(id: widget.id,file: im.path,));
    }
    return im!.path;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pro = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    pro.fetchAlbumsImages(authB.userID!, authB.accesToken!,widget.id);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      body: state.imageAlbum == null ? Center(child: CircularProgressIndicator(),): Stack(
        children: [
          PageView.builder(
            itemCount: state.imageAlbum!.length,
            itemBuilder: (ctx,position){
              var d = state.imageAlbum![position];
              return Image.network("${Utils.baseImageUrl}${d.imageUrl}");
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:List.generate(state.imageAlbum!.length, (index){
                      return Image.network("${Utils.baseImageUrl}${state.imageAlbum![index].imageUrl}");
                    }),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){
                  showModalBottomSheet(context: context, builder: (ctx){
                    return Container(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap:()async{
                                getImage(1,context);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text("Camera",style: TextStyle(color: Colors.blue),)),
                              ),
                            ),
                            Divider(),
                            InkWell(
                              onTap:()async{
                                getImage(2,context);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  // color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text("Gallery",style: TextStyle(color: Colors.blue))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                  // nextScreen(context, AddImageInAlbum(id:widget.id));
                },
                child: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Add Image"),
                      Icon(Icons.add,color: Colors.black,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: ()=> Navigator.pop(context),
                icon: Icon(Icons.clear,color: Colors.black,),
              ),
            ),
          ),

        ],
      ),
    );
  },
);
  }
}
