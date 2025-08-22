import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/app_snack_bar.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import 'package:image_picker/image_picker.dart';


import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/data_formet.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../../../widgets/components/image_view.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../controller/drawer_profile_controller.dart';

class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({super.key});

  DashboardController dashboardController = Get.find();
  DrawerProfileController drawerProfileController = Get.find();

  WashStatusController washStatusController = Get.find();
  final _formKey = GlobalKey<FormState>();

  Future<void> _showImageSourceDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            StringConstant.kSelectImageSource.tr,
            style: w500_20a(color: AppColor.c2C2A2A),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text(StringConstant.kCamera.tr, style: w400_14p()),
                onTap: () async {
                  Get.back();
                  await drawerProfileController.imagePicker(
                    source: ImageSource.camera,
                  );
                  if (drawerProfileController.imageFile.value != null) {
                    await drawerProfileController.uploadProfileImage();
                    await Future.delayed(Duration(seconds: 1));
                    await washStatusController.getCustomerDataById(
                      washStatusController
                              .getCustomerData
                              .value
                              ?.data
                              ?.customerDetails
                              ?.id ??
                          0,
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text(StringConstant.kGallery.tr, style: w400_14p()),
                onTap: () async {
                  Get.back();
                  await drawerProfileController.imagePicker(
                    source: ImageSource.gallery,
                  );
                  if (drawerProfileController.imageFile.value != null) {
                    await drawerProfileController.uploadProfileImage();
                    await Future.delayed(Duration(seconds: 1));
                    await washStatusController.getCustomerDataById(
                      washStatusController
                              .getCustomerData
                              .value
                              ?.data
                              ?.customerDetails
                              ?.id ??
                          0,
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = washStatusController.getCustomerData.value?.data?.customerDetails;
    final userDataSub = washStatusController.getCustomerData.value?.data?.subscriptionDetails;
    drawerProfileController.nameController.text = userData?.fullName ?? '';
    drawerProfileController.emailController.text = userData?.email ?? '';
    drawerProfileController.phoneController.text = userData?.mobileNumber ?? '';
    drawerProfileController.zoneController.text = userData?.zone ?? '';
    drawerProfileController.streetController.text = userData?.street ?? '';
    drawerProfileController.buildingController.text = userData?.building ?? '';
    drawerProfileController.unitController.text = userData?.unit ?? '';
    drawerProfileController.carNumberController.text =
        userData?.carNumber ?? '';

    return AppHomeBg(
      headingText: StringConstant.kMyAccount.tr,
      iconRight: SizedBox(),
      child: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  15.heightSizeBox,
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Obx(() {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: drawerProfileController.imageFile.value != null
                                    ? ClipOval(
                                  child: Image.file(
                                    drawerProfileController.imageFile.value!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : (userData?.profilePicUrl != null &&
                                    userData!.profilePicUrl!.trim().isNotEmpty &&
                                    Uri.tryParse(userData.profilePicUrl!)?.hasAbsolutePath == true)
                                    ? ClipOval(
                                  child: Image.network(
                                    userData.profilePicUrl!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        Assets.imagesDemoProfile,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                )

                                    : ClipOval(
                                  child: Image.asset(
                                    Assets.imagesDemoProfile,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            // Loader over image
                            if (drawerProfileController.isUploadingProfileImage.value)
                              Container(
                                width: 112,
                                height: 112,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(

                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),

                      // Edit Icon
                      GestureDetector(
                        onTap: () async {
                          await _showImageSourceDialog(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColor.cC41949,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColor.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.cC41949.withOpacity(0.25),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ImageView(
                            path: Assets.iconsIcEdit,
                            height: 17,
                            width: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  11.heightSizeBox,

                  Obx(
                     () {
                      return Text(
                        washStatusController.getCustomerData.value?.data?.customerDetails?.fullName ?? '',
                        style: w700_16a(color: AppColor.c2C2A2A),textAlign: TextAlign.center,
                      );
                    }
                  ),
                  4.heightSizeBox,



                  Obx(() {
                    final userDataSub = washStatusController.getCustomerData.value?.data?.subscriptionDetails;
                    return (userDataSub != null &&
                        userDataSub.subscriptionName != null &&
                        userDataSub.subscriptionName!.isNotEmpty &&
                        userDataSub.endDate != null)
                        ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: StringConstant.kYour.tr,
                            style: w400_12p(color: AppColor.c455A64),
                          ),
                          TextSpan(
                            text: userDataSub.subscriptionName!,
                            style: w600_14p(color: AppColor.cC31848),
                          ),
                          TextSpan(
                            text: StringConstant.kPackExpiringIn.tr,
                            style: w400_12p(color: AppColor.c455A64),
                          ),
                          TextSpan(
                            text: formatDate(userDataSub.endDate),
                            style: w600_12p(color: AppColor.c455A64),
                          ),
                        ],
                      ),
                    )
                        : SizedBox();
                  }),
                31.heightSizeBox,
                  HiWashTextField(
                  /*  fillColor: AppColor.c6B6B6B.withOpacity(0.2),*/
                    readOnly: true,
                    controller: drawerProfileController.nameController,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z0-9 .,@#&/\\':()+=-]"),
                      ),
                    ],
                    hintText: StringConstant.kName.tr,
                    labelText: StringConstant.kName.tr,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return StringConstant.kPleaseEnterYourName.tr;
                      }
                      return null;
                    },
                  ),
                  20.heightSizeBox,
                  HiWashTextField(/*
                    fillColor: AppColor.c6B6B6B.withOpacity(0.2),
                    readOnly: true,*/
                    controller: drawerProfileController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: StringConstant.kEmail.tr,
                    labelText: StringConstant.kEmail.tr,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return StringConstant.kPleaseEnterYourEmail.tr;
                      }
                      return null;
                    },
                  ),
                  20.heightSizeBox,
                  HiWashTextField(
                   // fillColor: AppColor.c6B6B6B.withOpacity(0.2),
                    readOnly: true,
                    keyboardType: TextInputType.phone,
                    controller: drawerProfileController.phoneController,
                    hintText: StringConstant.kPhone.tr,
                    labelText: StringConstant.kPhone.tr,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return StringConstant.kPleaseEnterYourPhone.tr;
                      }
                      return null;
                    },
                  ),
                  20.heightSizeBox,
                  HiWashTextField(
                    controller: drawerProfileController.zoneController,
                    hintText: StringConstant.kZone.tr,
                    labelText: StringConstant.kZone.tr,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z0-9 .,@#&/\\':()+=-]"),
                      ),
                    ],
                  ),
                  20.heightSizeBox,
                  HiWashTextField(
                    controller: drawerProfileController.streetController,
                    hintText: StringConstant.kStreet.tr,
                    labelText: StringConstant.kStreet.tr,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z0-9 .,@#&/\\':()+=-]"),
                      ),
                    ],
                  ),
                  20.heightSizeBox,
                  HiWashTextField(
                    controller: drawerProfileController.buildingController,
                    hintText: StringConstant.kBuilding.tr,
                    labelText: StringConstant.kBuilding.tr,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z0-9 .,@#&/\\':()+=-]"),
                      ),
                    ],
                  ),
                  20.heightSizeBox,
                  HiWashTextField(
                    controller: drawerProfileController.unitController,
                    hintText: StringConstant.kUnit.tr,
                    labelText: StringConstant.kUnit.tr,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z0-9 .,@#&/\\':()+=-]"),
                      ),
                    ],
                  ),
                  20.heightSizeBox,
                  HiWashTextField(
                    controller: drawerProfileController.carNumberController,
                    hintText: StringConstant.kCarNumber.tr,
                    labelText:StringConstant.kCarNumber.tr,
                  ),
                  60.heightSizeBox,
                  Obx(() {
                    return HiWashButton(
                      isLoading: drawerProfileController.isLoading.value,
                      text:StringConstant.kSave.tr,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          drawerProfileController.carNumberController.text = drawerProfileController.carNumberController.text;

                          await drawerProfileController.uploadProfile(
                            drawerProfileController.nameController.text,
                            drawerProfileController.emailController.text,
                            drawerProfileController.phoneController.text,
                            drawerProfileController.zoneController.text,
                            drawerProfileController.streetController.text,
                            drawerProfileController.buildingController.text,
                            drawerProfileController.unitController.text,
                           // userData!.profilePicUrl ?? "",
                            drawerProfileController.carNumberController.text,
                          );

                          washStatusController.getCustomerDataById(
                            washStatusController
                                    .getCustomerData
                                    .value
                                    ?.data
                                    ?.customerDetails
                                    ?.id ??
                                0,
                          );
                        } else {
                          appSnackBar(
                            message: StringConstant.kSomethingWentWrong.tr
                          );

                        }
                      },
                    );
                  }),
                  30.heightSizeBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
