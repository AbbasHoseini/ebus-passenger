import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/core/viewmodels/ProfileViewModel.dart';
import 'package:ebus/helpers/Constants.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewmodel =
        Provider.of<ProfileViewModel>(context, listen: false);

    profileViewmodel.getUserProfile(context);
// final decodedBytes = base64Decode(img64);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'پروفایل',
          style: TextStyle(
            color: colorTextPrimary,
            fontSize: fontSizeTitle + 5,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: colorTextPrimary),
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProfileViewModel>(
        builder: (_, profileViewmodelConsumer, __) => profileViewmodelConsumer
                .isLoaded
            ? SingleChildScrollView(
                key: const Key('profileScroll'),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 16, right: 8, bottom: 8),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            // borderRadius: BorderRadius.all(Radius.circular(35)),
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.black.withOpacity(0.07),
                            //       spreadRadius: 1,
                            //       blurRadius: 10)
                            // ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 24, left: 24, right: 24, bottom: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextField(
                                      key: const Key('firstName'),
                                      controller: profileViewmodelConsumer
                                          .fistNameController,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                          fontSize: fontSizeTitle + 5,
                                          color: colorTextPrimary),
                                      decoration: InputDecoration(
                                        labelText: 'نام',
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelStyle: const TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeTitle + 2,
                                            height: 1.5),
                                        icon: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  colorPrimary.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Icons.person,
                                            color: colorPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      key: const Key('lastName'),
                                      controller: profileViewmodelConsumer
                                          .lastNameController,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                          fontSize: fontSizeTitle + 5,
                                          color: colorTextPrimary),
                                      decoration: InputDecoration(
                                        labelText: 'نام خانوادگی',
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelStyle: const TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeTitle + 2,
                                            height: 1.5),
                                        icon: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  colorPrimary.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Icons.person,
                                            color: colorPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      key: const Key('nationalCode'),
                                      controller: profileViewmodelConsumer
                                          .nationalCodeController,
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                          fontSize: fontSizeTitle + 5,
                                          color: colorTextPrimary),
                                      decoration: InputDecoration(
                                        labelText: 'کد ملی',
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelStyle: const TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeTitle + 2,
                                            height: 1.5),
                                        icon: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  colorPrimary.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            MdiIcons.numeric,
                                            color: colorPrimary,
                                          ),
                                        ),
                                        errorText: profileViewmodelConsumer
                                            .nationalCodeErrorText,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      key: const Key('mobile'),
                                      controller: profileViewmodelConsumer
                                          .phoneController,
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                          fontSize: fontSizeTitle + 5,
                                          color: colorTextSub),
                                      decoration: InputDecoration(
                                        labelText: 'موبایل',
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelStyle: const TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeTitle + 2,
                                            height: 1.5),
                                        icon: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  colorPrimary.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Icons.phone,
                                            color: colorPrimary,
                                          ),
                                        ),
                                        errorText: profileViewmodelConsumer
                                            .mobileErrorText,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      key: const Key('email'),
                                      controller: profileViewmodelConsumer
                                          .emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                          fontSize: fontSizeTitle + 5,
                                          color: colorTextPrimary),
                                      decoration: InputDecoration(
                                        labelText: 'ایمیل',
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelStyle: const TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeTitle + 2,
                                            height: 1.5),
                                        icon: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  colorPrimary.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            Icons.mail,
                                            color: colorPrimary,
                                          ),
                                        ),
                                        errorText: profileViewmodelConsumer
                                            .emailErrorText,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      key: const Key('userName'),
                                      controller: profileViewmodelConsumer
                                          .userNameController,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                          fontSize: fontSizeTitle + 5,
                                          color: colorTextPrimary),
                                      decoration: InputDecoration(
                                        labelText: 'نام کاربری',
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelStyle: const TextStyle(
                                            color: colorTextSub2,
                                            fontSize: fontSizeTitle + 2,
                                            height: 1.5),
                                        icon: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  colorPrimary.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Icon(
                                            MdiIcons.at,
                                            color: colorPrimary,
                                          ),
                                        ),
                                        errorText: profileViewmodelConsumer
                                            .userNameErrorText,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              InkWell(
                                key: const Key('submitProfile'),
                                onTap: () async {
                                  await profileViewmodelConsumer
                                      .validateUpdateProfileInfo(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      // alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: const BoxDecoration(
                                          color: colorPrimary,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 1,
                                                blurRadius: 10)
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.check,
                                            color: colorTextWhite,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'ثبت تغییرات',
                                            style: TextStyle(
                                                color: colorTextWhite,
                                                fontWeight: FontWeight.bold,
                                                fontSize: fontSizeTitle),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(endIndent: 128),
                    ],
                  ),
                ),
              )
            : const Center(
                key: Key('CircularProgressIndicator'),
                child: CircularProgressIndicator(color: colorPrimary),
              ),
      ),
    );
  }
}
