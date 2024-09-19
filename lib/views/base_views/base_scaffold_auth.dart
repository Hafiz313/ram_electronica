import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../utils/preferences.dart';
import '../widget/text.dart';

class BaseScaffoldAuth extends StatefulWidget {
  final Widget? body;
  final bool showBackButton;
  final bool isLogoShow;


  const BaseScaffoldAuth(
      {Key? key,
      this.showBackButton = true,
        this.isLogoShow=true,
      required this.body, })
      : super(key: key);

  @override
  State<BaseScaffoldAuth> createState() => _BaseScaffoldAuthState();
}

class _BaseScaffoldAuthState extends State<BaseScaffoldAuth> {
  String name='';
  String imageUrl='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            if(widget.isLogoShow)
           Column(
             children: [
               SizedBox(
                 height: context.percentHeight * 8.0,
               ),
               Row(
                 children: [
                   if(widget.showBackButton)
                     Container(
                       margin: EdgeInsets.only(left: context.percentWidth * 4.0),
                       child: InkWell(
                           onTap: ()=> Navigator.pop(context),
                           child: Image.asset(AppAssets.backArrow)),
                     ),
                   Expanded(
                     child: Container(
                         alignment: Alignment.center,
                         child: Image.asset(AppAssets.logo,width: context.percentWidth * 35.0,)),
                   ),
                   if(widget.showBackButton)
                     Container(
                       width: context.percentWidth * 4.0,
                       margin: EdgeInsets.only(right: context.percentWidth * 4.0),
                     ),
                 ],
               ),
               SizedBox(
                 height: context.percentHeight * 5.0,
               ),
             ],
           ),
            widget.body!,
          ],
        )

    );
  }

}
