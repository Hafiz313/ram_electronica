
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/consts/assets.dart';
import 'package:ram_elettronica/utils/app_constands.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/HomeView/location_view.dart';
import 'package:ram_elettronica/views/auth/forget_view.dart';
import 'package:ram_elettronica/views/base_views/base_scaffold_auth.dart';
import 'package:ram_elettronica/views/widget/text_button.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../core/viewmodels/home_viewmodel.dart';
import '../../main.dart';
import '../base_views/base_scaffold.dart';
import '../base_views/mainView.dart';
import '../widget/buttons.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';
import '../widget/txt_with_link.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String routeName = '/HomeView';
  @override
  State<HomeView> createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {

  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String elapsedTime = "00:00:00";
  bool loading =false;
  final box=GetStorage();
   int status= 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStateOfApp();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<HomeViewModel>();
    return WillPopScope(
      onWillPop: () async => true,
      child: loading?const Center(child: CircularProgressIndicator()):  BaseScaffold(
        showBackButton:true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: context.percentHeight * 2.0),
                decoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.percentHeight * 5.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subText3('${getGreetingMessage()}',color: AppColors.white),
                            subText2('${box.read(kName)}',color: AppColors.white),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.bellBgColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Image.asset(AppAssets.bell))
                      ],
                    ),
                    SizedBox(height: context.percentHeight * 3.0,),
                    subText3('${ DateFormat('dd MMMM, yyyy').format(DateTime.now())}',color: AppColors.white),
                    SizedBox(height: context.percentHeight * 3.0,),

                  ],
                ),
              ),
              timer(context),
              SizedBox(height: context.percentHeight * 2.0,),
              check(context),
              SizedBox(height: context.percentHeight * 2.0,),
              attSummary(context)



            ],
          ),
        )
      ),
    );
  }

  Widget timer(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.percentHeight * 2,horizontal: context.percentHeight * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 15.0,
            animation: true,
            percent: 0.0,
            center:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  // status ==0?"0":status ==1?"0.2":"0.7 ",
                  elapsedTime,
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: AppColors.textColor),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: AppColors.redColor,
          ),
          Image(image:const AssetImage(AppAssets.attImage),width: context.percentWidth * 50.0,)
        ],
      ),
    );
  }
  Widget check(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 2),
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(

          children: [
            SizedBox(height: context.percentHeight * 1.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 7),
              child: Row(
                children: [
                  if(status==0)
                  startBtn(context)
                   else if(status==1)
                     pauseBtn(context)
                  else if (status==2)
                    resumeBtn(context),
                  SizedBox(width: context.percentWidth * 5,),
                  Expanded(
                    child: InkWell(
                      onTap: (){

                        // checkStateOfApp();
                        // _stopwatch.stop();
                        // _timer.cancel();

                        context.read<HomeViewModel>().checkout(callBack: (isSuccess) {
                          if (isSuccess) {
                            setState(() {
                              status=0;
                              _stopwatch.stop();
                              _timer.cancel();
                            });

                          }
                        });
                      },
                      child: Container(
                        padding:  EdgeInsets.symmetric(horizontal: 20,vertical: context.percentHeight * 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.textColor)

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(' ${Lang.end} ',style: TextStyle(color: AppColors.textColor,fontSize: 18),),
                            SizedBox(width: context.percentWidth * 3.0,),
                            Image.asset(AppAssets.endIcon)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: context.percentHeight * 1.0,),
            Row(
              children: [
                Expanded(child:
                Column(children: [
                  Image.asset(AppAssets.checkInIcon),
                  if(context.read<HomeViewModel>().response.currentWorkingHours!.isNotEmpty)
                  subText2(context.read<HomeViewModel>().response.currentWorkingHours![0].checkInTime??"-- : --"),
                  subText2(Lang.checkIn),

                ],)),
                Expanded(child:
                Column(children: [
                  Image.asset(AppAssets.checkOutIcon),
                  if(context.read<HomeViewModel>().response.currentWorkingHours!.isNotEmpty)
                  subText2(context.read<HomeViewModel>().response.currentWorkingHours![0].checkOutTime??"-- : --"),
                  subText2(Lang.checkOut),

                ],)),
                if(status ==2)
                Expanded(child:
                Column(children: [
                  Image.asset(AppAssets.breakIcon),
                  subText2(context.read<HomeViewModel>().response.currentWorkingHours![0].breakStartTime??"-- : --"),
                  subText2(Lang.breakTime),

                ],)),
              ],
            ),
            SizedBox(height: context.percentHeight * 2.0,),

        ],),
      ),
    );
  }
  String getGreetingMessage() {
    DateTime now = DateTime.now();
    if (now.hour >= 5 && now.hour < 12) {
      return 'Good Morning!';
    } else if (now.hour >= 12 && now.hour < 18) {
      return 'Good Afternoon!';
    } else if (now.hour >= 18 && now.hour < 22) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }
  Widget attSummary(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 3,),
      child: Material(
        elevation: 10,
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 3,vertical: context.percentHeight * 2),
          child: Column(

            children: [
              SizedBox(height: context.percentHeight * 1.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  subText3('${Lang.attendance} ${Lang.summary}',color: AppColors.blackColor),
                  Row(
                    children: [
                      subText4('1 Aug - 31 Aug'),
                      SizedBox(width: context.percentWidth * 1.0,),
                      const Icon(FontAwesomeIcons.chevronDown,color: AppColors.textColor,size: 15,)
                    ],
                  ),

                ],
              ),
              SizedBox(height: context.percentHeight * 2.0,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration:  BoxDecoration(
                          color:AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          subText2('12',color: AppColors.blackColor),
                          subText2(Lang.present),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: context.percentWidth * 2.5,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration:  BoxDecoration(
                          color:AppColors.lightRed,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          subText2('03',color: AppColors.blackColor),
                          subText2(Lang.absent),
                        ],
                      ),
                    ),
                  ),


                ],
              )



            ],),
        ),
      ),
    );
  }
  Widget startBtn(BuildContext context){
    return  Expanded(
      child: InkWell(
        onTap: (){



          context.read<HomeViewModel>().checkIn(callBack: (isSuccess) {
            if (isSuccess) {
              checkStateOfApp();
            }
          });
          navigate.currentState?.pushNamed(LocationView.routeName);
        },
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 20,vertical: context.percentHeight * 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.redColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Lang.star,style: TextStyle(color: AppColors.white,fontSize: 18),),
              SizedBox(width: context.percentWidth * 3.0,),
              Image.asset(AppAssets.startIcon)
            ],
          ),
        ),
      ),
    );
  }
  Widget pauseBtn(BuildContext context){
    return  Expanded(
      child: InkWell(
        onTap: (){

          context.read<HomeViewModel>().breakStart(callBack: (isSuccess) {
            if (isSuccess) {
              checkStateOfApp();
            }
          });


        },
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 20,vertical: context.percentHeight * 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.redColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Lang.pause,style: TextStyle(color: AppColors.white,fontSize: 18),),
              SizedBox(width: context.percentWidth * 3.0,),
              Image.asset(AppAssets.pauseIcon)
            ],
          ),
        ),
      ),
    );
  }
  Widget resumeBtn(BuildContext context){
    return  Expanded(
      child: InkWell(
        onTap: (){
          context.read<HomeViewModel>().breakEnd(callBack: (isSuccess) {
            if (isSuccess) {
              checkStateOfApp();

            }
          });
        },
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 20,vertical: context.percentHeight * 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.redColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Lang.resume,style: TextStyle(color: AppColors.white,fontSize: 18),),
              SizedBox(width: context.percentWidth * 3.0,),
              Image.asset(AppAssets.pauseIcon)
            ],
          ),
        ),
      ),
    );
  }
  void startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime = formatElapsedTime( _stopwatch.elapsed);
      });
    });
  }
  void stopTimer() {
    _stopwatch.stop();
    _timer.cancel();
  }
  String formatElapsedTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> checkStateOfApp() async {
   final read= context.read<HomeViewModel>();

   // setState(() {
   //   loading =true;
   // });
 await  read.getCurrentHours(callBack: (isSuccess) {

     debugPrint("===token: ${GetStorage().read(kToken)}=======");
     if(read.response.currentWorkingHours!.isEmpty){
       debugPrint("====1111=ffffffff: ${status}=======");
       setState(() {
         _stopwatch.stop();
         _timer.cancel();
         elapsedTime = "00:00:00";
         status =0;
       });
     }
     else if(read.response.currentWorkingHours![0].statusState==0){
       debugPrint("====222=ffffffff: ${status}=======");
       setState(() {
         status =1;
       });
      calculateTime();
     }
     else if(read.response.currentWorkingHours![0].statusState==1){
       debugPrint("====333=ffffffff: ${status}=======");
       calculateTime();
       setState(() {
         _stopwatch.stop();
         _timer.cancel();
         status =2;
       });
     }
     else if(read.response.currentWorkingHours![0].statusState==2){
       debugPrint("====333=ffffffff: ${status}=======");
       calculateTime();
       setState(() {
         status =1;
       });
     }
    });
   setState(() {
     loading =false;
   });
  }

  void calculateTime() {
    String checkInString = "${context.read<HomeViewModel>().response.currentWorkingHours![0].checkInTime}";
    List<String> timeParts = checkInString.split(":");
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2]);
    DateTime givenTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes, seconds);
    debugPrint("=====givenTime: ${givenTime}=======");
    String currentTimeApi= "${context.read<HomeViewModel>().response.currentTime}";
    List<String> currentTimeParts = currentTimeApi.split(":");
    int currentHours = int.parse(currentTimeParts[0]);
    int currentMinutes = int.parse(currentTimeParts[1]);
    int currentSeconds = int.parse(currentTimeParts[2]);
    DateTime currentTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, currentHours, currentMinutes, currentSeconds);
    debugPrint("=====currentTime: ${currentTime}=======");
    Duration difference = currentTime.difference(givenTime);
    if (difference.isNegative) {
      difference = givenTime.difference(currentTime);
      print('Time difference: ${difference.inSeconds} seconds from now');
    } else {
      print('Time difference: ${difference.inSeconds} seconds ago');
    }
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        Duration adjustedElapsedTime = _stopwatch.elapsed + Duration(seconds: difference.inSeconds);
        elapsedTime = formatElapsedTime(adjustedElapsedTime);
      });
    });
    setState(() {
      loading =false;
    });
  }
}
