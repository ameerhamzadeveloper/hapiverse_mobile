import 'dart:io';
import '../../utils/business_url.dart';
import '../../utils/user_url.dart';
import 'package:http/http.dart' as http;

class RegisterProvider{

  Future<http.Response> loginUser(Map<String,Object> body)async{
    http.Response response = await http.post(
        Uri.parse(loginUrl),
        body: body,
    );
    return response;
  }

  Future<http.Response> createProfile(Map<String,String> body,File image)async{
    var request =  http.MultipartRequest('POST',Uri.parse(createProfileUrl));
    var imagee = await http.MultipartFile.fromPath('profileImageUrl', image.path);
    request.fields['userName'] = body['userName']!;
    request.fields['email'] = body['email']!;
    request.fields['DOB'] = body['DOB']!;
    request.fields['martialStatus'] = body['martialStatus']!;
    request.fields['gender'] = body['gender']!;
    request.fields['city'] = '';
    request.fields['postCode'] = '';
    request.fields['country'] = body['country']!;
    request.fields['lat'] = body['lat']!;
    request.fields['long'] = body['long']!;
    request.fields['userTypeId'] = '1';
    request.fields['password'] = body['password']!;
    request.fields['phoneNo'] = body['phoneNo']!;
    request.fields['height'] = body['height']!;
    request.fields['hairColor'] = body['hairColor']!;
    request.fields['education_title'] = body['education_title']!;
    request.fields['education_level'] = body['education_level']!;
    request.fields['education_startYear'] = body['education_startYear']!;
    request.fields['education_location'] = body['education_location']!;
    request.fields['work_title'] = body['work_title']!;
    request.fields['work_description'] = body['work_description']!;
    request.fields['work_startDate'] = body['work_startDate']!;
    request.fields['current_working'] = body['current_working']!;
    request.fields['work_endDate'] = body['work_endDate']!;
    request.fields['religion'] = body['religion']!;
    request.fields['education_endDate'] = body['education_endDate']!;
    request.files.add(imagee);
    http.Response response = await http.Response.fromStream(await request.send());
    return response;

  }

  Future<http.Response> createBusinessProfile(Map<String,String> body,File image,File coverImagee)async{
    var request =  http.MultipartRequest('POST',Uri.parse(createBusinessProfileUrl));
    var imagee = await http.MultipartFile.fromPath('logoImageUrl', image.path);
    var coverImage = await http.MultipartFile.fromPath('featureImageUrl', coverImagee.path);
    request.files.add(imagee);
    request.files.add(coverImage);
    request.fields['businessName'] = body['businessName']!;
    request.fields['email'] = body['email']!;
    request.fields['ownerName'] = body['ownerName']!;
    request.fields['vatNumber'] = body['vatNumber']!;
    request.fields['latitude'] = body['latitude']!;
    request.fields['longitude'] = body['longitude']!;
    request.fields['country'] = body['country']!;
    request.fields['city'] = body['city']!;
    request.fields['businessContact'] = body['businessContact']!;
    request.fields['isAlwaysOpen'] = body['isAlwaysOpen']!;
    request.fields['password'] = body['password']!;
    request.fields['businessType'] = body['businessType']!;
    request.fields['country'] = body['country']!;
    request.fields['city'] = body['city']!;
    request.fields['address'] = body['address']!;
    request.fields['categoryId'] = '';
    request.fields['featureImageUrl'] = '';
    request.fields['day'] = body['day']!;
    request.fields['openTime'] = body['openTime']!;
    request.fields['closeTime'] = body['closeTime']!;

    print(request.fields.toString());
    http.Response response = await http.Response.fromStream(await request.send());
    return response;

  }

  Future<http.Response> addSubCatInterest(Map<String,dynamic> map)async{
    http.Response response = await http.post(Uri.parse(addSubCatURl),body: map);
    return response;
  }

  Future<http.Response> getCategory()async{
    http.Response response = await http.post(Uri.parse(getInterestUrl));
    print(response.body);
    return response;
  }

  Future<http.Response> pushNotification(String userID,Map<String,dynamic> map,String token)async{
    http.Response response = await http.post(
      Uri.parse(pushNotificationUrl),
      body: map,
      headers: {
        'token': token,
        'userId': userID,
      }
    );
    return response;
  }
  Future<http.Response> fetchNotifications(String userID,Map<String,dynamic> map,String token)async{
    http.Response response = await http.post(
        Uri.parse(fetchNotificationUrl),
        body: map,
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return response;
  }
  Future<http.Response> addViewNotification(String userID,String notiId,String token)async{
    http.Response response = await http.post(
        Uri.parse(addViewNotificationUrl),
        body: {
          'notificationId':notiId
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return response;
  }

  Future<http.Response> verifyEmail(String email)async{
    http.Response response = await http.post(
        Uri.parse(verifyEmailUrl),
        body: {
          'email':email
        },
    );
    return response;
  }

  Future<http.Response> addUserPlans(Map<String ,dynamic> map)async{
    http.Response response = await http.post(
      Uri.parse(addPlanUrl),
      body: map,
    );
    return response;
  }


  Future<http.Response> checkReferalCode(String code)async{
    http.Response response = await http.post(
      Uri.parse(checkReferalCodeUrl),
      body: {
        'refferalCode':code
      },
    );
    return response;
  }


  Future<http.Response> checkAccountStatus(String userID,String token)async{
    http.Response response = await http.post(
        Uri.parse(fetchAccountStatusUrl),
        body: {
          'userId':userID,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return response;
  }
  Future<http.Response> addRemvoePrivateAccount(String userID,String token,bool isRemove)async{
    http.Response response = await http.post(
        Uri.parse(updateMyProfileUrl),
        body: {
          'userId':token,
          'isPrivate':isRemove ? '0':'1',
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return response;
  }
  Future<http.Response> fetchMyPlan(String email)async{
    http.Response response = await http.post(
        Uri.parse(fetchPlanUrl),
        body: {
          'email':email,
        },
    );
    return response;
  }

  Future<http.Response> stripePayment(Map<String,dynamic> mapData)async{
    http.Response response = await http.post(
      Uri.parse(stripePaymentUrl),
      body: {
        'email':mapData['email'],
        'card_no':mapData['card_no'],
        'expiry_month':mapData['expiry_month'],
        'expiry_year':mapData['expiry_year'],
        'cvv':mapData['cvv'],
        'amount':mapData['amount'],
        'description':mapData['description'],
      },
    );
    return response;
  }

  Future<http.Response> callGetApi(String url)async{
    http.Response response = await http.get(
      Uri.parse(url),
    );
    return response;
  }
}