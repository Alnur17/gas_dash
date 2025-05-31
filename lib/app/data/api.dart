class Api {
  /// base url
  //static const baseUrl = "http://192.168.10.160:8000/api/v1";
  static const baseUrl = "http://172.252.13.83:8000/api/v1";

  ///auth
  static const register = "$baseUrl/users/create"; //done
  static const login = "$baseUrl/auth/login"; //done
  static const forgotPassword = "$baseUrl/auth/forgot-password"; //done
  static const otpVerify = "$baseUrl/otp/verify-otp"; //done
  static const reSendOtp = "$baseUrl/otp/resend-otp"; //done
  static const resetPassword = "$baseUrl/auth/reset-password"; //done
  static const changePassword = "$baseUrl/auth/change-password"; //

  ///Gas Prices
  static const fuelInfo = "$baseUrl/fuelInfo"; //done


  ///Services
  static const service = "$baseUrl/services/"; //

  ///Add Vehicle

  static const addVehicle = "$baseUrl/vehicles/create"; //done

  static const getMyVehicle = "$baseUrl/vehicles/my-vehicles"; //done


  ///Order
  static const createOrder = "$baseUrl/orders/create-orderFuel"; //done

  static  String orderDataConfirmation(String id) => "$baseUrl/orders/$id"; //


  /// get session details by id
  static getSingleSession(String id) => "$baseUrl/sessions/$id"; //done

  /// get trainer details by id
  static getSingleTrainer(String id) => "$baseUrl/trainers/$id"; //done

  ///showBookMarked
  static const myBookings= "$baseUrl/bookings/my-bookings"; //done

  static const addBookings = "$baseUrl/bookings"; // done

  static getSingleBookingById(String id) => "$baseUrl/bookings/$id"; // done

  static cancelBooking(String id) => "$baseUrl/bookings/canceled/$id"; // done

  /// WaitList
  static const addMyWaitlist = "$baseUrl/waitLists"; // done

  static const getMyWaitlist = "$baseUrl/waitLists/my-waitlist"; //done

  static removeWaitlist(String id) => "$baseUrl/waitLists/$id"; //done

  static removeWaitlistBySessionId(String sessionId) =>
      "$baseUrl/waitLists/session/$sessionId"; //done

  /// All slot
  static timeSlot(String id) => "$baseUrl/session-slots/session/$id"; // done

  ///profile
  static const String myProfile = "$baseUrl/users/my-profile"; //done

  static const String editMyProfile = "$baseUrl/users/update-my-profile"; //done

  static const String conditionsPage = "$baseUrl/settings"; //done

  static String confirmPayment(String sessionsId, String paymentId) =>
      "$baseUrl/payments/confirm-payment?sessionId=$sessionsId&paymentId=$paymentId"; //done


  /// payment
  static const String createPayment = "$baseUrl/payments/checkout"; //done

  static String paymentDetails(String id) => "$baseUrl/payments/$id"; //done

  static String singlePaymentByBookingId(String id) => "$baseUrl/payments/reference/$id"; //done

  static const String refundPayment =
      "$baseUrl/payments/refound-payment"; //done

  static const String membershipPackages = "$baseUrl/packages"; //done

  static const String creditPackages = "$baseUrl/credits?sort=credits"; //done



  static const  String createSubscription = "$baseUrl/subscriptions"; //done

  static const String notifications =
      "$baseUrl/notification/my-notification"; //done
}
