import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:get/get.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../model/notifications_model.dart'; // Adjust path to NotificationsModel

class DriverNotificationsController extends GetxController {
  final notifications = <Datum>[].obs;
  final isLoading = false.obs;
  final page = 1.obs;
  final limit = 10;
  final hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {

      var token = LocalStorage.getData(key: AppConstant.accessToken);

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var params = {
        'page': page.value.toString(),
        'limit': limit.toString(),
      };

      final response = await BaseClient.getRequest(
        api: Api.notifications,
        params: params,
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);
      final notificationsModel = NotificationsModel.fromJson(jsonResponse);

      if (notificationsModel.data.isEmpty || notificationsModel.meta?.totalPage == page.value) {
        hasMore.value = false;
      }
      notifications.addAll(notificationsModel.data);
      page.value++;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNotifications() async {
    notifications.clear();
    page.value = 1;
    hasMore.value = true;
    await fetchNotifications();
  }
}