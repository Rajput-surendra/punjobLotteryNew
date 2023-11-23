import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/lottery_list_model.dart';
import '../../Widgets/button.dart';

class WithdrawalScreen extends StatefulWidget {
  WithdrawalScreen({Key? key, this.isFrom,this.gId}) : super(key: key);
  final bool? isFrom;
  String? gId;

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {

  @override
  void initState() {
    super.initState();
    balanceUser();
  }
  String? userBalance;
  balanceUser() async {
    userBalance = await SharedPre.getStringValue('balanceUser');
    setState(() {

    });
  }
  String selectedOption = "UPI";
  TextEditingController upiController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          backgroundColor: AppColors.whit,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius:  BorderRadius.only(
                bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
              ),),
            toolbarHeight: 60,
            centerTitle: true,
            title: const Text("Withdrawal",style: TextStyle(fontSize: 17),),
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  showContent(),
                 Padding(
              padding: const EdgeInsets.all(16.0),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Select Payment Method:',
                    style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: AppColors.fntClr),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio(
                          value: 'UPI',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                            });
                          },
                        ),
                        const Text('UPI'),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Radio(
                          value: 'Bank Details',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                            });
                          },
                        ),
                        const Text('Bank Details'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                if (selectedOption == 'UPI')
                  Column(
                    children: [
                      TextFormField(
                        controller: upiController,
                        decoration: const InputDecoration(hintText: 'Enter UPI ID', border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter UPI ID';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Amount'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),

                if (selectedOption == 'Bank Details')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Account Holder Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter account holder name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: accountNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                            hintText: 'Enter Account Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter account number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: bankNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Bank Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter bank name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: ifscController,
                        decoration: const InputDecoration(hintText: 'Enter IFSC Code',
                          border: OutlineInputBorder(),),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter IFSC Code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Amount'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                      ),

                      // Add more TextFormField widgets for other bank details here
                    ],
                  ),
                 const SizedBox(height: 20.0),
                  AppButton1(
                 title: 'Withdrawal',
                 onTap: (){
                   if(_formKey.currentState!.validate()){
                     if (selectedOption == 'UPI') {
                       String upiID = upiController.text;
                       // Perform actions with UPI ID
                     } else if (selectedOption == 'Bank Details') {
                       String accountNumber = accountNumberController.text;
                       String ifscCode = ifscController.text;
                       String name = nameController.text;
                       // Perform actions with bank details
                     }
                   }else{
                     Fluttertoast.showToast(msg: "All field are required");
                   }

                 },
               )
              ],
        ),
      ),

                ],
              ),
            ),
          )

      ),
    ) ;
  }


  LotteryListModel? lotteryDetailsModel;

//   String ?userId;
//   getLottery() async {
//     userId = await SharedPre.getStringValue('userId');
//     var headers = {
//       'Content-Type': 'application/json',
//       'Cookie': 'ci_session=18afbdd33b04ace40a80944d83e9e23e3ab91c3e'
//     };
//     var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/lottery/Apicontroller/getLottery'));
//     request.body = json.encode({
//       "game_id": widget.gId,
//       "user_id": userId
//     });
//     print('_____request.body_____${request.body}_________');
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result = await response.stream.bytesToString();
//       var finalResult  =  LotteryListModel.fromJson(json.decode(result));
//       Fluttertoast.showToast(msg: "${finalResult.msg}");
//       setState(() {
//         lotteryDetailsModel = finalResult;
//
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }
  StateSetter? dialogState;
  TextEditingController  amtC = TextEditingController();
  TextEditingController  msgC = TextEditingController();
  ScrollController controller = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  showContent() {
    return SingleChildScrollView(
      controller: controller,
      child:   Column(
          mainAxisSize: MainAxisSize.min, children: [
           Padding(
          padding: EdgeInsets.only(top: 5.0,left:5 ,right: 5),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.primary,
                      ),
                      Text(
                        " " + 'Current Balnes',
                        style: TextStyle(color: AppColors.fntClr,
                            fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ],
                  ),
                  userBalance == null ? Text("No Balance") :Text("₹${userBalance}" ,style: TextStyle(color: AppColors.fntClr,fontSize: 15),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),

      ]),
    );
  }
  _showDialog() async {
    bool payWarn = false;
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          dialogState = setStater;
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                    child: Text( "Add Money",
                      style: TextStyle(color: AppColors.fntClr),
                    ),
                  ),
                  // Divider(color: Theme.of(context).colorScheme.lightBlack),
                  Form(
                    key: _formKey,
                    child: Flexible(
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      style: const TextStyle(
                                        color: AppColors.fntClr,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Amount',
                                        hintStyle: TextStyle(color: AppColors.primary,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      controller: amtC,
                                    )
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                    child: TextFormField(
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      style: const TextStyle(
                                        color: AppColors.activeBorder,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "Message",
                                        hintStyle: TextStyle(color: AppColors.primary,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      controller: msgC,
                                    )),
                                //Divider(),
                                // Padding(
                                //   padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                                //   child: Text(
                                //     "Select Payment Method",
                                //     style: Theme.of(context).textTheme.subtitle2,
                                //   ),
                                // ),
                                const Divider(),

                              ])),
                    ),
                  )
                ]),
            actions: <Widget>[
              TextButton(
                  child: Text(
                    'Cancel',
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: AppColors.fntClr,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text(
                    'Send',
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: AppColors.fntClr,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    //openCheckout(amtC.text);
                  })
            ],
          );
        }));
  }
  dialogAnimate(BuildContext context, Widget dialge) {
    return showGeneralDialog(
        barrierColor: AppColors.fntClr,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: dialge),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // pageBuilder: null
        pageBuilder: (context, animation1, animation2) {
          return Container();
        } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
    );
  }


}
