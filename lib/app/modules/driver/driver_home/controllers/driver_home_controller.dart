// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
//
// import '../../../../../common/app_constant/app_constant.dart';
// import '../../../../../common/helper/local_store.dart';
// import '../../../../../common/app_color/app_colors.dart';
// import '../../../../../common/widgets/custom_snackbar.dart';
// import '../../../../data/api.dart';
// import '../../../../data/base_client.dart';
// import '../../driver_history/views/driver_order_details_view.dart';
// import '../model/assigned_order_model.dart';
// import '../model/single_order_by_Id_model.dart';
//
// class DriverHomeController extends GetxController {
//   var assignedOrders = <Datum>[].obs;
//   var pendingOrders = <Datum>[].obs;
//   var inProgressOrders = <Datum>[].obs;
//   var deliveredOrders = <Datum>[].obs;
//   var displayedOrders = <Datum>[].obs;
//   var isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAssignedOrders();
//   }
//
//   Future<void> fetchAssignedOrders() async {
//     try {
//       isLoading.value = true;
//
//       final String token = LocalStorage.getData(key: AppConstant.accessToken);
//
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token'
//       };
//
//       final response = await BaseClient.getRequest(
//         api: Api.assignedOrder,
//         headers: headers,
//       );
//
//       final result = await BaseClient.handleResponse(response);
//
//       final assignedOrder = AssignedOrderModel.fromJson(result);
//
//       if (assignedOrder.success == true && assignedOrder.data != null) {
//         assignedOrders.value = assignedOrder.data!.data;
//         filterOrders(); // Filter orders after fetching
//         showPendingOrders(); // Default to showing pending orders
//       } else {
//         debugPrint(assignedOrder.message ?? 'Failed to fetch orders',);
//         // kSnackBar(
//         //   message: assignedOrder.message ?? 'Failed to fetch orders',
//         //   bgColor: AppColors.orange,
//         // );
//         // Clear all lists on failure
//         assignedOrders.clear();
//         pendingOrders.clear();
//         inProgressOrders.clear();
//         deliveredOrders.clear();
//         displayedOrders.clear();
//       }
//     } catch (e) {
//
//        debugPrint(e.toString());
//       // Clear all lists on error
//       assignedOrders.clear();
//       pendingOrders.clear();
//       inProgressOrders.clear();
//       deliveredOrders.clear();
//       displayedOrders.clear();
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // Filter orders into pending, inProgress, and delivered lists
//   void filterOrders() {
//     pendingOrders.value = assignedOrders
//         .where((order) => order.orderStatus?.toLowerCase() == 'pending')
//         .toList();
//     inProgressOrders.value = assignedOrders
//         .where((order) => order.orderStatus?.toLowerCase() == 'inprogress')
//         .toList();
//     deliveredOrders.value = assignedOrders
//         .where((order) => order.orderStatus?.toLowerCase() == 'delivered')
//         .toList();
//   }
//
//   // Methods to display specific order statuses
//   void showPendingOrders() {
//     displayedOrders.value = pendingOrders;
//   }
//
//   void showInProgressOrders() {
//     displayedOrders.value = inProgressOrders;
//   }
//
//   void showDeliveredOrders() {
//     displayedOrders.value = deliveredOrders;
//   }
//
//   Future<void> fetchSingleOrder(String orderId,location) async {
//     try {
//       isLoading.value = true;
//
//       final String token = LocalStorage.getData(key: AppConstant.accessToken);
//
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token'
//       };
//
//       final response = await BaseClient.getRequest(
//         api: Api.singleOrderById(orderId),
//         headers: headers,
//       );
//
//       final result = await BaseClient.handleResponse(response);
//
//       final singleOrder = SingleOrderByIdModel.fromJson(result);
//
//       if (singleOrder.success == true && singleOrder.data != null) {
//         // Navigate to DriverOrderDetailsView with the fetched order data
//         Get.to(() => DriverOrderDetailsView(orderData: singleOrder.data!,location: location,));
//       } else {
//         kSnackBar(
//           message: singleOrder.message ?? 'Failed to fetch order details',
//           bgColor: AppColors.orange,
//         );
//       }
//     } catch (e) {
//       kSnackBar(
//         message: e.toString(),
//         bgColor: AppColors.orange,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> acceptOrder(String orderId) async {
//     try {
//       isLoading.value = true;
//
//       final String token = LocalStorage.getData(key: AppConstant.accessToken);
//
//       final headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token'
//       };
//
//       final body = {
//         "orderId": orderId,
//       };
//
//       final response = await BaseClient.postRequest(
//         api: Api.acceptOrder,
//         body: jsonEncode(body),
//         headers: headers,
//       );
//
//       final result = await BaseClient.handleResponse(response);
//
//       if (result['success'] == true) {
//         kSnackBar(
//           message: result['message'] ?? 'Order accepted successfully',
//           bgColor: AppColors.primaryColor,
//         );
//         fetchAssignedOrders(); // Refresh orders after acceptance
//         pendingOrders.refresh();
//         displayedOrders.refresh();
//       } else {
//         kSnackBar(
//           message: result['message'] ?? 'Failed to accept order',
//           bgColor: AppColors.orange,
//         );
//       }
//     } catch (e) {
//       kSnackBar(
//         message: e.toString(),
//         bgColor: AppColors.orange,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // // Placeholder for accept order action
//   // void acceptOrder(String orderId) {
//   //   kSnackBar(
//   //     message: 'Accept order $orderId pressed',
//   //     bgColor: AppColors.primaryColor,
//   //   );
//   // }
//
//   var locationNames = <String, String>{}.obs;
//
//   Future<void> resolveLocation(String orderId, double lat, double lng) async {
//     if (!locationNames.containsKey(orderId)) {
//       try {
//         List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//         if (placemarks.isNotEmpty) {
//           final place = placemarks.first;
//           // Build a more detailed address
//           final address = [
//             place.street,
//             place.subLocality,
//             place.subAdministrativeArea,
//             place.country,
//           ].where((element) => element != null && element.isNotEmpty).join(", ");
//
//           locationNames[orderId] = address.isNotEmpty ? address : "Unknown";
//         } else {
//           locationNames[orderId] = "Unknown";
//         }
//       } catch (e) {
//         locationNames[orderId] = "Unknown";
//       }
//     }
//   }
//
//
//   // Placeholder for view details action
//   void viewOrderDetails(String orderId,location) {
//     fetchSingleOrder(orderId,location); // Call fetchSingleOrder to get details and navigate
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../driver_history/views/driver_order_details_view.dart';
import '../model/assigned_order_model.dart';
import '../model/single_order_by_Id_model.dart';

