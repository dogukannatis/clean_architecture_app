
// To convert the response into a non-nullable object.

import 'package:clean_architecture_app/app/extension.dart';
import 'package:clean_architecture_app/data/responses/responses.dart';
import 'package:clean_architecture_app/domain/model.dart' as model;

const empty = "";
const zero = 0;

extension CustomerResponseMapper on CustomerResponse?{
  model.Customer toDomain(){
    return model.Customer(
        this?.id?.orEmpty() ?? empty,
        this?.name?.orEmpty() ?? empty,
        this?.numOfNotifications?.orZero() ?? zero
    );
  }
}

extension ContactResponseMapper on ContactsResponse?{
  model.Contacts toDomain(){
    return model.Contacts(
        this?.email?.orEmpty() ?? empty,
        this?.phone?.orEmpty() ?? empty,
        this?.link?.orEmpty() ?? empty
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  model.Authentication toDomain(){
    return model.Authentication(this?.customer?.toDomain(), this?.contact?.toDomain());
  }
}