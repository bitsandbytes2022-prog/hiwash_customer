import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import '../../featuers/rewads/controller.dart';
import '../../featuers/rewads/model/offer_response_model.dart';
import '../../featuers/rewads/view/widget/view_offer_detail_widget.dart'
    show OfferDetailBottomSheet;
import '../../featuers/subscription/widgets/offer_card.dart';
import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import '../../styling/app_font_poppins.dart';
import 'custom_bottomsheet.dart';
import 'image_view.dart';
import 'offers_grid_container.dart';


class BottomSheetWidget extends StatelessWidget {
  Widget? child;
  VoidCallback? onTap;
  bool isVisible;

  BottomSheetWidget({Key? key, this.child, this.isVisible = false, this.onTap})
      : super(key: key);

  final RewardController rewardController = Get.find<RewardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 1.1,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColor.cF6F7FF,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              21.heightSizeBox,
              Text(
                StringConstant.kSeeAllExclusiveOffers.tr,
                style: w700_16a(color: AppColor.c2C2A2A),
              ),

              27.heightSizeBox,
              OfferCardWidget(
                padding: EdgeInsets.symmetric(horizontal: 15),
                onTapOne: () => rewardController.applyFilter(1),
                onTapTwo: () => rewardController.applyFilter(2),
                onTapThree: () => rewardController.applyFilter(3),
              ),

              25.heightSizeBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  bool showSecondDropdown = rewardController.selectedFilterIndex.value == 1 ||
                      rewardController.selectedFilterIndex.value == 2;

                  return Row(
                    mainAxisAlignment:
                    showSecondDropdown ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          rewardController.isVisible.value =
                          !rewardController.isVisible.value;
                        },
                        child: Container(
                          width: 158,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColor.c5C6B72.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [

                              Obx(() {
                                final index = rewardController.selectedFilterIndex.value;
                                if (index <= 0 || index > rewardController.offerFilterList.length) {
                                  return SizedBox();
                                }
                                return Text(
                                  rewardController.offerFilterList[index - 1],
                                  style: w400_12p(color: AppColor.c2C2A2A),
                                );
                              }),
                              Spacer(),
                              ImageView(
                                path: Assets.iconsIcDropDown,
                                height: 5,
                                width: 9,
                                color: AppColor.c2C2A2A,
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (showSecondDropdown)
                        GestureDetector(
                          onTap: () {
                            rewardController.toggleSortOrder();
                          },
                          child: Container(
                            width: 158,
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: AppColor.c5C6B72.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Obx(() {
                                  return Text(
                                    rewardController.sortByText.value,
                                    style: w400_12p(color: AppColor.c2C2A2A),
                                  );
                                }),
                                Spacer(),
                                ImageView(
                                  path: Assets.iconsIcDropDown,
                                  height: 5,
                                  width: 9,
                                  color: AppColor.c2C2A2A,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),

              25.heightSizeBox,
              Expanded(
                child: Obx(() {
                  if (rewardController.isLoading.value) {
                    return Center(child: CircularProgressIndicator(
                      color: AppColor.blue,
                      strokeWidth: 2,
                    ));
                  }

                  if (rewardController.offerResponseModel.value == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<Offers> data =
                      rewardController.offerResponseModel.value?.data?.offers ?? [];

                  if (data.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        StringConstant.kDateIsNotFound.tr,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 16, right: 15, bottom: 60),
                    clipBehavior: Clip.hardEdge,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          if (isVisible) {

                            Get.back();
                            await rewardController.getOffersById(data[index].id!);
                            showModalBottomSheet(
                              context: Get.context!,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              builder: (BuildContext context) {

                                return CustomBottomSheet(
                                  child: OfferDetailBottomSheet(),
                                );
                              },
                            );
                          }
                        },
                        child: OffersGridContainer(
                          key: ValueKey(data[index].expiryDate),
                          offer: data[index],
                        ),
                      );
                    },
                  );
                }),
              ),


            ],
          ),

          Obx(
                () => rewardController.isVisible.value
                ? Positioned(
                  left: 10,
              top: Get.height / 2.75,
              child: Container(
                alignment: Alignment.center,
                width: 180,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  List.generate(
                    rewardController.offerFilterList.length,
                        (index) => GestureDetector(
                      onTap: () {
                        rewardController.applyFilter(index+1);
                        rewardController.selectedFilterIndex.value = index + 1;

                        rewardController.isVisible.value = false;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          rewardController.offerFilterList[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
                : Container(),
          ),

          Positioned(
            top: 5,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Get.back();
                rewardController.resetFiltersAndLoad();

              },
              child: Container(
                padding: EdgeInsets.only(right: 10, top: 6),
                child: ImageView(
                  path: Assets.iconsIcClose,
                  height: 28,
                  width: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}