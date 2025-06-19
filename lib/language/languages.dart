import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'kHellos': 'Hello hello',
      "kWelcomeToThe": "Welcome to the",
      "kHiWASH": "HI WASH",
      "kSkip":"Skip",
      "kWeComeToYouTo": "We come to you to\nwash your car...!!",

      ///  welcome screen
      "kEcoCleanWalletGreen": "Eco Clean, Wallet Green!",
      "kExclusiveDealsWithEvery":
          "Exclusive Deals with Every Shine Free\nCoupons, BOGO Offers, Discounts &\nSpecial Perks!",
      "kGetStarted": "Get Started",
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
      "kEMailIsRequired": "E-mail is required",
      "kPLeaseEnterValid": "Please Enter A Valid Email",
      'kPasswordIsRequired': 'Password is required',
      "kPasswordMustBeAtLeast": 'Password must be at least 8 characters long',
      "kPasswordMustContainAtLeastOneUpperCaseLetter":
          'Password must contain at least one uppercase letter',
      "kPasswordMustContainAtLeastOneLowerCaseLetter":
          'Password must contain at least one lowercase letter',
      "kPasswordMustContainAtLeastOneDigit":
          'Password must contain at least one digit',
      "PasswordMustContainAtLeastOneSpecialCharacter":
          'Password must contain at least one special character',
      "kNameIsRequired": "Name is required",
      "kNameMustBeAtLeast": "Name must be at least 3 characters",
      "kNameMustOnlyContainAlphabetsAndSpaces":
          "Name must only contain alphabets and spaces",
      "kPleaseEnterYourPhoneNumber": "Please Enter Valid Phone Number",
      "kPhoneNumberCannotBeEmpty": "Phone number cannot be empty",
      "kConfirmPassword": "Confirm password is required",
      "kTestOTP": "TEST OTP: ",

      /// SIgn up screen
      "kHello": "Hello,",
      "kSignUp": "Sign Up!",
      "kName": "Name",
      "kPhone": "Phone",
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
      "kHour": "hour",
      "kMinutes": "minutes",
      "kMinute": "minute",
      "kSeconds": "seconds",
      "kSecond": "second",
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

      ///subscription Screen
      "kMissingSubscription":
          "Missing subscription details (SubscriptionScreen)",
      'k100locations': '100+\nlocations ',
      'kUnlock': '& unlock',
      'kExclusiveOffers': ' exclusive offers.',
      'kSubscribeNow': 'subscribe Now',
      "kPleaseEnterYourCarNumber": "Please enter your car number",
      "kViewAllOffers": "View All Offers",
      "kKm": "km",
      "kSeeAllExclusiveOffers": "See All Exclusive Offers.",

      /// app component
      'kRemainingWashes': 'Remaining Washes: ',
      "kDateIsNotFound": 'Data is not found',
      "kOfferDetails": "Offer Details",
      "kHowToRedeem": "How to redeem",
      "kReportAnIssue": "Report an issue",
      "kYourRewardHasBeen": "Your Reward Has Been\nSuccessfully Redeemed!",
      "kDay": "Day",
      "kHRS": "HRS",
      "kMINS": "MINS",
      "kQrNotGenerated": "Qr Not\nGenerated",
      "kSuccesss": "Success!",
      "kPlanIsNowActivated": " plan is now activated.",
      "kScanToUnlockWeekly":
          "Scan to unlock weekly washes,\nexclusive offers, and amazing deals!",
      "kYourPaymentIsComplete": "Your payment is complete, and your\n",
      "kPaymentSuccessfully": "Payment Successfully",
      "kYouHaveCompletedYourPayment":"You have completed your payment",
      "kOk":"Ok"
    },

    'ar_SA': {
      'kHellos': 'أهلاً مرحباً',
      "kWelcomeToThe": "مرحباً بك في",
      "kHiWASH": "مرحباً واش",
      "kSkip": "تخطي",
      "kWeComeToYouTo": "نأتي إليك لغسل\nسيارتك...!!",

      ///  welcome screen
      "kEcoCleanWalletGreen": "نظافة بيئية، محفظة خضراء!",
      "kExclusiveDealsWithEvery":
      "عروض حصرية مع كل لمعة\nكوبونات مجانية، عروض اشتر واحد واحصل على آخر، خصومات\nومزايا خاصة!",
      "kGetStarted": "ابدأ الآن",
      "kTermsAndConditions": "الشروط والأحكام",
      "kWashWin": "اغسل واربح!",
      "kGetYourCarWashed":
      "احصل على غسيل سيارتك أسبوعياً في أكثر من 100 موقع مع عروض حصرية.",
      "kMissedWashesStillDeducted": "الغسلات الفائتة ما زالت تُخصم.",

      ///  Login screen
      "kLogin": "تسجيل الدخول!",
      "kWelcomeBack": "مرحباً بعودتك،",
      "kEmail": "البريد الإلكتروني",
      "kPassword": "كلمة المرور",
      "kForgotPassword": "نسيت كلمة المرور؟",
      "kLogIn": "تسجيل الدخول",
      "kDontAaveAccount": "ليس لديك حساب؟ ",
      "SIGNUP": "إنشاء حساب",
      "kOR": "أو",
      "kHaveAnAccount": "لديك حساب؟ ",
      "LOGIN": "تسجيل الدخول",
      "kEMailIsRequired": "البريد الإلكتروني مطلوب",
      "kPLeaseEnterValid": "يرجى إدخال بريد إلكتروني صحيح",
      'kPasswordIsRequired': 'كلمة المرور مطلوبة',
      "kPasswordMustBeAtLeast": 'كلمة المرور يجب أن تكون 8 أحرف على الأقل',
      "kPasswordMustContainAtLeastOneUpperCaseLetter":
      'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل',
      "kPasswordMustContainAtLeastOneLowerCaseLetter":
      'كلمة المرور يجب أن تحتوي على حرف صغير واحد على الأقل',
      "kPasswordMustContainAtLeastOneDigit":
      'كلمة المرور يجب أن تحتوي على رقم واحد على الأقل',
      "PasswordMustContainAtLeastOneSpecialCharacter":
      'كلمة المرور يجب أن تحتوي على رمز خاص واحد على الأقل',
      "kNameIsRequired": "الاسم مطلوب",
      "kNameMustBeAtLeast": "الاسم يجب أن يكون 3 أحرف على الأقل",
      "kNameMustOnlyContainAlphabetsAndSpaces":
      "الاسم يجب أن يحتوي على أحرف ومسافات فقط",
      "kPleaseEnterYourPhoneNumber": "يرجى إدخال رقم هاتف صحيح",
      "kPhoneNumberCannotBeEmpty": "رقم الهاتف لا يمكن أن يكون فارغاً",
      "kConfirmPassword": "تأكيد كلمة المرور مطلوب",
      "kTestOTP": "رمز التحقق التجريبي: ",

      /// SIgn up screen
      "kHello": "أهلاً،",
      "kSignUp": "إنشاء حساب!",
      "kName": "الاسم",
      "kPhone": "الهاتف",
      "signUp": "إنشاء حساب",
      "kEnterYourFullName": "أدخل اسمك الكامل",
      "kEnterYourEmail": "أدخل بريدك الإلكتروني",
      "kEnterPhoneNumber": "أدخل رقم الهاتف",
      "kZone": "المنطقة",
      "kStreet": "الشارع",
      "kBuilding": "المبنى",
      "kUnit": "الوحدة",

      /// forgot password screen
      "kForgot": "نسيت",
      "kEnterRegisteredPhone": "أدخل الهاتف المسجل",
      "kEnterThePhoneNumber":
      "أدخل رقم الهاتف المرتبط\nبحسابك",
      "kEnterYourPhoneNumber": "أدخل رقم هاتفك",
      "kRecoverPassword": "استرداد كلمة المرور",

      /// otp screen
      "kAuthentication": "المصادقة",
      "kOTP": "رمز التحقق",
      "kVerifyPhone": "تحقق من الهاتف",
      "kCodeHasBeenSentTo": 'تم إرسال الرمز إلى ',
      "kDidGetOTPCode": "لم تحصل على رمز التحقق؟",
      "KResendCode": "إعادة إرسال الرمز",
      "kVerify": "تحقق",
      "kInvalidOTP": "رمز تحقق غير صحيح",
      "kError": "خطأ",
      "kSomethingWentWrong": "حدث خطأ ما",
      "kPleaseEnterTheCorrectOTP": "يرجى إدخال رمز التحقق الصحيح",
      "kEnterValidOTP": "أدخل رمز تحقق صحيح",

      /// Reset password screen
      "kReset": "إعادة تعيين",
      "kCreateNewPassword": "إنشاء كلمة مرور جديدة",
      "kYourNewPasswordMust":
      "كلمة المرور الجديدة يجب أن تكون مختلفة\nعن كلمة المرور المستخدمة سابقاً",
      "kSave": "حفظ",

      /// subscription screen
      "kFullAccessSubscription": "اشتراك الوصول الكامل",
      "kChooseAPlan": "اختر خطة",
      "kGetBenefitsAcrossAll": "احصل على المزايا عبر جميع الخطط.\nالخيار لك",
      "kSubscribe": "اشترك",
      "kCarRegistrationNumber": "رقم تسجيل السيارة مطلوب لـ",
      "kUnlimitedWashesPlan": "خطة الغسلات غير المحدودة",
      "kEnterCarNumber": "أدخل رقم السيارة",
      "WashYourCarOnce":
      "اغسل سيارتك مرة واحدة في الأسبوع. إذا لم يتم غسل السيارة خلال الأسبوع، فلن يتم تعويضها وسيتم خصمها.",

      /// Enter Card Detail Screen
      "kEnterYourPaymentDetails": "أدخل\nتفاصيل الدفع",
      "kByContinuingYouAgree": "بالمتابعة أنت توافق على ",
      'kTerms': 'الشروط',
      "kEnterCardholderName": "أدخل اسم حامل البطاقة",
      "kCardholderName": "اسم حامل البطاقة",
      "kCardNumber": "رقم البطاقة",
      "kExpMonth": "شهر الانتهاء",
      "kExpYear": "سنة الانتهاء",
      "kCVC": "رمز الأمان",
      "kPay": "ادفع: ",
      "kSwipeToConfirm": "اسحب للتأكيد",

      /// wash status screen
      "kCompleteWash": "غسلة كاملة",
      "kTotalWashes": "إجمالي الغسلات",
      "kWash": "غسل",
      "kLocations": "المواقع",
      "kRemaining": "المتبقي",
      "kYourCurrentLocation": "موقعك الحالي",
      "kFetchingLocation": "جاري تحديد الموقع...",
      "kNoNearbyLocationsFound": "لم يتم العثور على مواقع قريبة",
      "kWashComplete": "اكتمل الغسيل!",
      "kShareYourFeedback": "شارك ملاحظاتك\nوقيم العميل.",
      "kEnterYourCommentHere": "أدخل تعليقك هنا...",
      "kSubmit": "إرسال",
      "kLocationServicesAreDisabled": "خدمات الموقع معطلة",
      "kLocationPermissionDenied": "تم رفض إذن الموقع",
      "kLocationPermissionPermanentlyDenied":
      "تم رفض إذن الموقع نهائياً",
      "kCouldNotRetrieveAddressDetails": "لا يمكن استرداد تفاصيل العنوان",
      "kLocationNotAvailable": "الموقع غير متاح",
      "kImageNotAvailable": "الصورة غير متاحة",
      "kInvalidImage": "صورة غير صحيحة",
      "kExploreAllExclusiveOffers": "استكشف جميع العروض الحصرية",
      "kCheckNow": "تحقق الآن",
      "kCongratulations": "تهانينا!",
      "kYourRewardHasBeenSuccessfullyRedeemed":
      "تم استرداد مكافأتك\nبنجاح!",

      ///Reward screen
      "kSortByExpiry": "ترتيب حسب الانتهاء",
      "kAscendingOrder": "ترتيب تصاعدي",
      "kDescendingOrder": "ترتيب تنازلي",
      "kNoExpiry": "بلا انتهاء",
      "kExpired": "منتهي الصلاحية",
      "kYears": "سنوات",
      "kMonths": "شهور",
      "kDays": "أيام",
      "kHours": "ساعات",
      "kHour": "ساعة",
      "kMinutes": "دقائق",
      "kMinute": "دقيقة",
      "kSeconds": "ثواني",
      "kSecond": "ثانية",
      "kInvalidDate": "تاريخ غير صحيح",

      /// faq screen
      "kFAQ": "الأسئلة الشائعة",
      "kSearch": "بحث...",
      "kNoFAQsFound": "لم يتم العثور على أسئلة شائعة",

      /// Second Drawer
      "kGetHelp": "احصل على مساعدة؟",
      "kCouldNotLaunch": "لا يمكن التشغيل",
      "kChatWithSupport": 'تحدث مع الدعم',
      "kHelpDeskTicket": 'تذكرة مكتب المساعدة',
      "kStepByStep": 'دليل خطوة بخطوة',

      /// step by step screen
      "kNoTitle": 'بلا عنوان',
      "kNoDescription": 'بلا وصف',
      "kStepByStepGuideDetail": "دليل خطوة بخطوة - التفاصيل",
      "kStepByStepGuide": "دليل خطوة بخطوة",

      /// Dashboard screen
      "kOffersForYou": "عروض لك",
      "kNotification": "الإشعارات",
      "kRedeemWash": "استرداد غسلة!",
      "kScanYourQR": "امسح رمز الاستجابة السريعة\nللاستمتاع بغسلتك.",
      "kConfirmExit": "تأكيد الخروج",
      "kDoYouReally": "هل تريد حقاً إغلاق التطبيق؟",
      "kNo": "لا",
      "kYes": "نعم",

      /// Notification screen
      "kProvisionalPermissionGranted": "تم منح إذن مؤقت",
      "kYouWillReceive":
      "ستحصل على إشعارات، لكنها قد تكون محدودة.",
      "kNotificationPermissionDenied": "تم رفض إذن الإشعارات",
      "kPleaseAllow": "يرجى السماح بالإشعارات لتلقي التحديثات.",
      "kFailedToRequest": "فشل في طلب إذن الإشعارات.",
      "kNotificationClicked": "تم النقر على الإشعار",
      "kNoRouteFound": "لم يتم العثور على مسار في الإشعار.",
      "kNoNotificationFound": "لم يتم العثور على إشعارات",
      "kYour": 'باقتك ',
      "kPackHasBeenOverdueSince": ' متأخرة\n منذ',

      /// Profile Screen
      "kSuccess": "نجح",
      "kProfileUpdatedSuccessfully": 'تم تحديث الملف الشخصي بنجاح',
      "kPackExpiringIn": ' تنتهي صلاحية الباقة\nخلال ',
      "kMyAccount": 'حسابي',
      "kSubscriptionPlan": 'خطة الاشتراك',
      "kTheme": 'المظهر',
      "kLanguage": 'اللغة',
      "kPrivacySettings": 'إعدادات الخصوصية',
      "kTermsAndCondition": 'الشروط والأحكام',
      "kLogout": "تسجيل الخروج",
      "kArabic": "العربية",
      "kEnglish": "الإنجليزية",
      "kSelectImageSource": "اختر مصدر الصورة",
      "kCamera": "الكاميرا", "kGallery": "المعرض",
      "kPleaseEnterYourName": 'يرجى إدخال اسمك',
      "kPleaseEnterYourEmail": 'يرجى إدخال بريدك الإلكتروني',
      "kPleaseEnterYourPhone": 'يرجى إدخال هاتفك',
      "kCarNumber": "رقم السيارة",
      'kPackName': 'اسم الباقة ',

      "kRemainingWash": "الغسلات المتبقية",
      'kExpiryDate': 'تاريخ الانتهاء ',
      "kUpgradeYourPlanNow": "قم بترقية خطتك الآن",
      "kNoPlansAvailable": "لا توجد خطط متاحة",
      "kYouCanRenewYourSubscriptionOnlyWithin7DaysOfExpiry":
      "يمكنك تجديد اشتراكك فقط خلال 7 أيام من انتهاء الصلاحية.",
      "kRenewNow": "جدد الآن",
      "kYear": "/ سنة",
      "kRenewalNotAvailable": "التجديد غير متاح",
      "kNoPlanSelected.": "لم يتم اختيار خطة.",

      ///subscription Screen
      "kMissingSubscription":
      "تفاصيل الاشتراك مفقودة (شاشة الاشتراك)",
      'k100locations': 'أكثر من 100\nموقع ',
      'kUnlock': 'وافتح',
      'kExclusiveOffers': ' العروض الحصرية.',
      'kSubscribeNow': 'اشترك الآن',
      "kPleaseEnterYourCarNumber": "يرجى إدخال رقم سيارتك",
      "kViewAllOffers": "عرض جميع العروض",
      "kKm": "كم",
      "kSeeAllExclusiveOffers": "شاهد جميع العروض الحصرية.",

      /// app component
      'kRemainingWashes': 'الغسلات المتبقية: ',
      "kDateIsNotFound": 'البيانات غير موجودة',
      "kOfferDetails": "تفاصيل العرض",
      "kHowToRedeem": "كيفية الاسترداد",
      "kReportAnIssue": "الإبلاغ عن مشكلة",
      "kYourRewardHasBeen": "تم استرداد مكافأتك\nبنجاح!",
      "kDay": "يوم",
      "kHRS": "ساعة",
      "kMINS": "دقيقة",
      "kQrNotGenerated": "رمز الاستجابة\nغير مُولد",
      "kSuccesss": "نجح!",
      "kPlanIsNowActivated": " تم تفعيل الخطة.",
      "kScanToUnlockWeekly":
      "امسح لفتح الغسلات الأسبوعية،\nالعروض الحصرية، والصفقات المذهلة!",
      "kYourPaymentIsComplete": "اكتملت عمليتك، و\n",
      "kPaymentSuccessfully": "تم الدفع بنجاح",
      "kYouHaveCompletedYourPayment": "لقد أكملت عملية الدفع",
      "kOk": "موافق"
    },
  };
}
