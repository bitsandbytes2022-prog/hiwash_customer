class ApiConstant{

static const baseUrl="https://loyaltyapistaging.pipelinedns.com";


static const getToken="$baseUrl/api/authentication/token";
static  getCustomerId(int id)=>"$baseUrl/api/customer/$id";
static const getSubscription="$baseUrl/api/subscription";
static const getSubscriptionMembership="/api/subscription/membership";
static  getFaq(int entityType)=>"/api/content/faqs?entityType=$entityType";
static  getGuides(int entityType)=>"/api/content/guides?entityType=$entityType";
static  getTermsAndConditions(int entityType)=>"/api/content/termsandconditions?entityType=$entityType";
static const getOffers="$baseUrl/api/offer";







}