import 'package:gas_dash/app/modules/user/order_history/model/order_history_model.dart';
import 'package:get/get.dart';

import '../../../../data/api.dart';
import '../../../../data/base_client.dart';

class OrderHistoryController extends GetxController {
  var orders = <OrderHistoryDatum>[].obs; // Observable list for orders
  var isLoading = true.obs; // Loading state
  var errorMessage = ''.obs; // Error message for failures

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    try {
      isLoading(true);
      errorMessage('');

      final headers = {
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.getRequest(
        api: Api.orderHistory,
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);

      if (jsonResponse != null) {
        final orderHistory = OrderHistoryModel.fromJson(jsonResponse);
        if (orderHistory.success == true && orderHistory.data?.data != null) {
          orders.assignAll(orderHistory.data!.data);
        } else {
          errorMessage('No orders found');
        }
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
