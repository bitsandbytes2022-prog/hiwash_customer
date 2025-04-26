  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
  import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
  import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
  import 'package:hiwash_customer/widgets/sized_box_extension.dart';

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

    @override
    Widget build(BuildContext context) {
      final userData = dashboardController.getCustomerData.value?.data?.customerDetails;
      final userDataSub = dashboardController.getCustomerData.value?.data?.subscriptionDetails;
      drawerProfileController.nameController.text = userData?.fullName ?? '';
      drawerProfileController.emailController.text = userData?.email ?? '';
      drawerProfileController.phoneController.text = userData?.mobileNumber ?? '';

      return AppHomeBg(
        headingText: "My Account",
        iconRight: SizedBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            15.heightSizeBox,
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                  ),
                  child: Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundImage: drawerProfileController.imageFile.value != null
                        ? FileImage(drawerProfileController.imageFile.value!)
                        : AssetImage(Assets.imagesDemoProfile) as ImageProvider,
                  )),
                ),
                GestureDetector(
                  onTap: () async {
                    await drawerProfileController.imagePicker();

                    final response = await drawerProfileController.uploadProfileImage();
                    if (response != null) {
                      Get.snackbar(
                        "Success",
                        "Profile image updated successfully",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );

                      drawerProfileController.uploadProfileImage();
                    } else {
                      Get.snackbar(
                        "Error",
                        "Failed to upload image",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
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

                /*   GestureDetector(
                  onTap: (){
                    drawerProfileController.imagePicker();

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
                ),*/
              ],
            ),
            11.heightSizeBox,
            Text(
              userData?.fullName ?? '',
              style: w700_16a(color: AppColor.c2C2A2A),
            ),
            4.heightSizeBox,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Your ',
                    style: w400_12p(color: AppColor.c455A64),
                  ),
                  TextSpan(
                    text: userDataSub?.subscriptionName ?? '',
                    style: w600_14p(color: AppColor.cC31848),
                  ),
                  TextSpan(
                    text: ' pack\nexpiring in ',
                    style: w400_12p(color: AppColor.c455A64),
                  ),
                  TextSpan(
                    text: formatDate(userDataSub?.endDate),
                    style: w600_12p(color: AppColor.c455A64),
                  ),
                ],
              ),
            ),
            39.heightSizeBox,
            31.heightSizeBox,
            HiWashTextField(
              controller: drawerProfileController.nameController,

              hintText: "Name",
              labelText: "Name",
            ),
            20.heightSizeBox,
            HiWashTextField(
              controller: drawerProfileController.emailController,

              hintText: "Email",
              labelText: "Email",
            ),
            20.heightSizeBox,
            HiWashTextField(
              controller: drawerProfileController.phoneController,
              hintText: "Phone",
              labelText: "Phone",
            ),
            20.heightSizeBox,
            Column(
              children: [
                Stack(
                  children: [
                    TextFormField(
                      controller: drawerProfileController.addressController,
                      maxLines: 3,
                      style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
                      decoration: InputDecoration(
                        fillColor: AppColor.cF6F7FF,
                        hintText: "Address",
                        labelText: "Address",
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: w400_13a(color: AppColor.c455A64),
                        hintStyle: w400_14p(
                          color: AppColor.c2C2A2A.withOpacity(0.40),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.cEAE8E8.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.c5C6B72.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.c5C6B72.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.c5C6B72.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.c5C6B72.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.c5C6B72.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 9,
                      right: 8,
                      child: ImageView(
                        path: Assets.iconsMyLocation,
                        height: 18,
                        width: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            20.heightSizeBox,
            HiWashTextField(
              controller: drawerProfileController.carNumberController,

              hintText: "Car Number",
              labelText: "Car Number",
            ),

            60.heightSizeBox,
            HiWashButton(text: 'Save'),
            30.heightSizeBox,
          ],
        ),
      );
    }
  }
