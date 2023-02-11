import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/views/profile/photo_album/create_album.dart';
import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../../../views/components/universal_card.dart';
import '../../../views/profile/photo_album/page_view.dart';
import '../../../views/profile/photo_album/see_all_favourites.dart';
import '../../../views/profile/photo_album/see_all_memories.dart';
import '../../../views/profile/photo_album/view_photo.dart';
import 'package:line_icons/line_icons.dart';
import '../../authentication/scale_navigation.dart';
import '../../../logic/register/register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/business_product/business_product_cubit.dart';

class ImageAlbums extends StatefulWidget {
  const ImageAlbums({Key? key}) : super(key: key);

  @override
  _ImageAlbumsState createState() => _ImageAlbumsState();
}

class _ImageAlbumsState extends State<ImageAlbums> {

  void initState() {
    // TODO: implement initState
    super.initState();
    final pro = context.read<ProfileCubit>();
    final authB = context.read<RegisterCubit>();
    pro.fetchAlbums(authB.userID!, authB.accesToken!);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
        actions: [
          IconButton(onPressed: (){
            nextScreen(context, CreateAlbum());
          },icon: Icon(Icons.add),)
        ],
      ),
      body: UniversalCard(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("For You",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
              Divider(),
              state.photAlbum == null ? Center(child: CircularProgressIndicator(),):state.photAlbum!.isEmpty ? Center(child: Text("No Album"),):
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: state.photAlbum!.length,
                itemBuilder: (ctx,i){
                  var prod = state.photAlbum![i];
                  return InkWell(
                    onTap: (){
                      nextScreen(context, PageViewPhoto(id:prod.albumId));
                    },
                    child: Container(
                      height: 80,
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // SizedBox(height: 5,),
                                Container(
                                  child: Icon(CupertinoIcons.folder_fill,size: 70,color: Colors.blue,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(prod.albumName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),maxLines: 1,),
                                ),
                                // Row(
                                //   children: [
                                //     Expanded(child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Text(prod.body,style: TextStyle(fontSize: 15,color: Colors.grey),),
                                //     )),
                                //   ],
                                // )
                              ],
                            ),
                          )
                      ),
                    ),
                  );
                },
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Memories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              //     TextButton(onPressed: ()=> nextScreen(context, SeeAllMemoeires()), child: Text("See all"))
              //   ],
              // ),
              // CarouselSlider(items: [
              //   InkWell(
              //     onTap: ()=> Navigator.push(context, ScaleRoute(page: PageViewPhoto())),
              //     child: Card(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20)
              //       ),
              //       elevation: 6.0,
              //       child: Container(
              //         width: double.infinity,
              //         height: getHeight(context) / 2,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20),
              //             image: DecorationImage(
              //               fit: BoxFit.cover,
              //                 image: NetworkImage(
              //                     AssetConfig.demoNetworkImage
              //                 )
              //             )
              //         ),
              //         child: Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment:MainAxisAlignment.end,
              //               children: [
              //                 IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,))
              //               ],
              //             ),
              //             Spacer(),
              //             Text("13 March",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
              //               Shadow( // bottomLeft
              //                   offset: Offset(-1.0, -1.0),
              //                   color: Colors.grey
              //               ),
              //               Shadow( // bottomRight
              //                   offset: Offset(1.0, -1.0),
              //                   color: Colors.grey
              //               ),
              //               Shadow( // topRight
              //                   offset: Offset(1.0, 1.0),
              //                   color: Colors.grey
              //               ),
              //               Shadow( // topLeft
              //                   offset: Offset(-1.0, 1.0),
              //                   color: Colors.grey
              //               ),
              //             ]),),
              //             Text("2022",style: TextStyle(fontFamily: '',color: Colors.white),),
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text("12 items",style: TextStyle(color: Colors.grey),),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 10,)
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              //   Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20)
              //     ),
              //     elevation: 6.0,
              //     child: Container(
              //       width: double.infinity,
              //       height: getHeight(context) / 2,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           image: DecorationImage(
              //               fit: BoxFit.cover,
              //               image: NetworkImage(
              //                   AssetConfig.demoNetworkImage
              //               )
              //           )
              //       ),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment:MainAxisAlignment.end,
              //             children: [
              //               IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,))
              //             ],
              //           ),
              //           Spacer(),
              //           Text("13 March",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
              //             Shadow( // bottomLeft
              //                 offset: Offset(-1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // bottomRight
              //                 offset: Offset(1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topRight
              //                 offset: Offset(1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topLeft
              //                 offset: Offset(-1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //           ]),),
              //           Text("2022",style: TextStyle(fontFamily: '',color: Colors.white,shadows: [Shadow( // bottomLeft
              //               offset: Offset(-1.0, -1.0),
              //               color: Colors.grey
              //           ),
              //             Shadow( // bottomRight
              //                 offset: Offset(1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topRight
              //                 offset: Offset(1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topLeft
              //                 offset: Offset(-1.0, 1.0),
              //                 color: Colors.grey
              //             ),]),),
              //           Row(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("12 items",style: TextStyle(color: Colors.grey),),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 10,)
              //         ],
              //       ),
              //     ),
              //   )
              // ], options: CarouselOptions(height: 400.0,aspectRatio: 15/9,
              //   viewportFraction: 0.9,enableInfiniteScroll: false)),
              // Divider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Favourites",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              //     TextButton(onPressed: ()=> nextScreen(context, SeeAllFavourite()), child: Text("See all"))
              //   ],
              // ),
              // CarouselSlider(items: [
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: InkWell(
              //       onTap: ()=> Navigator.push(context, ScaleRoute(page: ViewPhoto(path: AssetConfig.demoNetworkImage,tag: 'od',title: "2 May 2022",))),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Hero(
              //             tag: 'od',
              //             child: Image.network(AssetConfig.demoNetworkImage,height: 250,width: double.infinity,fit: BoxFit.cover,)),
              //           Text("2 May 2022")
              //         ],
              //       ),
              //     ),
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: InkWell(
              //       onTap: ()=>Navigator.push(context, ScaleRoute(page: ViewPhoto(path: "https://www.idownloadblog.com/wp-content/uploads/2020/10/Resonance_Blue_Dark-428w-926h@3xiphone.png",tag: 'id',title: "2 May 2022",))),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Hero(
              //             tag:'id',
              //             child: Image.network("https://www.idownloadblog.com/wp-content/uploads/2020/10/Resonance_Blue_Dark-428w-926h@3xiphone.png",height: 250,width: double.infinity,fit: BoxFit.cover,)),
              //           Text("2 May 2022")
              //         ],
              //       ),
              //     ),
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Image.network(AssetConfig.demoNetworkImage,height: 250,width: double.infinity,fit: BoxFit.cover,),
              //         Text("2 May 2022")
              //       ],
              //     ),
              //   ),
              //
              // ], options: CarouselOptions(height: 290.0,aspectRatio: 15/9,
              //     viewportFraction: 0.9,enableInfiniteScroll: false)),
              // Divider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Photo by dates",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              //     TextButton(onPressed: (){}, child: Text("See all"))
              //   ],
              // ),
              // CarouselSlider(items: [
              //   Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)
              //     ),
              //     elevation: 6.0,
              //     child: Container(
              //       width: double.infinity,
              //       height: getHeight(context) / 2,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           image: DecorationImage(
              //               fit: BoxFit.cover,
              //               image: NetworkImage(
              //                   AssetConfig.demoNetworkImage
              //               )
              //           )
              //       ),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment:MainAxisAlignment.end,
              //             children: [
              //               IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,))
              //             ],
              //           ),
              //           Spacer(),
              //           Text("March 2022",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
              //             Shadow( // bottomLeft
              //                 offset: Offset(-1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // bottomRight
              //                 offset: Offset(1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topRight
              //                 offset: Offset(1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topLeft
              //                 offset: Offset(-1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //           ]),),
              //           Row(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("12 items",style: TextStyle(color: Colors.grey),),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 10,)
              //         ],
              //       ),
              //     ),
              //   ),
              //   Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)
              //     ),
              //     elevation: 6.0,
              //     child: Container(
              //       width: double.infinity,
              //       height: getHeight(context) / 2,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           image: DecorationImage(
              //               fit: BoxFit.cover,
              //               image: NetworkImage(
              //                   AssetConfig.demoNetworkImage
              //               )
              //           )
              //       ),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment:MainAxisAlignment.end,
              //             children: [
              //               IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,))
              //             ],
              //           ),
              //           Spacer(),
              //           Text("Arpil 2022",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
              //             Shadow( // bottomLeft
              //                 offset: Offset(-1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // bottomRight
              //                 offset: Offset(1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topRight
              //                 offset: Offset(1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topLeft
              //                 offset: Offset(-1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //           ]),),
              //           Row(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("12 items",style: TextStyle(color: Colors.grey),),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 10,)
              //         ],
              //       ),
              //     ),
              //   )
              //
              // ], options: CarouselOptions(height: 290.0,aspectRatio: 15/9,
              //     viewportFraction: 0.9,enableInfiniteScroll: false)),
              // Divider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Your Albums",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              //     TextButton(onPressed: (){}, child: Text("See all"))
              //   ],
              // ),
              // CarouselSlider(items: [
              //   Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)
              //     ),
              //     elevation: 6.0,
              //     child: Container(
              //       width: double.infinity,
              //       height: getHeight(context) / 2,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           image: DecorationImage(
              //               fit: BoxFit.cover,
              //               image: NetworkImage(
              //                   AssetConfig.demoNetworkImage
              //               )
              //           )
              //       ),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment:MainAxisAlignment.end,
              //             children: [
              //               IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,))
              //             ],
              //           ),
              //           Spacer(),
              //           Text("Wedding Pics",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
              //             Shadow( // bottomLeft
              //                 offset: Offset(-1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // bottomRight
              //                 offset: Offset(1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topRight
              //                 offset: Offset(1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topLeft
              //                 offset: Offset(-1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //           ]),),
              //           Row(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("12 items",style: TextStyle(color: Colors.grey),),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 10,)
              //         ],
              //       ),
              //     ),
              //   ),
              //   Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)
              //     ),
              //     elevation: 6.0,
              //     child: Container(
              //       width: double.infinity,
              //       height: getHeight(context) / 2,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           image: DecorationImage(
              //               fit: BoxFit.cover,
              //               image: NetworkImage(
              //                   AssetConfig.demoNetworkImage
              //               )
              //           )
              //       ),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment:MainAxisAlignment.end,
              //             children: [
              //               IconButton(onPressed: (){}, icon: Icon(LineIcons.heart,color: Colors.grey,)),
              //               IconButton(onPressed: (){
              //                 showModalBottomSheet(
              //                     context: context, builder: (ct){
              //                   return Container(
              //                     height: 200,
              //                     child: Column(
              //                       children: [
              //                         MaterialButton(onPressed: (){},child: Text("Add Photos",style: TextStyle(color: Colors.blue),),),
              //                         Divider(),
              //                         MaterialButton(onPressed: (){},child: Text("Rename Album",style: TextStyle(color: Colors.blue),),),
              //                         Divider(),
              //                         MaterialButton(onPressed: (){},child: Text("Delete Albums",style: TextStyle(color: Colors.red),),),
              //                         Divider(),
              //                       ],
              //                     ),
              //                   );
              //                 });
              //               }, icon: Icon(LineIcons.cog,color: Colors.grey,))
              //             ],
              //           ),
              //           Spacer(),
              //           Text("Dubai Tuor",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,shadows: [
              //             Shadow( // bottomLeft
              //                 offset: Offset(-1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // bottomRight
              //                 offset: Offset(1.0, -1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topRight
              //                 offset: Offset(1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //             Shadow( // topLeft
              //                 offset: Offset(-1.0, 1.0),
              //                 color: Colors.grey
              //             ),
              //           ]),),
              //           Row(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("12 items",style: TextStyle(color: Colors.grey),),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 10,)
              //         ],
              //       ),
              //     ),
              //   )
              //
              // ], options: CarouselOptions(height: 290.0,aspectRatio: 15/9,
              //     viewportFraction: 0.9,enableInfiniteScroll: false)),
            ]
          ),
        ),
      ),
    );
  },
);
  }
}
