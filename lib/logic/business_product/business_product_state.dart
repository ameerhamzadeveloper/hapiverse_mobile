part of 'business_product_cubit.dart';

class BusinessProductState {
  List<File>? addProductImages;
  List<File>? addEventImages;
  List<Widget>? addProductImagesWidget;
  List<Widget>? addEventsImagesWidget;
  String? productName;
  String? productPrice;
  String? productDescription;
  List<ProductWithoutCollection>? productsWithoutCollections;
  List<ProductWithoutCollection>? otherProductsWithoutCollections;
  bool isSelectedAll = false;
  bool isDoneAvail = false;
  List<MyJob>? jobs;
  String? collName;
  List<ProductWithCollection>? productWithCollection;
  List<ProductWithCollection>? otherProductWithCollection;
  TimeOfDay eventTime = TimeOfDay.now();
  DateTime? eventDate;
  String? eventName;
  String? eventDescription;
  TextEditingController? eventLocation;
  TextEditingController? eventTimeController;
  TextEditingController? eventDateController;
  PlaceNearby? nearbyPlace;
  String adsTitle = 'title goes here';
  String adsSiteUrl = 'siteurl.abc';
  String adsDescription = 'description goese here';
  int? addType;
  bool? eventOnlineval;
  List<Event>? businessEvent;
  List<Event>? otherBusinessEvent;
  List<DiscountedProducts>? discountedProducts;
  String? audianceAge;
  String? adsContent;
  String? audianceStartAge;
  String? audianceEndAge;
  List<String>? locations;
  DateTime? adsStartDate;
  DateTime? adsEndDate;
  String? adsCurency;
  String? adsCurrencylocation;
  String? adsAmount = '5';
  String? adsImpressions;
  List<BusinessOrder>? businessOrders;
  int? productAdsIndex;
  List<BusinessAds>? businessAds;
  List<Bullitens>? bullitens;
  List<BulletinNotes>? bullitenNots;
  List<HapimartProduct>? hapimartProduct;


  BusinessProductState({
    this.addProductImages,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.addProductImagesWidget,
    this.productsWithoutCollections,
    required this.isSelectedAll,
    required this.isDoneAvail,
    this.collName,
    this.bullitens,
    this.productWithCollection,
    this.addEventImages,
    this.addEventsImagesWidget,
    required this.eventTime,
    this.eventDate,
    this.eventDescription,
    this.eventName,
    this.eventLocation,
    this.eventDateController,
    this.eventTimeController,
    this.nearbyPlace,
    required this.adsDescription,
    required this.adsSiteUrl,
    required this.adsTitle,
    this.eventOnlineval,
    this.businessEvent,
    this.discountedProducts,
    this.otherProductsWithoutCollections,
    this.otherProductWithCollection,
    this.otherBusinessEvent,
    this.addType,
    this.adsAmount,
    this.adsCurency,
    this.adsCurrencylocation,
    this.adsEndDate,
    this.adsImpressions,
    this.adsStartDate,
    this.audianceAge,
    this.locations,
    this.businessOrders,
    this.audianceEndAge,
    this.audianceStartAge,
    this.adsContent,
    this.productAdsIndex,
    this.businessAds,
    this.hapimartProduct,
    this.bullitenNots,
    this.jobs
      });

