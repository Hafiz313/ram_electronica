
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/consts/assets.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/auth/forget_view.dart';
import 'package:ram_elettronica/views/base_views/base_scaffold_auth.dart';
import 'package:ram_elettronica/views/widget/text_button.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../main.dart';
import '../HomeView/home_view.dart';
import '../base_views/mainView.dart';
import '../widget/buttons.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';
import '../widget/txt_with_link.dart';

class SubmitView extends StatelessWidget {
  const SubmitView({Key? key}) : super(key: key);

  static const String routeName = '/SubmitView';
  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return WillPopScope(
      onWillPop: () async => true,
      child:  BaseScaffoldAuth(
        showBackButton:false,
        isLogoShow: false,
        body: Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      navigate.currentState?.pushNamed(HomeView.routeName);
                    },
                    child: Icon(FontAwesomeIcons.solidCheckCircle,size: context.percentHeight * 15.0,color: AppColors.redColor,)),
                SizedBox(
                  height: context.percentHeight * 2.0,
                ),
                headline2('${Lang.password} ${Lang.changed}'),
                SizedBox(
                  height: context.percentHeight * 1.0,
                ),
                subText3(Lang.submittedSuccessfully)


              ],
            ),
          ),
        )
      ),
    );
  }
}
