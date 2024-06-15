import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orthotrade/common/widgets/loaders/circular_loader.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/sizes.dart';
import '../../authentication/models/user_model.dart';


class UserController extends GetxController {
  static UserController get instance => Get.find();

  final  localStorage=GetStorage();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final imageUploading=false.obs;
  final profileImageUrl = ''.obs;


  // Finds existing instance available in memory
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    print('--- OnInitcalled -------');
    fetchUserRecord();
    super.onInit();
  }

  /// Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      print('--- fetchUserRecord -------');
      print('-----------------///---------------------');
      final user = await userRepository.fetchUserDetails();
      print('-----------------////\\---------------------');
      print(user.id);
      print(user.firstName);
      localStorage.write('DISCOUNTED PERCENT', user.discountPercent);
      print('DISCOUNTPRICE-->${localStorage.read('DISCOUNTED PERCENT')}');
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    }
    finally {
      profileLoading.value = false;
    }
  }


  ///save user Record from any Registration provider

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //Refresh User Record
      await fetchUserRecord();

      if(user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(
              userCredentials.user!.displayName ?? '');
          final userName = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');


          //Map Data
          final user = UserModel(
              id: userCredentials.user!.uid,
              username: userName,
              email: userCredentials.user!.email ?? '',
              firstName: nameParts[0],
              lastName: nameParts.length > 1
                  ? nameParts.sublist(1).join(' ')
                  : '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? '',
              billingAddress: '',
              shippingAddress: '',
               zipcode: '',
                discountPercent: 0

          );
          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    }

    catch (e) {
      MOLoaders.warningSnackBar(title: 'Data Not Saved',
          message: 'Something went wrong while saving your information, You can re-save your data in your Profile');
    }
  }

  Future<void> uploadUserProfilePicture() async {

    try{
      print('UPLOADING USER PROFILE PICTURE');
      final image= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70,maxHeight: 512,maxWidth: 512);
      if(image!=null)
      {
        imageUploading.value=true;
        //Upload Image
        final imageUrl=await userRepository.uploadImage('Users/Images/Profile/', image);


        // Update user Image Record
        Map<String,dynamic> json={'ProfilePicture':imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture=imageUrl;
        user.refresh();

        MOLoaders.successSnackBar(title: 'Congratulations',message: 'Your Profile Image has been updated!');
      }
    }catch(e)
    {
      MOLoaders.errorSnackBar(title: 'Oh Snap',message: 'Something went wrong $e');

    }
    finally{
      imageUploading.value=false;
    }

  }


  /// Logout Loader Function
  logout() {
    try {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(MOSizes.md),
        title: 'Logout',
        middleText: 'Are you sure you want to Logout?',
        confirm: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: MOSizes.lg),
            child: Text('Confirm'),
          ),
          onPressed: () async {
            onClose();

            /// On Confirmation show any loader until user Logged Out.
            Get.defaultDialog(
              title: '',
              barrierDismissible: false,
              backgroundColor: Colors.transparent,
              content:  const MOCircularLoader(),
            );
            await AuthenticationRepository.instance.logout();
          },
        ),
        cancel: OutlinedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        ),
      );
    } catch (e) {
      MOLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}