class DriverHomeController extends GetxController {
  var assignedOrders = <Datum>[].obs;
  var pendingOrders = <Datum>[].obs;
  var inProgressOrders = <Datum>[].obs;
  var deliveredOrders = <Datum>[].obs;
  var displayedOrders = <Datum>[].obs;
  var isLoading = false.obs;
  var locationNames = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssignedOrders();
  }

  Future<void> fetchAssignedOrders() async {
    try {
      isLoading.value = true;

      final String token = LocalStorage.getData(key: AppConstant.accessToken);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await BaseClient.getRequest(
        api: Api.assignedOrder,
        headers: headers,
      );

      print('Assigned Orders API Response: $response');

      final result = await BaseClient.handleResponse(response);

      final assignedOrder = AssignedOrderModel.fromJson(result);

      if (assignedOrder.success == true && assignedOrder.data != null) {
        assignedOrders.value = assignedOrder.data!.data;
        filterOrders();
        showPendingOrders();
      } else {
        debugPrint(assignedOrder.message ?? 'Failed to fetch orders');
        kSnackBar(
          message: assignedOrder.message ?? 'Failed to fetch orders',
          bgColor: AppColors.orange,
        );
        assignedOrders.clear();
        pendingOrders.clear();
        inProgressOrders.clear();
        deliveredOrders.clear();
        displayedOrders.clear();
      }
    } catch (e) {
      debugPrint('Error fetching assigned orders: $e');
      kSnackBar(
        message: 'Error fetching orders: $e',
        bgColor: AppColors.orange,
      );
      assignedOrders.clear();
      pendingOrders.clear();
      inProgressOrders.clear();
      deliveredOrders.clear();
      displayedOrders.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void filterOrders() {
    pendingOrders.value = assignedOrders
        .where((order) => order.orderStatus?.toLowerCase() == 'pending')
        .toList();
    inProgressOrders.value = assignedOrders
        .where((order) => order.orderStatus?.toLowerCase() == 'inprogress')
        .toList();
    deliveredOrders.value = assignedOrders
        .where((order) => order.orderStatus?.toLowerCase() == 'delivered')
        .toList();
  }

  void showPendingOrders() {
    displayedOrders.value = pendingOrders;
  }

  void showInProgressOrders() {
    displayedOrders.value = inProgressOrders;
  }

  void showDeliveredOrders() {
    displayedOrders.value = deliveredOrders;
  }

  Future<void> fetchSingleOrder(String orderId, String location) async {
    try {
      isLoading.value = true;

      final String token = LocalStorage.getData(key: AppConstant.accessToken);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await BaseClient.getRequest(
        api: Api.singleOrderById(orderId),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      final singleOrder = SingleOrderByIdModel.fromJson(result);

      if (singleOrder.success == true && singleOrder.data != null) {
        Get.to(() => DriverOrderDetailsView(orderData: singleOrder.data!, location: location));
      } else {
        kSnackBar(
          message: singleOrder.message ?? 'Failed to fetch order details',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(
        message: 'Error fetching order details: $e',
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> acceptOrder(String orderId) async {
    try {
      isLoading.value = true;

      final String token = LocalStorage.getData(key: AppConstant.accessToken);

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final body = {
        "orderId": orderId,
      };

      final response = await BaseClient.postRequest(
        api: Api.acceptOrder,
        body: jsonEncode(body),
        headers: headers,
      );

      final result = await BaseClient.handleResponse(response);

      if (result['success'] == true) {
        // Extract _id (deliveryId) from the response
        final deliveryId = result['data']['_id'];
        if (deliveryId != null) {
          // Save deliveryId to LocalStorage
          await LocalStorage.saveData(key: AppConstant.deliveryId, data: deliveryId);
          print('Saved deliveryId to LocalStorage: $deliveryId');
        } else {
          print('No deliveryId found in response');
          kSnackBar(
            message: 'Failed to retrieve delivery ID',
            bgColor: AppColors.orange,
          );
        }

        kSnackBar(
          message: result['message'] ?? 'Order accepted successfully',
          bgColor: AppColors.primaryColor,
        );
        // Refresh orders
        fetchAssignedOrders();
        pendingOrders.refresh();
        displayedOrders.refresh();
      } else {
        kSnackBar(
          message: result['message'] ?? 'Failed to accept order',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(
        message: 'Error accepting order: $e',
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }
  //
  // Future<void> acceptOrder(String orderId) async {
  //   try {
  //     isLoading.value = true;
  //
  //     final String token = LocalStorage.getData(key: AppConstant.accessToken);
  //
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
  //
  //     final body = {
  //       "orderId": orderId,
  //     };
  //
  //     final response = await BaseClient.postRequest(
  //       api: Api.acceptOrder,
  //       body: jsonEncode(body),
  //       headers: headers,
  //     );
  //
  //     final result = await BaseClient.handleResponse(response);
  //
  //     if (result['success'] == true) {
  //       final deliveryId = result['data']['_id'];
  //       final delId = LocalStorage.saveData(key: AppConstant.deliveryId, data: deliveryId);
  //       print('DelId $delId');
  //       kSnackBar(
  //         message: result['message'] ?? 'Order accepted successfully',
  //         bgColor: AppColors.primaryColor,
  //       );
  //       fetchAssignedOrders();
  //       pendingOrders.refresh();
  //       displayedOrders.refresh();
  //     } else {
  //       kSnackBar(
  //         message: result['message'] ?? 'Failed to accept order',
  //         bgColor: AppColors.orange,
  //       );
  //     }
  //   } catch (e) {
  //     kSnackBar(
  //       message: 'Error accepting order: $e',
  //       bgColor: AppColors.orange,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> resolveLocation(String orderId, double lat, double lng) async {
    if (!locationNames.containsKey(orderId)) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final address = [
            place.street,
            place.subLocality,
            place.subAdministrativeArea,
            place.country,
          ].where((element) => element != null && element.isNotEmpty).join(", ");
          locationNames[orderId] = address.isNotEmpty ? address : "Unknown";
        } else {
          locationNames[orderId] = "Unknown";
        }
      } catch (e) {
        debugPrint('Error resolving location for order $orderId: $e');
        locationNames[orderId] = "Unknown";
      }
    }
  }

  void viewOrderDetails(String orderId, String location) {
    fetchSingleOrder(orderId, location);
  }
}