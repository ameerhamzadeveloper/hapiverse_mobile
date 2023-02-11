import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

import '../../../logic/business_product/business_product_cubit.dart';
import '../../../utils/constants.dart';
class PreviewEventImage extends StatefulWidget {
  final int index;
  const PreviewEventImage({Key? key,required this.index}) : super(key: key);

  @override
  _PreviewEventImageState createState() => _PreviewEventImageState();
}

class _PreviewEventImageState extends State<PreviewEventImage> {
  PhotoViewScaleStateController controller = PhotoViewScaleStateController();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessProductCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: PhotoView(
                  // enableRotation: true,
                  tightMode: true,
                  basePosition: Alignment.center,
                  scaleStateController: controller,
                  onScaleEnd: (context,end,e){
                    if(controller.isZooming){
                      controller.reset();
                    }
                  },
                  imageProvider: FileImage(state.addEventImages![widget.index]),),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    minWidth: getWidth(context),
                    shape: StadiumBorder(),
                    color: Colors.red,
                    onPressed: (){
                      Navigator.pop(context);
                      Future.delayed(Duration(milliseconds: 600),(){
                        bloc.deleteEventImage(widget.index);
                      });
                    },
                    child: Text("Delete Image",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: ()=> Navigator.pop(context),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
