import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/custom_bottomsheet.dart';
import '../../../widgets/components/date_time_widget.dart';
import '../../../widgets/components/offers_grid_container.dart';
import '../../subscription/widgets/offer_card.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColor.c142293,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Text(
                      "Offers For You",
                      style: w700_16a(color: AppColor.white),
                    ),
                    ImageView(
                      height: 23,
                      width: 23,
                      path: Assets.iconsIcMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
          30.heightSizeBox,
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    exclusiveOffer(),
                    SizedBox(
                      height: Get.height,
                      child: GridView.builder(
                        shrinkWrap: true,
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        clipBehavior: Clip.hardEdge,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          //  mainAxisExtent: Get.height * 0.22,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return OffersGridContainer();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget exclusiveOffer() {
    return Stack(

      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColor.cC31848,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(Assets.imagesSubscriptionBg),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.cC31848.withOpacity(0.30),
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              17.heightSizeBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Explore All Exclusive Offers",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rumRaisin(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: AppColor.white,
                  ),
                ),
              ),
              13.heightSizeBox,
              GestureDetector(
                onTap: (){
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
                      return CustomBottomSheet(child: viewOfferDetailBottomSheet());
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.c142293,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColor.white.withOpacity(.50),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    "Check Now",
                    style: w600_14a(color: AppColor.white),
                  ),
                ),
              ),
              24.heightSizeBox,
            ],
          ),
        ),

        Positioned(

          bottom: 0,
          left: 0,
          child: ImageView(
            height: 68,
            width: 100,
            path: Assets.imagesCar,
          ),
        ),
        Positioned(
          bottom: 15,
          right: 0,
          child: ImageView(
            height: 71,
            width: 87,
            path: Assets.imagesJackpot,
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            21.heightSizeBox,
            Text(
              "See All Exclusive Offers.",
              style: w700_16a(color: AppColor.c2C2A2A),
            ),

            17.heightSizeBox,
           OfferCardWidget(),
            Container(
              width: 158,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                //color: AppColor.c5C6B72.withOpacity(0.3),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColor.c5C6B72.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Text(
                    "Sort by Expiry",
                    style: w400_12p(color: AppColor.c2C2A2A),
                  ),
                  Spacer(),
                  ImageView(
                    path: Assets.iconsIcDropDown,
                    height: 5,
                    width: 9,
                    color: AppColor.c2C2A2A,
                  ),
                  //Icon(Icons.arrow_drop_down, size: 20),
                ],
              ),
            ),
            20.heightSizeBox,
            SizedBox(
              height: Get.height,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.hardEdge,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: Get.height * 0.22,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: (){
                   /*     showModalBottomSheet(
                          context: Get.context!,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return CustomBottomSheet(child: viewOfferDetail());
                          },
                        );*/
                      },


                      child: OffersGridContainer());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget  viewOfferDetailBottomSheet(){
    return Column(
      children: [
        13.heightSizeBox,
     Container(
     margin: EdgeInsets.only(left: 16,right: 16),
       child: Stack(
         children: [
           ClipRRect(
             borderRadius: BorderRadius.circular(15),
             child: ImageView(
               path: Assets.imagesImOffer,
             ),
           ),
           Positioned(
             top: 35,
             left: 14,

             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 DateTimeWidget(title: "0:3 HRS - 34 MINS",textColor: AppColor.c000000,
                   color:AppColor.white.withOpacity(0.5),),
                 13.heightSizeBox,
                 Text("Special Offers\nFREE Accessories",
                   textAlign: TextAlign.center,
                   style: GoogleFonts.rumRaisin(
                     fontWeight: FontWeight.w400,
                     fontSize: 24,
                     color: AppColor.white,
                   ),
                 ),
                 /* Text("FREE Accessories",
                       textAlign: TextAlign.center,
                       style: GoogleFonts.rumRaisin(
                         fontWeight: FontWeight.w400,
                         fontSize: 24,
                         color: AppColor.white,
                       ),
                     ),*/
               ],
             ),
           ),
           Positioned(
             right: 16,
             top: 17,

             child: Container(
               padding:  EdgeInsets.only(top: 0),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(2),
                 child: ImageView(
                   path: Assets.imagesDemo,
                   height: 40,
                   width: 40,
                 ),
               ),
             ),
           )

         ],
       ),
     ),
        servicesContainer()
      ],
    );
  }
  Widget servicesContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.c142293.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(15),
            child: ImageView(
              path: Assets.imagesDemoProfile,
              fit: BoxFit.fill,

              width: 70,
            ),
          ),
          15.widthSizeBox,
          Expanded(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Elite car wash service",
                      style: w600_14a(color: AppColor.c2C2A2A),
                    ),
                    Text("09-May-2024", style: w400_12a(color: AppColor.c455A64)),
                    13.heightSizeBox,

                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    ImageView(
                        path: Assets.iconsIcPlaceMarker, height: 18, width: 18),

                    Text(
                      "2847 Poling Farm Road",
                      style: w400_10p(color: AppColor.c455A64),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ImageView(path: Assets.iconsIcStar, height: 14, width: 14),
                Text("4.5", style: w400_10a(color: AppColor.c455A64)),
                Text("Buy 1 Get 1 Free",
                  style: w500_10a(color: AppColor.cC31848),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
