import 'dart:convert';
import 'package:flutter/material.dart';

class AssetConfig{
  static const String kLogo = "assets/logo.png";
  static const String kSigninVector = "assets/signin.png";
  static const String postBgBase = 'assets/post_backgrounds/';
  static const String useMask = 'assets/use_mask.png';
  static const String avoidClose = 'assets/avoid_close.png';
  static const String washHand = 'assets/clean_hand.png';
  static const String imageLoading = 'assets/image_loading.jpeg';
  static const String demoNetworkImage = "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80";

  static Image imageFromBase64String(
      String base64String,double height,double width,BoxFit fit) {
    return Image.memory(base64Decode(base64String),height: height,width: width,fit: fit,);
  }
  static const String paypalPng = "https://1000logos.net/wp-content/uploads/2021/04/Paypal-logo.png";
  static const String cryptoIcon = "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Bitcoin-BTC-icon.png";
  static const String diamondPlan = "assets/plans/Diamond.png";
  static const String goldPlan = "assets/plans/Gold.png";
  static const String platinumPlan = "assets/plans/Platinum.png";
  static const String vipPlan = "assets/plans/Vip.png";

  static const String verified = "assets/plans/verified.png";
  static const String noImage = "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg";

}