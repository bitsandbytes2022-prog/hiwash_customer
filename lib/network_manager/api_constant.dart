class ApiConstant{

static const baseUrl="https://loyaltyapistaging.pipelinedns.com/api";

static const String baseImageUrl = "https://loyaltyapistaging.pipelinedns.com";

static const sendOtp="$baseUrl/authentication/send-otp";
static const getToken="$baseUrl/authentication/token";
static const signUp="$baseUrl/customer";
static  getCustomerId(int id)=>"$baseUrl/customer/$id";
static const getSubscription="$baseUrl/subscription";
static const getSubscriptionMembership="/subscription/membership";
static  getFaq(int entityType)=>"/content/faqs?entityType=$entityType";
static  getGuides(int entityType)=>"/content/guides?entityType=$entityType";
static  getTermsAndConditions(int entityType)=>"/content/termsandconditions?entityType=$entityType";
static const getOffers="$baseUrl/offer";
static  getOffersById(int id)=>"$baseUrl/offer/$id";
static  const offerCategories="$baseUrl/offer/categories";
static const rating="$baseUrl/customer/rating";
static const washSummary="$baseUrl/customer/wash-summary";
static const uploadProfileImage="$baseUrl/customer/upload-profile-picture";
static const uploadProfile="$baseUrl/customer/update-profile";







}