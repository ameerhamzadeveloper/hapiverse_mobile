import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:happiverse/data/model/hapimart_products_model.dart';
import 'package:happiverse/utils/user_url.dart';
import 'package:happiverse/views/business_tools/ads_manager/ads_manager.dart';
import '../../data/model/business_order_model.dart';
import '../../data/model/fetch_bulletin_nots.dart';
import '../../data/model/fetch_bulliten_model.dart';
import '../../data/model/fetch_discounted_product_model.dart';
import '../../data/model/fetch_job_model.dart';
import '../../data/model/fetch_my_ads_model.dart';
import '../../data/model/fetch_my_job.dart';
import '../../data/model/product_with_collections.dart';
import '../../data/model/products_without_collection_model.dart';
import '../../data/repository/business_tools_repository.dart';
import '../../data/repository/post_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:meta/meta.dart';

import '../../data/model/fetch_event_model.dart';
import '../../data/model/post_places_model.dart';
import '../../utils/business_url.dart';
import '../../utils/constants.dart';

part 'business_product_state.dart';

class BusinessProductCubit extends Cubit<BusinessProductState> {
  BusinessProductCubit() : super(BusinessProductState(
    isSelectedAll: false,
    isDoneAvail: false,
    eventTime: TimeOfDay.now(),
    adsTitle: "Title goes here",
    adsSiteUrl: "siteurl.abc",
    adsDescription: 'Description goes here',
    eventOnlineval: false,
    audianceAge: "4-65+",
    adsCurrencylocation: 'United States',
    adsCurency: 'USD',
    adsAmount: '5',
    adsImpressions: '5000'
  ));
  final repository = BusinessToolsRepository();
  final postRepository = PostRepository();
  List<File> _addProductImages = [];
  List<File> _addEventsImages = [];
  List<Widget> _addProductImagesWidget = [];
  List<Widget> _addEventsImagesWidget = [];

