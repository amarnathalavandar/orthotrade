import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orthotrade/utils/formatters/formatter.dart';


class UserModel {
  /// Keep those values final which yo don't want to update

  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  String billingAddress;
  String shippingAddress;
  String zipcode;
  int discountPercent;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
    required this.billingAddress,
    required this.shippingAddress,
    required this.zipcode,
    required this.discountPercent
  });

  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => MOFormatter.formatPhoneNumber(phoneNumber);

  String get fullAddress => '$billingAddress - $zipcode';

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";

    return usernameWithPrefix;
  }

  /// Static function to create an empty user model

  static UserModel empty() => UserModel(
      username: '',
      id: '',
      email: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      profilePicture: '',
      billingAddress: '',
      shippingAddress:'',
      zipcode: '',
      discountPercent: 0);

  /// Convert model to JSON structure for storing data into firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'BillingAddress':billingAddress,
      'ShippingAddress':shippingAddress,
      'Zipcode':zipcode
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        billingAddress: data['BillingAddress'] ?? '',
        shippingAddress: data['ShippingAddress'] ?? '',
        zipcode: data['Zipcode'] ?? '',
        discountPercent: data['DiscountPercent'] ?? 0
      );
    } else {
      return UserModel.empty();
    }
  }
}