  BusinessProductState copyWith({
      List<File>? addProductImagess,
      List<File>? addEventImagess,
      String? productNamee,
      String? productPricee,
      String? productDescriptionn,
      List<Widget>? addProductImagesWidgett,
      List<Widget>? addEventImagesWidgett,
      List<ProductWithoutCollection>? productsWithoutCollectionss,
      bool? isSelectedAlll,
      bool? isDoneAvaill,
      String? collNamee,
      List<ProductWithCollection>? productWithCollectionn,
      TimeOfDay? eventTimee,
      DateTime? eventDatee,
      String? eventNamee,
      String? eventDescriptionn,
      TextEditingController? eventLocationn,
      TextEditingController? eventTimeControllerr,
      TextEditingController? eventDateControllerr,
    List<Bullitens>? bullitenss,
    PlaceNearby? nearbyPlacee,
    String? adsTitlee,
    String? adsSiteUrll,
    String? adsDescriptionn,
    bool? eventOnlinevall,
    List<Event>? businessEventt,
    List<DiscountedProducts>? discountedProductss,
    List<ProductWithoutCollection>? otherProductsWithoutCollectionss,
    List<ProductWithCollection>? otherProductWithCollectionn,
    List<Event>? otherBusinessEventt,
    int? addTypee,
    String? audianceAgee,
    List<String>? locationss,
    DateTime? adsStartDatee,
    DateTime? adsEndDatee,
    String? adsCurencyy,
    String? adsCurrencylocationn,
    String? adsAmountt,
    String? adsImpressionss,
    List<BusinessOrder>? businessOrderr,
    String? audianceStartAgee,
    String? audianceEndAgee,
    String? adsContentt,
    int? productAdsIndexx,
    List<BusinessAds>? businessAdss,
    List<HapimartProduct>? hapimartProductt,
    List<BulletinNotes>? bullitenNotss,
    List<MyJob>? jobss,
      }) {
    return BusinessProductState(
      addProductImages: addProductImagess ?? addProductImages,
      productName: productNamee ?? productName,
      productDescription: productDescriptionn ?? productDescription,
      productPrice: productPricee ?? productPrice,
      addProductImagesWidget: addProductImagesWidgett ?? addProductImagesWidget,
      productsWithoutCollections: productsWithoutCollectionss ?? productsWithoutCollections,
      isSelectedAll: isSelectedAlll ?? isSelectedAll,
      isDoneAvail: isDoneAvaill ?? isDoneAvail,
      collName: collNamee ?? collName,
      productWithCollection: productWithCollectionn ?? productWithCollection,
      addEventImages: addEventImagess ?? addEventImages,
      addEventsImagesWidget: addEventImagesWidgett ?? addEventsImagesWidget,
      eventTime: eventTimee ?? eventTime,
      eventDate: eventDatee ?? eventDate,
      eventDescription: eventDescriptionn ?? eventDescription,
      eventLocation: eventLocationn ?? eventLocation,
      eventName: eventNamee ?? eventName,
      eventDateController: eventDateControllerr ?? eventDateController,
      eventTimeController: eventTimeControllerr ?? eventTimeController,
      nearbyPlace: nearbyPlacee ?? nearbyPlace,
      adsDescription: adsDescriptionn ?? adsDescription,
      adsSiteUrl: adsSiteUrll ?? adsSiteUrl,
      adsTitle: adsTitlee ?? adsTitle,
      eventOnlineval: eventOnlinevall ?? eventOnlineval,
      businessEvent: businessEventt ?? businessEvent,
      discountedProducts: discountedProductss ?? discountedProducts,
      otherProductsWithoutCollections: otherProductsWithoutCollectionss ?? otherProductsWithoutCollections,
      otherProductWithCollection: otherProductWithCollectionn ?? otherProductWithCollection,
      otherBusinessEvent: otherBusinessEventt ?? otherBusinessEvent,
      addType: addTypee ?? addType,
      adsAmount: adsAmountt ?? adsAmount,
      adsCurency: adsCurencyy ??adsCurency,
      adsCurrencylocation: adsCurrencylocationn ?? adsCurrencylocation,
      adsEndDate: adsEndDatee ?? adsEndDate,
      adsImpressions: adsImpressionss ?? adsImpressions,
      adsStartDate: adsStartDatee ?? adsStartDate,
      audianceAge: audianceAgee ?? audianceAge,
      locations: locationss ?? locations,
      businessOrders: businessOrderr ?? businessOrders,
      audianceEndAge: audianceEndAgee ?? audianceEndAge,
      audianceStartAge:audianceStartAgee ?? audianceStartAge,
      adsContent: adsContentt ?? adsContent,
      productAdsIndex: productAdsIndexx ?? productAdsIndex,
      businessAds: businessAdss ?? businessAds,
      hapimartProduct: hapimartProductt ?? hapimartProduct,
      bullitens: bullitenss ?? bullitens,
      bullitenNots: bullitenNotss ?? bullitenNots,
      jobs: jobss ?? jobs
    );
  }
}