  pickProductImage(int source)async{
    if(source == 2){
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true
      );
      for(var i = 0; i < result!.files.length;i++){
        _addProductImages.add(File(result.files[i].path!));
      }
      _addProductImagesWidget.clear();
      for(var i in _addProductImages){
        print(i);
        _addProductImagesWidget.add(Container(
          width: double.infinity,
          height: double.infinity / 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                      File(i.path)
                  )
              )
          ),
        ));
      }
      print(_addProductImagesWidget.length);
      _addProductImagesWidget.add(Container(
        height: double.infinity / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200]
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(LineIcons.camera),
              SizedBox(width: 5,),
              Text("Add Images"),
            ],
          ),
        ),
      ),);
      emit(state.copyWith(addProductImagess: _addProductImages,addProductImagesWidgett: _addProductImagesWidget));
    }else{
      XFile? image = await ImagePicker().pickImage(source:  ImageSource.camera);
      _addProductImages.add(File(image!.path));
      _addProductImagesWidget.clear();
      for(var i in _addProductImages){
        print(i);
        _addProductImagesWidget.add(Container(
          width: double.infinity,
          height: double.infinity / 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                      File(i.path)
                  )
              )
          ),
        ));
      }
      print(_addProductImagesWidget.length);
      _addProductImagesWidget.add(Container(
        height: double.infinity / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200]
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(LineIcons.camera),
              SizedBox(width: 5,),
              Text("Add Images"),
            ],
          ),
        ),
      ),);
      emit(state.copyWith(addProductImagess: _addProductImages,addProductImagesWidgett: _addProductImagesWidget));
    }

  }

  pickEventsImages(int source)async{
    if(source == 2){
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: true
      );
      for(var i = 0; i < result!.files.length;i++){
        _addEventsImages.add(File(result.files[i].path!));
      }
      _addEventsImagesWidget.clear();
      for(var i in _addEventsImages){
        print(i);
        _addEventsImagesWidget.add(Container(
          width: double.infinity,
          height: double.infinity / 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                      File(i.path)
                  )
              )
          ),
        ));
      }
      print(_addEventsImagesWidget.length);
      _addEventsImagesWidget.add(Container(
        height: double.infinity / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200]
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(LineIcons.camera),
              SizedBox(width: 5,),
              Text("Add Images"),
            ],
          ),
        ),
      ),);
      emit(state.copyWith(addEventImagess: _addEventsImages,addEventImagesWidgett: _addEventsImagesWidget));
    }else{
      XFile? image = await ImagePicker().pickImage(source:  ImageSource.camera);
      _addEventsImages.add(File(image!.path));
      _addEventsImagesWidget.clear();
      for(var i in _addEventsImages){
        print(i);
        _addEventsImagesWidget.add(Container(
          width: double.infinity,
          height: double.infinity / 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                      File(i.path)
                  )
              )
          ),
        ));
      }
      print(_addEventsImagesWidget.length);
      _addEventsImagesWidget.add(Container(
        height: double.infinity / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200]
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(LineIcons.camera),
              SizedBox(width: 5,),
              Text("Add Images"),
            ],
          ),
        ),
      ),);
      emit(state.copyWith(addEventImagess: _addEventsImages,addEventImagesWidgett: _addEventsImagesWidget));
    }

  }

  deletProductAddImage(int index)async{
    _addProductImages.removeAt(index);
    _addProductImagesWidget.clear();
    for(var i in _addProductImages){
      print(i);
      _addProductImagesWidget.add(Container(
        width: double.infinity,
        height: double.infinity / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                    File(i.path)
                )
            )
        ),
      ));
    }
    print(_addProductImagesWidget.length);
    _addProductImagesWidget.add(Container(
      height: double.infinity / 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200]
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(LineIcons.camera),
            SizedBox(width: 5,),
            Text("Add Images"),
          ],
        ),
      ),
    ),);
    emit(state.copyWith(addProductImagess: _addProductImages,addProductImagesWidgett: _addProductImagesWidget));
  }

  deleteEventImage(int index)async{
    _addEventsImages.removeAt(index);
    _addEventsImagesWidget.clear();
    for(var i in _addEventsImages){
      print(i);
      _addEventsImagesWidget.add(Container(
        width: double.infinity,
        height: double.infinity / 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                    File(i.path)
                )
            )
        ),
      ));
    }
    print(_addEventsImagesWidget.length);
    _addEventsImagesWidget.add(Container(
      height: double.infinity / 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200]
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(LineIcons.camera),
            SizedBox(width: 5,),
            Text("Add Images"),
          ],
        ),
      ),
    ),);
    emit(state.copyWith(addEventImagess: _addEventsImages,addEventImagesWidgett: _addEventsImagesWidget));
  }

  assignProductVal(int type,String val){
    switch(type){
      case 1:
        emit(state.copyWith(productNamee: val));
        break;
      case 2:
        emit(state.copyWith(productPricee: val));
        break;
      case 3:
        emit(state.copyWith(productDescriptionn: val));
        break;
    }
  }

  addProducts(String userId,String token,BuildContext context){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    Map<String,dynamic> body = {
      'businessId':userId,
      'productName':state.productName,
      'productPrice':state.productPrice,
      'productdescription':state.productDescription,
    };
    repository.addProducts(body, token, userId,_addProductImages).then((response){
      Navigator.pop(context);
      print(response.body);
      var dec = jsonDecode(response.body);
      fetchProductsWithoutCollections(token, userId);
      fetchProductWithCollection(token, userId);
      if(dec['message'] == 'Data successfuly save'){
        _addProductImages = [];
        _addProductImagesWidget = [];
        emit(state.copyWith(addProductImagess: _addProductImages,productNamee: "",productPricee: "",addProductImagesWidgett: _addProductImagesWidget));
        Fluttertoast.showToast(msg: "Product added successfully");
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Something Went wrong!",textColor: Colors.red);
      }
    });
  }
  List<ProductWithoutCollection> productWithoutColl= [];
  fetchProductsWithoutCollections(String token,String userId){
    repository.fetchProductsWithoutCollections(token, userId).then((response){
      print(response.body);
      var data = productsWithoutCollectionModelFromJson(response.body);
      productWithoutColl = data.data;
      print("colll");
      if(data.message == "Data availabe"){
        emit(state.copyWith(productsWithoutCollectionss: productWithoutColl));
      }else{
        emit(state.copyWith(productsWithoutCollectionss: []));
      }
    });
  }

  fetchOtherProductsWithoutCollections(String token,String userId,String otherId){
    repository.fetchProductsWithoutCollections(token, userId,otherId: otherId).then((response){
      print(response.body);
      var data = productsWithoutCollectionModelFromJson(response.body);
      if(data.message == "Data availabe"){
        emit(state.copyWith(otherProductsWithoutCollectionss: data.data));
      }else{
        emit(state.copyWith(otherProductsWithoutCollectionss: []));
      }
    });
  }

  checkProductForCollection(var i){
    productWithoutColl[i].isSelected = !productWithoutColl[i].isSelected;
    emit(state.copyWith(productsWithoutCollectionss: productWithoutColl));
    for(var i in productWithoutColl){
      if(i.isSelected){
        emit(state.copyWith(isDoneAvaill: true));
      }
    }
  }

  chooseProductForAds(var i){
    for(var i in productWithoutColl){
      i.isSelected = false;
    }
    productWithoutColl[i].isSelected = !productWithoutColl[i].isSelected;
    emit(state.copyWith(productsWithoutCollectionss: productWithoutColl,adsContentt: productWithoutColl[i].productId.toString(),productAdsIndexx: i));
    for(var i in productWithoutColl){
      if(i.isSelected){
        emit(state.copyWith(isDoneAvaill: true));
      }
    }
  }

  selectDeselectAllProductForCollection(int mode){
    // 0 for selection all
    // 1 for deselection all
    for(var  i in productWithoutColl){
      if(mode == 0){
        i.isSelected = true;
        emit(state.copyWith(productsWithoutCollectionss: productWithoutColl,isSelectedAlll: true,isDoneAvaill: true));
      }else{
        i.isSelected = false;
        emit(state.copyWith(productsWithoutCollectionss: productWithoutColl,isSelectedAlll: false,isDoneAvaill: false));
      }
    }
  }

  assignCollName(String val){
    emit(state.copyWith(collNamee: val));
  }

  addCollection(String userId,String token,BuildContext context){
    showDialog(context: context, builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    Map<String,dynamic> body = {
      'businessId':userId,
      'collectionName':state.collName
    };
    String productId = '';
    for(var i in productWithoutColl){
      if(i.isSelected){
        productId = productId == ''? '${i.productId}' : "$productId , ${i.productId}";
      }
    }
    body['productList'] = productId;
    repository.addCollection(token, userId, body).then((response){
      print(response.body);
      Navigator.pop(context);
      Navigator.pop(context);
      fetchProductWithCollection(userId, token);
    });
  }
  List<ProductWithCollection> productWithColl = [];
  fetchProductWithCollection(String userId,String token){
    print("coll with collection ");
    repository.fetchProductWithCollection(token, userId).then((response){
      print("coll ${response.body}");

      var data = productsWithCollectionFromJson(response.body);
      productWithColl = data.data;
      print("with colll-- - --- ${data.data}");
      emit(state.copyWith(productWithCollectionn: data.data));
    });
  }

  fetchOtherProductWithCollection(String userId,String token,String otherId){
    print("coll with collection ");
    repository.fetchProductWithCollection(token, userId,otherId: otherId).then((response){
      print("coll ${response.body}");

      var data = productsWithCollectionFromJson(response.body);
      emit(state.copyWith(otherProductWithCollectionn: data.data));
    });
  }

  assignEventValue(int type,String val){
    switch(type){
      case 1:
        emit(state.copyWith(eventNamee: val));
        break;
      case 2:
        emit(state.copyWith(eventDescriptionn: val));
        break;
    }
  }

  Future<void> selectEventTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.eventTime) {
      emit(state.copyWith(eventTimee: newTime,eventTimeControllerr: TextEditingController(text: "Time ${newTime.format(context)}")));
    }
    print(state.eventTime.format(context));
  }
  DateTime d = DateTime.now();
  Future<void> selectEventDate(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(d.year + 15,d.month,d.day)
    );
    DateFormat format = DateFormat('dd MMM yyyy');
    if (newDate != null && newDate != state.eventDate) {
      emit(state.copyWith(eventDatee: newDate,eventDateControllerr: TextEditingController(text: format.format(newDate))));
    }
    print(state.eventTime.format(context));
  }

  getNeabyLocations() async {
    Position pos = await Geolocator.getCurrentPosition();
    postRepository.getNearbyPlaces(pos.latitude, pos.longitude).then((response) {
      print(response.body);
      var data = placeNearbyFromJson(response.body);
      emit(state.copyWith(nearbyPlacee: data));
    });
  }

  assignAdsVal(int type,String val){
    switch(type){
      case 1:
        emit(state.copyWith(adsSiteUrll: val));
        break;
      case 2:
        emit(state.copyWith(adsTitlee: val));
        break;
      case 3:
        emit(state.copyWith(adsDescriptionn: val));
        break;
    }
  }

  setAdType(int type){
    emit(state.copyWith(addTypee: type));
  }

  assingEventOnlineVal(bool val){
    emit(state.copyWith(eventOnlinevall: val));
  }

  addEvent(String userId,String token,BuildContext context){
    showDialog(context: context,barrierDismissible: false, builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    Map<String,dynamic> body = {
      'businessId':userId,
      'eventName':state.eventName,
      'eventDescription':state.eventDescription,
      'eventTime':state.eventTime.toString(),
      'eventDate':state.eventDate.toString(),
      'latitude':'09768554',
      'longitude':'32434434',
      'address': state.eventLocation ?? "Online",
    };
    print(state.eventTime.toString());
    repository.addEvent(body, token, userId,_addEventsImages).then((response){
      Navigator.pop(context);
      print(response.body);
      var dec = json.decode(response.body);
      fetchBusinessEvent(userId,token);
      if(dec['message'] == 'Data successfuly save'){
        _addEventsImages = [];
        _addEventsImagesWidget = [];
        emit(state.copyWith(addProductImagess: _addEventsImages,eventNamee: "",eventDescriptionn: "",addProductImagesWidgett: _addEventsImagesWidget));
        Fluttertoast.showToast(msg: "Event added successfully");
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Something Went wrong!",textColor: Colors.red);
      }
    });
  }
  fetchBusinessEvent(String userid,String token){
    repository.fetchEvent(token, userid).then((response){
      print(response.body);
      var dec = json.decode(response.body);
      if(dec['message'] == 'Data availabe'){
        var data = fetchEventModelFromJson(response.body);
        emit(state.copyWith(businessEventt: data.data));
      }else{
        emit(state.copyWith(businessEventt: []));
      }

    });
  }

  fetchOtherBusinessEvent(String userid,String token,String otherID){
    repository.fetchEvent(token, userid,otherID: otherID).then((response){
      print(response.body);
      print("Event");
      var dec = json.decode(response.body);
      if(dec['message'] == 'Data availabe'){
        var data = fetchEventModelFromJson(response.body);
        emit(state.copyWith(otherBusinessEventt: data.data));
      }else{
        emit(state.copyWith(otherBusinessEventt: []));
      }

    });
  }

  deleteEvent(String userId,String token,String eventId){
    repository.deleteEvent(token, userId, eventId).then((response){
      print(response.body);
      fetchBusinessEvent(userId, token);
      var ded = json.decode(response.body);
      if(ded['message'] == 'successfuly deleted'){
        Fluttertoast.showToast(msg: "Event Deleted Successfully");
      }else{
        Fluttertoast.showToast(msg: "Something went wrong!");
      }

    });
  }

  fetchDiscountedProducts(String userId,String token){
    repository.fetchDiscountedProducts(token, userId).then((response){
      var de = json.decode(response.body);
      if(de['message'] == 'Data availabe'){
        var data = fetchDiscountedProductsModelFromJson(response.body);
        emit(state.copyWith(discountedProductss: data.data));
      }else{
        emit(state.copyWith(discountedProductss: []));
      }
    });
  }

  addProductDiscount(String userId,String token,String productId,String discountedPrice,BuildContext context,String discountActive){
    showDialog(context: context, builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    print(discountActive);
    repository.addProductDiscount(token, userId, productId, discountedPrice,discountActive).then((reponse){
      fetchDiscountedProducts(userId, token);
      fetchProductsWithoutCollections(token, userId);
      print(reponse.body);
      Navigator.pop(context);
    });
  }

  addBusinessRating(String userid,String token,String raterId,String rating,String comment,BuildContext context){
    print("ta $rating");
    repository.addBusinessRating(token, userid, rating, comment, raterId).then((response){
      print(response.body);
      Navigator.pop(context);
    });
  }

  generateRefferalCode(String token,String userId,String accountType,String planId,String code){
    print(code);
    print(userId);
    print(token);
    print(accountType);
    print(planId);
    Map<String,dynamic> map = {
      'refferalCode': code,
      'accountType': accountType,
      'planId': planId,
      'userId': userId,
      'token': token,
    };
    repository.generateRefferalCode(map).then((response) {
      print(response.body);
    });
  }
  List<String> adsLocations = [];
  setAdsAudionce(String audienceAge,String start,String end){
    emit(state.copyWith(audianceAgee: audienceAge,audianceStartAgee: start,audianceEndAgee: end));
  }

  // DateTime d = DateTime.now();
  setInitialAdsLcoations(){
    adsLocations.clear();
    emit(state.copyWith(locationss: adsLocations));
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition().then((value) async{
      List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);
      print(placemarks);
      adsLocations.add(placemarks[0].country!);
      emit(state.copyWith(locationss: adsLocations,audianceEndAgee: '65+',audianceStartAgee: '4',adsStartDatee: DateTime(d.year,d.month,d.day),adsEndDatee: DateTime(d.year,d.month + 1,d.day)));
      // var address = "${placemarks[0].street},${placemarks[0].locality} ${placemarks[0].administrativeArea} ${placemarks[0].country}" ;
    });
  }

  setAdsDate(DateTime start,DateTime end){
    emit(state.copyWith(adsStartDatee: start,adsEndDatee: end));
  }

  setCurrency(String currency,String lcoation,String amount,String impressions){
    emit(state.copyWith(adsCurencyy: currency,adsCurrencylocationn: lcoation,adsAmountt: amount,adsImpressionss: impressions));
  }



  removeCountry(int index){
    adsLocations.removeAt(index);
    emit(state.copyWith(locationss: adsLocations));
  }

  addAdsLocations(String adsLocation){
    adsLocations.add(adsLocation);
    emit(state.copyWith(locationss: adsLocations,eventLocationn: TextEditingController(text: adsLocation)));
  }

  fetchQueOrder(String userId,String token){
    repository.fetchMyOrdersBusiness(userId, token).then((response) {
      print(response.body);
      var data = businessOrdersModelFromJson(response.body);
      emit(state.copyWith(businessOrderr: data.data));
    });
  }


  shipOrder(String userId,String token,String orderId,String shipFee,String shipBy,BuildContext context){
    showDialog(context: context, builder: (ctx){
      return const AlertDialog(
        content: CupertinoActivityIndicator(),
      );
    });
    repository.shipOrder(userId, token,shipBy,shipFee,orderId).then((response) {
      print(response.body);
      fetchQueOrder(userId,token);
      Fluttertoast.showToast(msg: "Order Shipped Succesfully");
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  createAds(String userId,String token,BuildContext context){
    Map<String,dynamic> map = {
      'businessId':userId,
      'adDescription': state.adsDescription,
      'audianceStartAge': state.audianceStartAge,
      'audianceEndAge': state.audianceEndAge,
      'startDate': state.adsStartDate.toString(),
      'endDate': state.adsEndDate.toString(),
      'totalBudget': state.adsAmount,
      'status': '1',
      'totalimpressions':state.adsImpressions
    };
    if(state.addType == 2){
      map['adType'] = 'website';
      map['adContent'] = state.adsSiteUrl;
      map['adTitle'] = state.adsTitle;
    }else if(state.addType == 3){
      map['adType'] = 'post';
      map['adContent'] = state.adsSiteUrl;
      map['adTitle'] = state.adsTitle;
    }else if(state.addType == 1){
      map['adType'] = 'product';
      map['adContent'] = state.productsWithoutCollections![state.productAdsIndex!].productId!;
      map['adTitle'] = state.productsWithoutCollections![state.productAdsIndex!].productName!;
    }
    print(map);
    repository.createAds(map, token).then((response) {
      print(response.body);
      var de = json.decode(response.body);
      if(de['message'] == 'Data successfuly save'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdsManager()));
      }
    });
  }

  fetchmyAds(String userId,String token){
    print(userId);
    repository.callGetApi({'userId':userId,'token':token},"$fetchBusinessAdsUrl$userId").then((value){
      print(value.body);
      var data = fetchAdsModelFromJson(value.body);
      emit(state.copyWith(businessAdss: data.data));
    });
  }

  updateAdsStatus(String userId,String token,String adId,String status){
    Map<String,dynamic> body = {'userId':userId,'token':token,'status':status,'businessId':userId,};
    repository.callPostApi(body,"$fetchBusinessAdsUrl${adId}").then((value){
     var dec = json.decode(value.body);
     // print(dec);
     if(dec['message'] == "My ad update successfully"){
       Fluttertoast.showToast(msg: "Status Changed Successfully");
     }
     fetchmyAds(userId, token);
    });
  }

  deleteAds(String userId,String token,String adId){
    repository.callDeletApi({'userId':userId,'token':token,'buinessId':userId},"$fetchBusinessAdsUrl$adId?businessId=${userId}").then((value){
      var dec = json.decode(value.body);
      fetchmyAds(userId, token);
    });
  }

  deletProducts(String productId,String userId,String token){
    repository.callDeletApi({}, "$deletProductUrl$productId").then((value) {
      print(value.body);
      var de = json.decode(value.body);
      if(de['message'] == "Product deleted successfully"){
        Fluttertoast.showToast(msg: "Product Deleted Successfully");
      }else{
        Fluttertoast.showToast(msg: "Something went wrong");
      }
      fetchProductsWithoutCollections(token, userId);
      fetchProductWithCollection(token, userId);
      print("$deletProductUrl/$productId");
    });
  }

  deletCollection(String collectionId,String userId,String token){
    repository.callDeletApi({}, "${deletCollectionUrl}$collectionId").then((value) {
      print(value.body);
      var de = json.decode(value.body);
      if(de['message'] == "Collection deleted successfully"){
        Fluttertoast.showToast(msg: "Collection deleted successfully");
      }else{
        Fluttertoast.showToast(msg: "Something went wrong");
      }
      // fetchProductsWithoutCollections(token, userId);
      fetchProductWithCollection(token, userId);
      print("${deletCollectionUrl}/$collectionId");
    });
  }

  changeOrderStatus(String orderId,String orderStatus,String userId,String token,){
    repository.callPostApi({
      'orderId':orderId,
      'status':orderStatus,
      'token':token,
      'userId':userId,
    }, cancelOrderUrl).then((value) {
      print(value.body);
      var de = json.decode(value.body);
      if(de['message'] == "Order status updated successfully"){
        Fluttertoast.showToast(msg: "Order Shipped Successfully");
      }else{
        Fluttertoast.showToast(msg: "Something went wrong");
      }
      // fetchProductsWithoutCollections(token, userId);
      fetchQueOrder(userId,token);
      // print("${deletCollectionUrl}/$collectionId");
    });
  }

  stripePaymentSignUp(String amount,BuildContext context,Map<String,dynamic> cardInfo,String userId,String token){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (ctx){
          return const AlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });
    Map<String,dynamic> map = {
      'card_no': cardInfo['card_no'],
      'expiry_month': cardInfo['expiry_month'],
      'expiry_year': cardInfo['expiry_year'],
      'cvv': cardInfo['cvv'],
      'amount': amount,
      'description': "Ads Payment",
      'email': userId,
      'token': token,
      'userId': userId,
      'card_holder_name':cardInfo['name'],
    };
    print(map['expiry_month']);
    print(map['expiry_year']);
    repository.callPostApi(map,stripePaymentUrl).then((value){
      Navigator.pop(context);
      print(value.body);
      var de = json.decode(value.body);
      if(de['message'] == "successfully charged"){
        createAds(userId, token,context);
      }else{
        Fluttertoast.showToast(msg: "Something went wrong \n${de['message']}");
      }
    });
  }


  getHapimartProducts(String startFrom,String max)async{
    Uri url = Uri.parse('https://www.hapiverse.com/ci_api/API/v1/common/FetchProduct');
    Map<String,dynamic> body = {
      'totalPerPage': max,
      'startFrom': startFrom
    };
    http.Response response = await http.post(url,body:body);

    if (response.statusCode == 200) {
      var data = hapimartProductsModelFromJson(response.body);
      emit(state.copyWith(hapimartProductt: data.data));
    }
    else {
      emit(state.copyWith(hapimartProductt: []));
    }
  }


  fetchBullitenBoards(String userId,String token){
    repository.callPostApiCI({'userId':userId,'token':token,'businessId':userId}, FetchBullitenBoardUrl).then((value){
      print(value.body);
      var data = fetchBullitenModelFromJson(value.body);
      var de = json.decode(value.body);
      if(de['message'] == "Data availabe"){
        emit(state.copyWith(bullitenss: data.data));
      }else{
        emit(state.copyWith(bullitenss: []));
      }

    });
  }

  fetchBullitenNotes(String userId,String token,String id){
    repository.callPostApiCI({'userId':userId,'token':token,'businessId':userId,'bullitenId':id}, fetchBullitenNoteUrl).then((value){
      print(value.body);
      var data = fetchBullitenNotesModelFromJson(value.body);
      var de = json.decode(value.body);
      if(de['message'] == "Data availabe"){
        emit(state.copyWith(bullitenNotss: data.data));
      }else{
        emit(state.copyWith(bullitenss: []));
      }

    });
  }


  addBulletin(String userId,String token,String title){
    repository.callPostApiCI({'userId':userId,'token':token,'businessId':userId,'title':title,"body":'1'}, AddBullitenBoardUrl).then((value){
      print(value.body);
      fetchBullitenBoards(userId, token);
    });
  }

  addBulletinNotes(String userId,String token,String title,String bullitenId){
    repository.callPostApiCI({'userId':userId,'token':token,'businessId':userId,'title':title,"body":'1','bullitenId':bullitenId}, addBullitenNoteUrl).then((value){
      print(value.body);
      fetchBullitenNotes(userId, token,bullitenId);
    });
  }

  deleteBulletin(String userId,String token,String id){
    print(id);
    repository.callPostApiCI({'userId':userId,'token':token,'businessId':userId,'bullitenId':id}, deleteBullitenBoardUrl).then((value){
      print(value.body);
      fetchBullitenBoards(userId, token);
    });
  }

  addJob(String userId,String token,String title,String name,String workPlace,String jobtype,String description){
    Map<String,dynamic> body = {
      'userId':userId,
      'token':token,
      'businessId':userId,
      'jobTitle':title,
      "companyName":name,
      "workplaceType":workPlace,
      "jobType":jobtype,
      "jobDescription":description,
    };
    repository.callPostApiCI(body, addJobUrl).then((value){
      print(value.body);

    });
  }

  fetchMyJobs(String userId,String token){
    Map<String,dynamic> body = {
      'userId':userId,
      'token':token,
      'businessId':userId,
    };
    repository.callPostApiCI(body, fetchMyJobUrl).then((value){
      print(value.body);
      var data = fetchMyJobsFromJson(value.body);
      emit(state.copyWith(jobss: data.data));
    });
  }

  deletJob(String userId,String token,String jobId){
    Map<String,dynamic> body = {
      'userId':userId,
      'token':token,
      'jobId':jobId,
    };
    repository.callPostApiCI(body, deleteJobUrl).then((value){
      print(value.body);
      fetchMyJobs(userId, token);
    });
  }

}
