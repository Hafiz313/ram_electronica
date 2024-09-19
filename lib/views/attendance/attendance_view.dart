import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';

import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../base_views/base_scaffold.dart';
import '../widget/text.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child:  BaseScaffold(

          showBackButton:false,
          body: Column(
            children: [
              SizedBox(height: context.percentHeight * 5.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Icon(FontAwesomeIcons.arrowLeft,size: 18,),
                headline2('${Lang.attendance} ${Lang.sheet}',color: AppColors.blackColor),
                const Icon(FontAwesomeIcons.arrowLeft,color: AppColors.transparent,),
              ],),
            ),
              SizedBox(height: context.percentHeight * 3.0,),
              attSummary(context),
              SizedBox(height: context.percentHeight * 3,),
              checkInDetail(context),


            ],
          )
      ),
    );
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
                  subText3(Lang.summary,color: AppColors.blackColor),
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
                  CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 15.0,
                    animation: true,
                    percent: 0.7,
                    center:Container(),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppColors.redColor,
                    backgroundColor: AppColors.accent,


                  ),
                  SizedBox(width: context.percentWidth * 2.5,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration:  BoxDecoration(
                          color:AppColors.bgGrayColor,
                          borderRadius: BorderRadius.circular(9)
                      ),
                      child: Column(
                        children: [
                          subText3('15',color: AppColors.blackColor),
                          subText4(Lang.total),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: context.percentWidth * 2.5,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration:  BoxDecoration(
                          color:AppColors.lightRed,
                          borderRadius: BorderRadius.circular(9)
                      ),
                      child: Column(
                        children: [
                          subText3('03',color: AppColors.blackColor),
                          subText4(Lang.absent),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: context.percentWidth * 2.5,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration:  BoxDecoration(
                          color:AppColors.lightRed,
                          borderRadius: BorderRadius.circular(9)
                      ),
                      child: Column(
                        children: [
                          subText3('03',color: AppColors.blackColor),
                          subText4(Lang.absent),
                        ],
                      ),
                    ),
                  ),



                ],


              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      subText5(Lang.workedHrs,fontSize: 13),
                      subText5(' 142:10:32',fontWeight: FontWeight.normal,fontSize: 12)
                    ],
                  ),
                  Row(
                    children: [
                      presentIcon(),
                      const SizedBox(width: 10,),
                      absentIcon()
                    ],
                  ),
                ],
              ),




            ],),
        ),
      ),
    );
  }
  Widget presentIcon(){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration:  const BoxDecoration(
              color:AppColors.accent,
              shape: BoxShape.circle
          ),
          child: subText5('P',color: AppColors.white,fontSize: 13),
        ),
        const SizedBox(width: 5,),
        subText3(Lang.present)
      ],
    );
  }
  Widget absentIcon(){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration:  const BoxDecoration(
              color:AppColors.redColor,
              shape: BoxShape.circle
          ),
          child: subText5('A',color: AppColors.white,fontSize: 13),
        ),
        const SizedBox(width: 5,),
        subText3(Lang.absent)
      ],
    );
  }
  Widget checkInDetail(BuildContext context){
    return Expanded(
      child: ListView.builder(
          itemCount: 10,
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){

        return Container(
          margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 2,vertical: context.percentWidth * 2.5),
          child: Material(
            elevation: 10,
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: context.percentWidth * 3,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 2,vertical: context.percentHeight * 1),
                        decoration: BoxDecoration(
                          color: AppColors.bgGrayColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            subText5('1$index',fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.blackColor),
                            subText5('Tue',fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.blackColor),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration:  const BoxDecoration(
                            color:AppColors.accent,
                            shape: BoxShape.circle
                        ),
                        child: subText5('P',color: AppColors.white,fontSize: 13),
                      ),
                    ],),
                  ),
                  SizedBox(height: context.percentHeight * 2,),
                  checkInLocation(context),
                  SizedBox(height: context.percentHeight * 2,),
                  checkOutLocation(context),
                  SizedBox(height: context.percentHeight * 2,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: context.percentHeight * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            subText5(Lang.workedHrs,fontSize: 13,color: AppColors.blackColor),
                            subText5(' 142:10:32',fontWeight: FontWeight.normal,fontSize: 12)
                          ],
                        ),
                        Container(height: context.percentHeight * 2,width: 1,color: AppColors.textColor,),
                        Row(
                          children: [
                            subText5(Lang.breakTime,fontSize: 13,color: AppColors.blackColor),
                            subText5(' 142:10:32',fontWeight: FontWeight.normal,fontSize: 12)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.percentHeight * 2,),
                  Container(margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 4),height:0.7,width:double.infinity,color: AppColors.textColor,),
                  SizedBox(height: context.percentHeight * 2,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 4),
                    padding: EdgeInsets.symmetric(horizontal:context.percentWidth * 2,vertical:context.percentWidth * 1.5 ),
                    decoration: BoxDecoration(
                      color: AppColors.bgGrayColor,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: subText5(Lang.note,color: AppColors.blackColor,fontSize: 13),
                  ),
                  titleHeading(context, heading: Lang.jobTitle, text: 'Chief Engineer'),
                  SizedBox(height: context.percentHeight * 2,),
                  titleHeading(context, heading: Lang.taskPerformed, text: 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con'),
                  SizedBox(height: context.percentHeight * 2,),

                ],
              ),

            ),
          ),
        );
      }),
    );
  }
  Widget checkInLocation (BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 3,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2,child: Row(
            children: [
              subText5(Lang.checkIn,fontSize: 13,color: AppColors.blackColor),
              SizedBox(width: context.percentWidth * 1,),
              Image.asset(AppAssets.checkInBlackIcon),
            ],
          )),
          Expanded(flex: 5,child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subText5('10.01 AM',fontSize: 13),
                  SizedBox(height: context.percentHeight * 1),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.locationDot ,color: AppColors.redColor,size: 15,),
                      SizedBox(width: context.percentWidth * 0.5,),
                      subText5('2972 Westheimer Rd. Santa Ana, ',fontSize: 13)
                    ],
                  )

                ],
              ),

            ],
          ),)

        ],
      ),
    );
  }
  Widget checkOutLocation (BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 3,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2,child: Row(
            children: [
              subText5(Lang.checkOut,fontSize: 13,color: AppColors.blackColor),
              SizedBox(width: context.percentWidth * 1,),
              Image.asset(AppAssets.checkOutBlackIcon),
            ],
          )),
          Expanded(flex: 5,child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subText5('10.01 AM',fontSize: 13),
                  SizedBox(height: context.percentHeight * 1),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.locationDot ,color: AppColors.redColor,size: 15,),
                      SizedBox(width: context.percentWidth * 0.5,),
                      subText5('2972 Westheimer Rd. Santa Ana, ',fontSize: 13)
                    ],
                  )

                ],
              ),

            ],
          ),)

        ],
      ),
    );
  }
  Widget titleHeading(BuildContext context, {required String heading,required String text}){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2,child: subText5(heading,fontSize: 13,color: AppColors.blackColor)),
          SizedBox(width: context.percentWidth * 3,),
          Expanded(flex: 5,child: Container(
              alignment: Alignment.centerLeft,
              child: subText5(text,fontSize: 13,align: TextAlign.start))),
        ],
      ),
    );
  }

}
