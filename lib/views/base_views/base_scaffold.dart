import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../utils/preferences.dart';
import '../widget/text.dart';

class BaseScaffold extends StatefulWidget {
  final Widget? body;
  final bool showBlurBackground;
  final String title;
  final String subTitle;
  final List<Widget>? actionWidgets;
  final bool showAppBar;
  final bool showBackButton;
  final bool plainBackground;

  const BaseScaffold(
      {Key? key,
      this.showAppBar = true,
      this.title = '',
      this.subTitle = '',
      this.showBackButton = true,
      required this.body,
      this.actionWidgets,
      this.plainBackground = true,
      this.showBlurBackground = false,})
      : super(key: key);

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return
        SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primary,
              resizeToAvoidBottomInset: true,
              body: widget.body!),
        );
  }
}
