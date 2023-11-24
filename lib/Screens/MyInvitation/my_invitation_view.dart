import 'dart:convert';
import 'dart:io';
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;
import 'dart:ui' as ui;
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_invaite_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Widgets/button.dart';

class MyInvitation extends StatefulWidget {
  const MyInvitation({Key? key, }) : super(key: key);

  @override
  State<MyInvitation> createState() => _MyInvitationState();
}

class _MyInvitationState extends State<MyInvitation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    referCode();
    //getInvatation();
  }
  String? userReferCode;
  referCode() async {
    userReferCode = await SharedPre.getStringValue('userReferCode');
    setState(() {
      getInvatation();
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
            ),),
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text("My Invitation",style: TextStyle(fontSize: 17),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius:   BorderRadius.only(
                bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
              gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: <Color>[AppColors.primary, AppColors.secondary]),
            ),
          ),
        ),
        body: SingleChildScrollView(

          child:myInvationModel == null ?Center(child: CircularProgressIndicator()):myInvationModel?.invitees?.length == 0 ?Text("No Invation List!! ") :Container(
            height: MediaQuery.of(context).size.height/1.1,
            child: ListView.builder(
              itemCount: myInvationModel?.invitees?.length ?? 0,
                itemBuilder: (context,i){
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Card(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name: "),
                                SizedBox(height: 3,),
                                Text("${myInvationModel?.invitees?[i].userName}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mobile: "),
                                SizedBox(height: 3,),
                                Text("${myInvationModel?.invitees?[i].mobile}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Referred By: "),
                                SizedBox(height: 3,),
                                Text("${myInvationModel?.invitees?[i].referredBy}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold))
                              ],
                            ),
                             ],
                           ),
                         ),
                       ),
                     );
               }),
          ),
        )
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Image.asset("assets/images/splash_logo.png",height: 150,),
        //       ),
        //       Text(
        //         'Your Invitation Code:',
        //         style: TextStyle(fontSize: 18),
        //       ),
        //       SizedBox(height: 10),
        //       Text(
        //         "invitationCode",
        //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 20),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        //         child: AppButton1(
        //           onTap: (){
        //             share();
        //           },
        //           title: "Invitation Code",
        //         ),
        //       ),
        //
        //     ],
        //   ),
        // ),
    );

  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Invite Friend',
        text: 'Invite Friend',
        linkUrl: 'https://www.youtube.com/watch?v=jqxz7QvdWk8&list=PLjVLYmrlmjGfGLShoW0vVX_tcyT8u1Y3E',
        chooserTitle: 'Invite Friend'
    );
  }
  GetInvaiteModel? myInvationModel;
  getInvatation() async {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=cefaa9477065503c4ca2ed67af58f3c87c6bfab4'
    };
    var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/lottery/Apicontroller/apiGetInvitees'));
    request.body = json.encode({
      "referred_by":userReferCode
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetInvaiteModel.fromJson(json.decode(result));
      setState(() {
        myInvationModel = finalResult;
      });
      Fluttertoast.showToast(msg: "${finalResult.msg}");

    }
    else {
      print(response.reasonPhrase);
    }

  }

  // Future<void> getInvatation() async {
  //   var param = {
  //     "referred_by":"2675db01c965"
  //   };
  //   print('_____getData_____${param}_________');
  //   apiBaseHelper.postAPICall(getInviteeAPI,param).then((getData) {
  //     print('____getData______${getData}_________');
  //     String msg = getData['msg'];
  //     setState(() {
  //       myInvationModel = GetInvaiteModel.fromJson(getData);
  //     });
  //
  //     Fluttertoast.showToast(msg: msg);
  //     //isLoading.value = false;
  //   });
  // }


}
class InvitationCodeGenerator {
  static String generateInvitationCode() {
    // Using the uuid package to generate a unique identifier
    final uuid = Uuid();
    return uuid.v4().substring(0, 8); // You can adjust the length as needed
  }



}
