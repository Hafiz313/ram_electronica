
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/widgets.dart'; // Ensure you import the necessary packages
import 'package:provider/provider.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/auth/login_view.dart';
import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../main.dart';
import '../base_views/mainView.dart';
import '../base_views/base_scaffold.dart';
import '../widget/text_button.dart';
import '../widget/buttons.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';
import '../widget/txt_with_link.dart';

class IntroView extends StatefulWidget {
  IntroView({Key? key}) : super(key: key);

  static const String routeName = '/introView';

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final _formKey = GlobalKey<FormState>();

  final userNameTxtField = TextEditingController();

  final passwordTxtField = TextEditingController();

  final List<String> imageSliders =['1','2','3'];

  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return WillPopScope(
      onWillPop: () async => false,
      child: BaseScaffold(
        showAppBar: false,
        body: CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height ,
            viewportFraction: 1,
            enlargeCenterPage: false,
            autoPlay: false,
              onPageChanged: (index, reason) {setState(() {_current = index;});}
          ),
          items: [
            slide1(context),
            slide2(context),
            slide3(context),

          ]
        ),
      ),
    );
  }

  Widget slide1(BuildContext context){
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(top: context.percentHeight * 3.0),
                child: Image.asset(AppAssets.introScreen1,height:context.percentHeight * 60.0 ,))),
        Container(
          margin: EdgeInsets.only(top:  context.percentHeight * 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.percentWidth * 10.0,
              ),
              SizedBox(
                  width: context.percentWidth * 30.0,
                  child: Image.asset(AppAssets.logo)),
              AppTextButton(
                backgroundColor: AppColors.textColor,
                onPressed: (){
                  navigate.currentState?.pushReplacementNamed(LoginView.routeName);
                },
                textStyle: const TextStyle(color: AppColors.textColor),
                title: Lang.skip,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: SizedBox(
              height: context.percentHeight * 40.0,
              width: double.infinity,

              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: context.percentHeight * 2.0,),
                  dots(),
                  SizedBox(height: context.percentHeight * 2.0,),
                  subText5(
                      Lang.clockInWithConfidence,
                      color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20

                  ),
                  SizedBox(height: context.percentHeight * 2.0,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 4),
                      child: subText3(Lang.clockInWithText)),
                  SizedBox(height: context.percentHeight * 6.0,),
                  AppElevatedButton(onPressed: (){
                    if (_controller != null) {
                      _controller.animateToPage(1);
                    }
                  }, title: Lang.next)

                ],
              ),
            ),

          ),
        )
      ],
    );
  }
  Widget slide2(BuildContext context){
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(top: context.percentHeight * 3.0),
                child: Image.asset(AppAssets.introScreen2,height:context.percentHeight * 60.0 ,))),
        Container(
          margin: EdgeInsets.only(top:  context.percentHeight * 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.percentWidth * 10.0,
              ),
              SizedBox(
                  width: context.percentWidth * 30.0,
                  child: Image.asset(AppAssets.logo)),
              AppTextButton(
                backgroundColor: AppColors.textColor,
                onPressed: (){
                  navigate.currentState?.pushReplacementNamed(LoginView.routeName);
                },
                textStyle: const TextStyle(color: AppColors.textColor),
                title: Lang.skip,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: SizedBox(
              height: context.percentHeight * 40.0,
              width: double.infinity,

              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: context.percentHeight * 2.0,),
                  dots(),
                  SizedBox(height: context.percentHeight * 2.0,),
                  subText5(
                      Lang.breaksMadeEasy,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20

                  ),
                  SizedBox(height: context.percentHeight * 2.0,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 4),
                      child: subText3(Lang.clockInWithText)),
                  SizedBox(height: context.percentHeight * 6.0,),
                  AppElevatedButton(onPressed: (){
                    if (_controller != null) {
                      _controller.animateToPage(2);
                    }
                  }, title: Lang.next)

                ],
              ),
            ),

          ),
        )
      ],
    );
  }
  Widget slide3(BuildContext context){
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(top: context.percentHeight * 3.0),
                child: Image.asset(AppAssets.introScreen3,height:context.percentHeight * 60.0 ,))),
        Container(
          margin: EdgeInsets.only(top:  context.percentHeight * 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                  width: context.percentWidth * 30.0,
                  child: Image.asset(AppAssets.logo)),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: SizedBox(
              height: context.percentHeight * 40.0,
              width: double.infinity,

              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: context.percentHeight * 2.0,),
                  dots(),
                  SizedBox(height: context.percentHeight * 2.0,),
                  subText5(
                      Lang.gpsBasedEntries,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20

                  ),
                  SizedBox(height: context.percentHeight * 2.0,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 4),
                      child: subText3(Lang.clockInWithText)),
                  SizedBox(height: context.percentHeight * 6.0,),
                  AppElevatedButton(onPressed: (){
                    navigate.currentState?.pushReplacementNamed(LoginView.routeName);

                  }, title: Lang.getStarted)

                ],
              ),
            ),

          ),
        )
      ],
    );
  }

  Widget dots(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: imageSliders.asMap().entries.map((entry) {
        return Container(
          width:_current == entry.key? 43.0: 13.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),

              color: (Theme.of(context).brightness == Brightness.dark
                  ? AppColors.white
                  : _current == entry.key?AppColors.redColor:AppColors.textColor)),
        );
      }).toList(),
    );
  }

}

