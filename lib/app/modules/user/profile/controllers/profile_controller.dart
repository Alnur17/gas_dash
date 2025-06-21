import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mime/mime.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../../auth/login/views/login_view.dart';
import '../model/my_profile_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var myProfileData = Rxn<Data>();
  var myProfileImage = Rxn<File>();
  var myProfileName = ''.obs;
  var email = ''.obs;
  var selectedImage = Rxn<File>();


  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isPasswordVisible2 = false.obs;


  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.toggle();
  }

  void togglePasswordVisibility2() {
    isPasswordVisible2.toggle();
  }


  @override
  void onInit() {
    super.onInit();
    getMyProfile();
  }

  ///my Profile
  Future<void> getMyProfile() async {
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
          myProfileData.value = myProfileModel.data;
          myProfileName.value = myProfileModel.data!.fullname ?? "User Name";
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
  Future changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);

      if (currentPassword.trim().length < 6) {
        Get.snackbar('Error', 'Password must be at least 6 characters');
        return;
      }

      if (newPassword.trim().length < 6) {
        Get.snackbar('Error', ' New Password must be at least 6 characters');
        return;
      }

      if (confirmPassword.trim().length < 6) {
        Get.snackbar('Error', ' Re-type New Password must be at least 6 characters');
        return;
      }

      var map = {
        "oldPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      };

      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${LocalStorage.getData(key: AppConstant.accessToken)}',
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
  Future<void> updateProfileForFamily({
    required BuildContext context,
    required String name,
    required String email,
  })
  async {
    try {
      String accessToken = LocalStorage.getData(key: AppConstant.accessToken);
      if (accessToken.isEmpty) {
        kSnackBar(message: "User not authenticated", bgColor: AppColors.orange);
        return;
      }
      var map = {
        "familyMember": {
          "name": name,
          "email": email,
        }
      };
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
        'Bearer ${LocalStorage.getData(key: AppConstant.accessToken)}',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(
            api: Api.editMyProfile, body: jsonEncode(map), headers: headers),
      );
      if (responseBody != null) {
        kSnackBar(message: responseBody["message"], bgColor: AppColors.green);
        getMyProfile();
       Navigator.pop(context);
        isLoading(false);
      } else {
        throw 'reset pass in Failed!';
      }

    } catch (e) {
      kSnackBar(
          message: "Error updating profile: $e", bgColor: AppColors.orange);
      debugPrint("Update Error: $e");
    }
  }

  Future<void> updateProfile({
    //required BuildContext context,
    required String name,
    required String email,
    required String contactNumber,
    required String location,
    required String zipCode,
  }) async {
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

          getMyProfile();
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
      myProfileImage.value = selectedImage.value;
      debugPrint("Image Selected: ${pickedFile.path}");
      update();
    }
  }


}
