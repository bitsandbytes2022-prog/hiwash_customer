/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/network_manager/ticket_service.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import 'package:image_picker/image_picker.dart';

import 'second_drawer_controller/second_drawer_controller.dart';

class HelpDeskTicketScreen extends StatelessWidget {
  HelpDeskTicketScreen({super.key});

  SecondDrawerController secondDrawerController = Get.put(
    SecondDrawerController(),
  );

  WashStatusController washStatusController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
      headingText: "Help Desk Ticket",

      iconRight: SizedBox(),
      child: Container(
        padding: EdgeInsets.all(15),

        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.c142293.withOpacity(0.15),
              blurRadius: 15,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.heightSizeBox,
            HiWashTextField(
              hintText: "",
              labelText: "Issue",
              fillColor: AppColor.white,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(18),
                child: ImageView(
                  path: Assets.iconsIcDropDown,
                  height: 10,
                  width: 8,
                ),
              ),
            ),
            20.heightSizeBox,
            HiWashTextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[a-zA-Z0-9 .,@#&/\\':()+=-]"),
                ),
              ],
              hintText: "Enter short summary of your issue",
              labelText: "Subject",
              fillColor: AppColor.white,
              controller: secondDrawerController.subjectController,
            ),
            20.heightSizeBox,
            HiWashTextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[a-zA-Z0-9 .,@#&/\\':()+=-]"),
                ),
              ],
              hintText: "Please describe the issue in detail.",
              labelText: "Description",
              fillColor: AppColor.white,
              controller: secondDrawerController.descriptionController,
            ),
            20.heightSizeBox,
            Obx(() {
              final image = secondDrawerController.selectedImage.value;
              return GestureDetector(
                onTap: () => _showImagePickerOptions(context),
                child: Container(
                  height: 144,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.c142293.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      image != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(image, fit: BoxFit.cover),
                          )
                          : Center(
                            child: ImageView(
                              path: Assets.imagesCameraImage,
                              height: 50,
                              width: 50,
                            ),
                          ),
                ),
              );
            }),

            */
/* ImageView(
              path: Assets.imagesCameraImage,
              height: 144,
              width: Get.width,
             // fit: BoxFit.fitWidth,
            ),*//*

            20.heightSizeBox,
            Text(
              "Preferred Contact Method",
              style: w500_12a(color: AppColor.c2C2A2A),
            ),
            20.heightSizeBox,
            Row(
              children: [
                checkboxWidget(0, "Email"),
                10.widthSizeBox,
                checkboxWidget(1, "Phone"),
                10.widthSizeBox,
                checkboxWidget(2, "In-app notification"),
              ],
            ),

            30.heightSizeBox,
            HiWashButton(
              text: "Submit Ticket",

              onTap: () async {
                final email =
                    washStatusController
                        .getCustomerData
                        .value
                        ?.data
                        ?.customerDetails
                        ?.email ??
                    '';
                final name =
                    washStatusController
                        .getCustomerData
                        .value
                        ?.data
                        ?.customerDetails
                        ?.fullName ??
                    '';
                final subject = secondDrawerController.subjectController.text;
                final description =
                    secondDrawerController.descriptionController.text;
                final image = secondDrawerController.selectedImage.value;

                final result = await TicketService().createSupportTicket(
                  userEmail: email,
                  userName: name,
                  subject: subject,
                  description: description,
                  attachments: image != null ? [image] : null,
                );

                if (result.isSuccess) {
                  Get.snackbar('Success', 'Ticket created successfully');
                  secondDrawerController.resetAll();
                } else {
                  Get.snackbar('Error', result.error ?? 'Something went wrong');
                }
              },
            ),
            20.heightSizeBox,
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  secondDrawerController.pickImage(source: ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  secondDrawerController.pickImage(source: ImageSource.gallery);
                },
              ),
              if (secondDrawerController.selectedImage.value != null)
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Remove Image"),
                  onTap: () {
                    Navigator.pop(context);
                    secondDrawerController.clearImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget checkboxWidget(int index, String label) {
    return Obx(() {
      return CustomCheckbox(
        value: secondDrawerController.isChecked[index],
        onChanged: (bool? value) {
          secondDrawerController.toggleCheckbox(index);
        },
        label: label,
      );
    });
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5),
              color: value ? AppColor.c1F9D70 : Colors.white,
            ),
            child:
                value ? Icon(Icons.check, color: Colors.white, size: 16) : null,
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: w400_11a(color: AppColor.c2C2A2A)),
      ],
    );
  }
}
*/
