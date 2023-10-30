part of 'customerBillingAddress.dart';


CustomerBillingAddress _$BillingAddressFromJson(Map<String, dynamic> json) =>
    CustomerBillingAddress(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      //company: json['company'] as String,
      address1: json['address_1'] as String,
      address2: json['address_2'] as String,
      city: json['city'] as String,
      postcode: json['postcode'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$BillingAddressToJson(CustomerBillingAddress instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      //'company': instance.company,
      'address_1': instance.address1,
      'address_2': instance.address2,
      'city': instance.city,
      'postcode': instance.postcode,
      'country': instance.country,
      'state': instance.state,
      'email': instance.email,
      'phone': instance.phone,
    };
