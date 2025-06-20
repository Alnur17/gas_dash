import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../../auth/login/views/login_view.dart';
import '../../../user/profile/model/my_profile_model.dart';

class DriverProfileController extends GetxController {
  var isLoading = false.obs;
  var driverProfileData = Rxn<Data>();
  var driverProfileImage = Rxn<File>();
  var driverProfileName = ''.obs;
  var email = ''.obs;

  var selectedImage = Rxn<File>();

  @override
  void onInit() {
    getDriverProfile();
    super.onInit();

  }

  ///my Profile
  Future<void> getDriverProfile() async {
    try {
      isLoading.value = true;
      String apiUrl = Api.myProfile;

      debugPrint("Fetching Profile Data...");
      String accessToken = LocalStorage.getData(key: AppConstant.accessToken);
      var headers = {
        'Content-Type': "application/json",
        'Authorization': 'Bearer $accessToken',
      };

      var response = await BaseClient.getRequest(api: apiUrl, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = await BaseClient.handleResponse(response);
        MyProfileModel myProfileModel = MyProfileModel.fromJson(jsonResponse);

        if (myProfileModel.data != null) {
          driverProfileData.value = myProfileModel.data;
          driverProfileName.value =
              myProfileModel.data!.fullname ?? "User Name";
          email.value = myProfileModel.data!.email ?? "example@gmail.com";

        }
      } else {
        kSnackBar(
          message: "Failed to load profile data",
          bgColor: AppColors.orange,
        );
      }
    } catch (e) {
      debugPrint("Error getting profile: $e");
      kSnackBar(
        message: "Error getting profile: $e",
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }

  ///change password
  Future driverChangePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);
      var accessToken = LocalStorage.getData(key: AppConstant.accessToken);
      var map = {
        "oldPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      };

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(
            api: Api.changePassword, body: jsonEncode(map), headers: headers),
      );

      if (responseBody != null) {
        kSnackBar(message: responseBody["message"], bgColor: AppColors.green);
        Get.offAll(() => LoginView());
        isLoading(false);
      } else {
        throw 'reset pass in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

  ///Update profile
  Future<void> updateProfile({
    required String name,
    required String email,
    required String contactNumber,
    required String location,
    required String zipCode,
  })
  async {
    try {
      String accessToken = LocalStorage.getData(key: AppConstant.accessToken);
      if (accessToken.isEmpty) {
        kSnackBar(message: "User not authenticated", bgColor: AppColors.orange);
        return;
      }

      var request =
          http.MultipartRequest('PATCH', Uri.parse(Api.editMyProfile));

      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'multipart/form-data',
      });

      // Add JSON payload as text
      Map<String, dynamic> data = {
        "fullname": name,
        "email": email,
        "phoneNumber": contactNumber,
        'location': location,
        'zipCode': zipCode,
      };

      request.fields['data'] = jsonEncode(data);

      // Handle Image Upload
      if (selectedImage.value != null) {
        String imagePath = selectedImage.value!.path;
        String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imagePath,
            contentType: MediaType.parse(mimeType), //from http_parser package
          ),
        );
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      try {
        var decodedResponse = json.decode(responseData);

        if (response.statusCode == 200) {
          kSnackBar(
              message: "Profile updated successfully",
              bgColor: AppColors.green);

          await getDriverProfile();
          update();
          if (Get.context != null) {
            Navigator.pop(Get.context!);
          }
          //Navigator.pop(context); // sometimes it get some issue
        } else {
          kSnackBar(
            message: decodedResponse['message'] ?? "Failed to update profile",
            bgColor: AppColors.orange,
          );
        }
      } catch (decodeError) {
        kSnackBar(
            message: "Invalid response format", bgColor: AppColors.orange);
        debugPrint("Response Error: $decodeError");
      }
    } catch (e) {
      kSnackBar(
          message: "Error updating profile: $e", bgColor: AppColors.orange);
      debugPrint("Update Error: $e");
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      driverProfileImage.value = selectedImage.value;
      debugPrint("Image Selected: ${pickedFile.path}");
      update();
    }
  }
}
