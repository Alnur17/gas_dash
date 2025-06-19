import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../../driver/driver_home/model/single_order_by_id_model.dart';
import '../model/order_history_model.dart';
import '../views/order_details_view.dart';

class OrderHistoryController extends GetxController {
  var orders = <OrderHistoryDatum>[].obs; // Observable list for orders
  var inProcessOrders = <OrderHistoryDatum>[].obs; // Observable list for orders
  var isLoading = true.obs; // Loading state
  var errorMessage = ''.obs; // Error message for failures
  var singleOrder = Rx<SingleOrderByIdModel?>(null); // Observable for single order

  @override
  void onInit() {
    fetchOrderHistory();
    super.onInit();

  }

  Future<void> fetchOrderHistory() async {
    try {
      isLoading(true);
      errorMessage('');
      String accessToken = LocalStorage.getData(key: AppConstant.accessToken);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await BaseClient.getRequest(
        api: Api.orderHistory,
        headers: headers,
      );
      debugPrint('OrderHistory Response: ${response.body}');

      final jsonResponse = await BaseClient.handleResponse(response);
      debugPrint('OrderHistory JSON: $jsonResponse');

      if (jsonResponse is Map<String, dynamic>) {
        final orderHistory = OrderHistoryModel.fromJson(jsonResponse);
        if (orderHistory.success == true && orderHistory.data?.data != null) {
          orders.assignAll(orderHistory.data!.data);
          inProcessOrders.assignAll(
              orderHistory.data!.data.where((e) => e.orderStatus.toString() == "InProgress").toList()
          );

        } else {
          errorMessage('No orders found');
        }
      } else {
        errorMessage('Invalid response format: Expected Map<String, dynamic>, got ${jsonResponse.runtimeType}');
      }
    } catch (e) {
      errorMessage('Failed to fetch order history: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSingleOrder(String orderId,amount) async {
    try {
      isLoading.value = true;
      errorMessage('');

      final String token = LocalStorage.getData(key: AppConstant.accessToken) ?? '';
      if (token.isEmpty) {
        throw Exception('No access token found');
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      debugPrint('Fetching order with ID: $orderId');
      final apiUrl = Api.singleOrderById(orderId);
      debugPrint('API URL: $apiUrl');

      if (apiUrl is! String) {
        throw Exception('Api.singleOrderById returned non-string value: $apiUrl (type: ${apiUrl.runtimeType})');
      }

      final response = await BaseClient.getRequest(
        api: apiUrl,
        headers: headers,
      );
      debugPrint('SingleOrder Response: ${response.body}');

      final jsonResponse = await BaseClient.handleResponse(response);
      debugPrint('SingleOrder JSON: $jsonResponse');

      if (jsonResponse is Map<String, dynamic>) {
        final singleOrderData = SingleOrderByIdModel.fromJson(jsonResponse);
        if (singleOrderData.success == true && singleOrderData.data != null) {
          singleOrder.value = singleOrderData;
          Get.to(() =>  OrderDetailsView(amount));
        } else {
          kSnackBar(
            message: singleOrderData.message ?? 'Failed to fetch order details',
            bgColor: AppColors.orange,
          );
        }
      } else {
        throw Exception('Expected Map<String, dynamic> but got ${jsonResponse.runtimeType}');
      }
    } catch (e) {
      debugPrint('Error in getSingleOrder: $e');
      kSnackBar(
        message: 'Failed to fetch order details: $e',
        bgColor: AppColors.orange,
      );
      errorMessage('Failed to fetch order details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}