import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'kHellos': 'Hello hello',
      "kDemoText":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      "kWelcomeToThe": "Welcome to the",
      "kHiWASH": "HI WASH",
      "kWeComeToYouTo": "We come to you to\nwash your car...!!",

      ///  welcome screen
      "kEcoCleanWalletGreen": "Eco Clean, Wallet Green!",
      "kExclusiveDealsWithEvery":
          "Exclusive Deals with Every Shine Free\nCoupons, BOGO Offers, Discounts &\nSpecial Perks!",
      "kGetStarted": "Get Started",
      "kSkip": "Skip",
      "kTermsAndConditions": "Terms & Conditions",
      "kWashWin": "Wash & Win!",
      "kGetYourCarWashed":
          "Get your car washed weekly at 100+ locations with exclusive offers.",
      "kMissedWashesStillDeducted": "Missed washes still deducted.",

      ///  Login screen
      "kLogin": "Log In!",
      "kWelcomeBack": "Welcome Back,",
      "kEmail": "Email",
      "kPassword": "Password",
      "kForgotPassword": "Forgot Password?",
      "kLogIn": "Log In",
      "kDontAaveAccount": "Don’t have account? ",
      "SIGNUP": "SIGN UP",
      "kOR": "OR",
      "kHaveAnAccount": "Have an account? ",
      "LOGIN": "LOGIN",

      /// SIgn up screen
      "kHello": "Hello,",
      "kSignUp": "Sign Up!",
      "kName": "Name",
      "kPhone": "Phone",
      "kConfirmPassword": "Confirm Password ",
      "signUp": "Sign Up",
      "kEnterYourFullName": "Enter your full name",
      "kEnterYourEmail": "Enter your email",
      "kEnterPhoneNumber": "Enter phone number",
      "kZone": "Zone",
      "kStreet": "Street",
      "kBuilding": "Building",
      "kUnit": "Unit",

      /// forgot password screen
      "kForgot": "Forgot",
      "kEnterRegisteredPhone": "Enter Registered Phone",
      "kEnterThePhoneNumber":
          "Enter the phone number associated\nwith your account",
      "kEnterYourPhoneNumber": "Enter your phone number",
      "kRecoverPassword": "Recover password",

      /// otp screen
      "kAuthentication": "Authentication",
      "kOTP": "OTP",
      "kVerifyPhone": "Verify Phone",
      "kCodeHasBeenSentTo": 'Code has been sent to ',
      "kDidGetOTPCode": "Didn't get OTP Code ?",
      "KResendCode": "RESEND CODE",
      "kVerify": "Verify",
      "kInvalidOTP": "Invalid OTP",
      "kError": "Error",
      "kSomethingWentWrong": "Something went wrong",
      "kPleaseEnterTheCorrectOTP": "Please enter the correct OTP",
      "kEnterValidOTP": "Enter valid OTP",

      /// Reset password screen
      "kReset": "Reset",
      "kCreateNewPassword": "Create New Password",
      "kYourNewPasswordMust":
          "Your New Password Must be different\nfrom Previously used password",
      "kSave": "Save",

      /// subscription screen
      "kFullAccessSubscription": "Full access subscription",
      "kChooseAPlan": "Choose a plan",
      "kGetBenefitsAcrossAll": "Get benefits across all plans.\nIt's your call",
      "kSubscribe": "subscribe",
      "kCarRegistrationNumber": "Car Registration Number Required for",
      "kUnlimitedWashesPlan": "Unlimited Washes Plan",
      "kEnterCarNumber": "Enter car number",
      "WashYourCarOnce":
          "Wash your car once a week. If the car is not washed within the week, it will not be compensated and will still be deducted.",

      /// Enter Card Detail Screen
      "kEnterYourPaymentDetails": "Enter your\npayment details",
      "kByContinuingYouAgree": "By continuing you agree to our ",
      'kTerms': 'Terms',
      "kEnterCardholderName": "Enter cardholder name",
      "kCardholderName": "Cardholder name",
      "kCardNumber": "Card Number",
      "kExpMonth": "Exp Month",
      "kExpYear": "Exp Year",
      "kCVC": "CVC",
      "kPay": "Pay: ",
      "kSwipeToConfirm": "Swipe to confirm",

      /// wash status screen
      "kCompleteWash": "Complete Wash",
      "kTotalWashes": "Total Washes",
      "kWash": "Wash",
      "kLocations": "Locations",
      "kRemaining": "Remaining",
      "kYourCurrentLocation": "Your current location",
      "kFetchingLocation": "Fetching location...",
      "kNoNearbyLocationsFound": "No nearby locations found",
      "kWashComplete": "Wash Complete!",
      "kShareYourFeedback": "Share your feedback and\nrate the Customer.",
      "kEnterYourCommentHere": "Enter your comment here...",
      "kSubmit": "Submit",
      "kLocationServicesAreDisabled": "Location services are disabled",
      "kLocationPermissionDenied": "Location permission denied",
      "kLocationPermissionPermanentlyDenied":
          "Location permission permanently denied",
      "kCouldNotRetrieveAddressDetails": "Could not retrieve address details",
      "kLocationNotAvailable": "Location not available",
      "kImageNotAvailable": "Image not available",
      "kInvalidImage": "Invalid image",
      "kExploreAllExclusiveOffers": "Explore All Exclusive Offers",
      "kCheckNow": "Check Now",
      "kCongratulations": "Congratulations!",
      "kYourRewardHasBeenSuccessfullyRedeemed":
          "Your Reward Has Been\nSuccessfully Redeemed!",

      ///Reward screen
      "kSortByExpiry": "Sort by Expiry",
      "kAscendingOrder": "Ascending Order",
      "kDescendingOrder": "Descending Order",
      "kNoExpiry": "No Expiry",
      "kExpired": "Expired",
      "kYears": "years",
      "kMonths": "months",
      "kDays": "days",
      "kHours": "hours",
      "kMinutes": "minutes",
      "kSeconds": "seconds",
      "kInvalidDate": "Invalid date",

      /// faq screen
      "kFAQ": "FAQ’s",
      "kSearch": "Search...",
      "kNoFAQsFound": "No FAQs found",

      /// Second Drawer
      "kGetHelp": "Get Help?",
      "kCouldNotLaunch": "Could not launch",
      "kChatWithSupport": 'Chat with Support',
      "kHelpDeskTicket": 'Help Desk Ticket',
      "kStepByStep": 'Step-by-Step Guide',

      /// step by step screen
      "kNoTitle": 'No Title',
      "kNoDescription": 'No Description',
      "kStepByStepGuideDetail": "Step-by-Step Guide - Detail",
      "kStepByStepGuide": "Step-by-Step Guide",

      /// Dashboard screen
      "kOffersForYou": "Offers For You",
      "kNotification": "Notification’s",
      "kRedeemWash": "Redeem Wash!",
      "kScanYourQR": "Scan Your QR Code to\nEnjoy Your Wash.",
      "kConfirmExit": "Confirm Exit",
      "kDoYouReally": "Do you really want to close the app?",
      "kNo": "No",
      "kYes": "Yes",

      /// Notification screen
      "kProvisionalPermissionGranted": "Provisional Permission Granted",
      "kYouWillReceive":
          "You will receive notifications, but they may be limited.",
      "kNotificationPermissionDenied": "Notification Permission Denied",
      "kPleaseAllow": "Please allow notifications to receive updates.",
      "kFailedToRequest": "Failed to request notification permission.",
      "kNotificationClicked": "Notification Clicked",
      "kNoRouteFound": "No route found in notification.",
      "kNoNotificationFound": "No Notifications Found",
      "kYour": 'Your ',
      "kPackHasBeenOverdueSince": ' Pack Has\n Been Overdue Since',

      /// Profile Screen
      "kSuccess": "Success",
      "kProfileUpdatedSuccessfully": 'Profile updated successfully',
      "kPackExpiringIn": ' pack\nexpiring in ',
      "kMyAccount": 'My Account',
      "kSubscriptionPlan": 'Subscription Plan',
      "kTheme": 'Theme',
      "kLanguage": 'Language',
      "kPrivacySettings": 'Privacy Settings',
      "kTermsAndCondition": 'Terms & Conditions',
      "kLogout": "Logout",
      "kArabic": "Arabic",
      "kEnglish": "English",
      "kSelectImageSource": "Select Image Source",
      "kCamera": "Camera", "kGallery": "Gallery",
      "kPleaseEnterYourName": 'Please enter your name',
      "kPleaseEnterYourEmail": 'Please enter your email',
      "kPleaseEnterYourPhone": 'Please enter your phone',
      "kCarNumber": "Car Number",
      'kPackName': 'Pack Name ',

      "kRemainingWash": "Remaining wash",
      'kExpiryDate': 'Expiry date ',
      "kUpgradeYourPlanNow": "upgrade your Plan now",
      "kNoPlansAvailable": "No plans available",
      "kYouCanRenewYourSubscriptionOnlyWithin7DaysOfExpiry":
          "You can renew your subscription only within 7 days of expiry.",
      "kRenewNow": "Renew Now",
      "kYear": "/ Year",
      "kRenewalNotAvailable": "Renewal Not Available",
      "kNoPlanSelected.": "No plan selected.",
    },

    'hi_IN': {
      "kEcoCleanWalletGreen": "इको क्लीन, वॉलेट ग्रीन!",
      "kExclusiveDealsWithEvery":
          "हर शाइन फ्री कूपन, BOGO ऑफर, छूट और विशेष सुविधाओं के साथ विशेष सौदे!",
      " kGetStarted": "शुरू हो जाओ",
    },
  };
}
