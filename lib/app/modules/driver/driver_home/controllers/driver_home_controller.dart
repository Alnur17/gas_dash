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
  // Reactive list to store the fetched orders
  var assignedOrders = <Data>[].obs;
  var isLoading = false.obs;

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

      final result = await BaseClient.handleResponse(response);

      final assignedOrder = AssignedOrderModel.fromJson(result);

      if (assignedOrder.success == true && assignedOrder.data != null) {
        assignedOrders.value = [assignedOrder.data!];
      } else {
        kSnackBar(
          message: assignedOrder.message ?? 'Failed to fetch orders',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch single order by ID and navigate to details view
  Future<void> fetchSingleOrder(String orderId) async {
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
        // Navigate to DriverOrderDetailsView with the fetched order data
        Get.to(() => DriverOrderDetailsView(orderData: singleOrder.data!));
      } else {
        kSnackBar(
          message: singleOrder.message ?? 'Failed to fetch order details',
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Placeholder for accept order action
  void acceptOrder(String orderId) {
    kSnackBar(
      message: 'Accept order $orderId pressed',
      bgColor: AppColors.primaryColor,
    );
  }

  // Placeholder for view details action
  void viewOrderDetails(String orderId) {
    fetchSingleOrder(orderId); // Call fetchSingleOrder to get details and navigate
  }
}