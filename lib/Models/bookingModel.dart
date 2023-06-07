import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  DateTime? bookingStart;
  DateTime? bookingEnd;
  DateTime? timeOfBooking;
  String? bookingId;
  String? callDuration;
  bool? isTrial;
  String? callType;
  String? userId;
  String? nickname;
  String? phoneNumber;
  String? age;
  String? gender;
  String? city;
  String? userType;

  BookingModel({
    this.bookingStart,
    this.bookingEnd,
    this.timeOfBooking,
    this.bookingId,
    this.callDuration,
    this.isTrial,
    this.callType,
    this.userId,
    this.nickname,
    this.phoneNumber,
    this.age,
    this.gender,
    this.city,
    this.userType,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingStart: (json['bookingStart'] as Timestamp).toDate(),
      bookingEnd: (json['bookingEnd'] as Timestamp).toDate(),
      timeOfBooking: (json['timeOfBooking'] as Timestamp).toDate(),
      bookingId: json['bookingId'] ?? '',
      callDuration: json['callDuration'] ?? '',
      isTrial: json['isTrial'] ?? false,
      callType: json['callType'] ?? '',
      userId: json['userId'] ?? '',
      nickname: json['nickname'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      city: json['city'] ?? '',
      userType: json['userType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingStart': bookingStart,
      'bookingEnd': bookingEnd,
      'timeOfBooking': timeOfBooking,
      'bookingId': bookingId,
      'callDuration': callDuration,
      'isTrial': isTrial,
      'callType': callType,
      'userId': userId,
      'nickname': nickname,
      'phoneNumber': phoneNumber,
      'age': age,
      'gender': gender,
      'city': city,
      'userType': userType,
    };
  }

  fromJson(Map<String, dynamic> map) {
    return {
      'bookingStart': bookingStart,
      'bookingEnd': bookingEnd,
      'timeOfBooking': timeOfBooking,
      'bookingId': bookingId,
      'callDuration': callDuration,
      'isTrial': isTrial,
      'callType': callType,
      'userId': userId,
      'nickname': nickname,
      'phoneNumber': phoneNumber,
      'age': age,
      'gender': gender,
      'city': city,
      'userType': userType,
    };
  }
}
