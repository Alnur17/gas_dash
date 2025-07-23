class Api {
  /// base url
  static const baseUrl = "https://api.gasdash.io/api/v1";
  static const socketUrl = "https://socket.gasdash.io";

  ///auth
  static const register = "$baseUrl/users/create"; //done
  static const login = "$baseUrl/auth/login"; //done
  static const forgotPassword = "$baseUrl/auth/forgot-password"; //done
  static const otpVerify = "$baseUrl/otp/verify-otp"; //done
  static const reSendOtp = "$baseUrl/otp/resend-otp"; //done
  static const resetPassword = "$baseUrl/auth/reset-password"; //done
  static const changePassword = "$baseUrl/auth/change-password"; //done

  ///Gas Prices
  static const fuelInfo = "$baseUrl/fuelInfo/userzipprise"; //done

  ///Business Hour
  static const businessHour = "$baseUrl/business-ours"; //done

  ///Services
  static const service = "$baseUrl/services/"; //done

  ///message
  static const String allFriends = "$baseUrl/chats/my-chat-list";//done
  static const String createChat = "$baseUrl/chats";//done
  static const String sendMessage = "$baseUrl/messages/send-messages";//done
  static chatDetails(chatId) =>
      "$baseUrl/messages/?chat=$chatId&sort=createdAt";//done

  ///Add Vehicle

  static const addVehicle = "$baseUrl/vehicles/create"; //done

  static const getMyVehicle = "$baseUrl/vehicles/my-vehicles"; //done
  static const getMySubscriptionVehicle = "$baseUrl/vehicles/subscription-vehicles"; //done

  ///Order
  static const createOrder = "$baseUrl/orders/create-orderFuel"; //done
  static cancelOrder(String orderId) => "$baseUrl/orders/$orderId"; //done

  static const orderHistory = "$baseUrl/orders/my-order"; //done

  static String singleOrderById(String orderId) => "$baseUrl/orders/$orderId"; //done

  static String orderDataConfirmation(String id) => "$baseUrl/orders/$id"; //done
  static String orderReAssign(String id) => "$baseUrl/orders/reassign/$id"; //done

  ///Coupon
  static String coupon(String couponValue) => "$baseUrl/cupons/check/$couponValue"; //done

  ///driver assigned order
  static const assignedOrder = "$baseUrl/orders/driver"; //done

  ///profile
  static const String myProfile = "$baseUrl/users/my-profile"; //done

  static const String editMyProfile = "$baseUrl/users/update-my-profile"; //done

  // static String confirmPayment(String sessionsId, String paymentId) =>
  //     "$baseUrl/payments/confirm-payment?sessionId=$sessionsId&paymentId=$paymentId"; //

  /// payment
  static const String createPayment = "$baseUrl/payments/checkout"; //done

  ///Driver Earning
  static String singleDriverEarning(String id) => "$baseUrl/driverearnings/driver-erning/$id"; //done

  //static String paymentDetails(String id) => "$baseUrl/payments/$id"; //

  static const String withdrawRequest = "$baseUrl/withdrawal/create-withdraw"; //

  static const String notifications = "$baseUrl/notifications";

  /// Term and conditions
  static const String conditions = "$baseUrl/settings/";

  ///Create Delivery/accept order
  static const String acceptOrder = "$baseUrl/delivery/create-delivery/";

  ///Subscriptions

  static const String subscriptionCreate = "$baseUrl/subscription/";
  static const String subscriptionPayment = "$baseUrl/payments/subscription/checkout";
  static const String subscriptionPackage = "$baseUrl/packages/";

  ///Questions
  static const String questions = "$baseUrl/questions/";
  static const String questionsCheckList = "$baseUrl/checklist/create-checklist";

  static String updateDelivery(String deliveryId) => "$baseUrl/delivery/update/$deliveryId";


  ///Reviews

  static  String createReview(String driverId) => "$baseUrl/reviews/create";

  static  String getReviews(String driverId) => "$baseUrl/reviews/driver/$driverId";

  ///tips
  static const String optionalTipCreate = "$baseUrl/optionalTip/create";
  static const String optionalTipCheckout = "$baseUrl/payments/optional-tip/checkout";

  ///Banner
  static const String emergencyBanner = "$baseUrl/discountBanner";
  static const String discountBanner = "$baseUrl/emergencyFuelBanner";
}
