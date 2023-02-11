import 'package:flutter/material.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pro = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    pro.fetchAlbums(authB.userID!, authB.accesToken!);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 6,
            itemBuilder: (ctx,position){
              print(position);
                pos = position;
              if(position == 0){
                return Image.network(AssetConfig.demoNetworkImage);
              }else if(position == 1){
                return Image.network("https://www.idownloadblog.com/wp-content/uploads/2020/10/Resonance_Blue_Dark-428w-926h@3xiphone.png");
              }else if(position == 2){
                return Image.network("https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80");
              }else if(position == 3){
                return Image.network("https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=");
              }else if(position == 4){
                return Image.network("https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80");
              }else{
                return Image.network("https://media.istockphoto.com/photos/pakistan-monument-islamabad-picture-id535695503?k=20&m=535695503&s=612x612&w=0&h=S16wHXc-b3AkL7YMrcFkR2pDGFJA1bRsPmAfQlfrwkc=");
              }
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
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: pos == 0 ? Border.all() : Border.all(width: 0)
                        ),
                          child: Image.network(AssetConfig.demoNetworkImage,height: 50,width: 50,fit: BoxFit.cover,)),
                      Image.network("https://www.idownloadblog.com/wp-content/uploads/2020/10/Resonance_Blue_Dark-428w-926h@3xiphone.png",height: 50,width: 50,fit: BoxFit.cover,),
                      Image.network("https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80",height: 50,width: 50,fit: BoxFit.cover,),
                      Image.network("https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=",height: 50,width: 50,fit: BoxFit.cover,),
                      Image.network("https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80",height: 50,width: 50,fit: BoxFit.cover,),
                      Image.network("https://media.istockphoto.com/photos/pakistan-monument-islamabad-picture-id535695503?k=20&m=535695503&s=612x612&w=0&h=S16wHXc-b3AkL7YMrcFkR2pDGFJA1bRsPmAfQlfrwkc=",height: 50,width: 50,fit: BoxFit.cover,),
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
          )
        ],
      ),
    );
  }
}
