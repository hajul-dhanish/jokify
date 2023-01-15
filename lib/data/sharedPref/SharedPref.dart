import 'package:q2smart/view/flutter_flow/flutter_flow_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

// -------------------
class UserSharedPreferences {
  static SharedPreferences? _prefs;
  // UserSharedPreferences();

  Future<void> initSharedPreferences() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> saveLocalDB(
      {required String key, required List<dynamic> value}) async {
    await initSharedPreferences();
    _prefs?.setString(key, jsonEncode(value));
  }

  Future<List> getLocalDBData({required String key}) async {
    try {
      await initSharedPreferences();
      String? encodeJson = _prefs?.getString(key);
      if (encodeJson == null) {
        return [];
      }
      List<dynamic> data = jsonDecode(encodeJson);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetSharedPreferencess() async {
    try {
      await initSharedPreferences();
      _prefs?.clear();
    } catch (e) {
      rethrow;
    }
  }
}

// -------------------


// class UserSharedPreferences {
//   // Initialization
//   static SharedPreferences? _preferences;

//   // Declaration
//   // ---Add To Cart Declaration---
//   static const spPk_Id = 'Pk_Id';
//   static const spCategory = 'Category';
//   static const spBrand = 'Brand';
//   static const spModel = 'Model';
//   static const spStartingPrice = 'StartingPrice';
//   static const spCurrentPrice = 'CurrentPrice';
//   static const spImagePath = 'ImagePath';
//   static const spMileage = 'Mileage';
//   static const spDealer = 'Dealer';
//   static const spPlannerCode = 'Plcode';
//   static const spVariant = 'Variant';
//   static const spQuantity = 'Quantity';
//   static const spSavelater = 'Savelater';
//   static const spSaveMaxQuantitylater = 'MaxQuantity';
//   static const spSMoffervalue = 'SMoffervalue';
//   static const spSMsaleprice = 'SMsaleprice';
//   static const spSMstartprice = 'SMstartprice';
//   static const spVehType = 'VehType';
//   static const spStockmultiplier = 'Stockmultiplier';
//   static const spadditionaldiscountflag = 'additionaldiscountflag';
//   static const spextradiscount = 'extradiscount';
//   static const spremainingcount = 'remainingcount';
//   static const spdisplayremarks = 'displayremarks';
//   static const spStock = 'Stock';
//   static const spDisplayOrder = 'DisplayOrder';
//   static const spCartVisibility = 'CartVisibility';

//   static Future init() async {
//     _preferences = await SharedPreferences.getInstance();
//   }


//   // Add To The Cart Item Setter
//   static Future setAddtoCart() async {
//     await _preferences!.setString(spBrand, SharedPrefVar().Brand);
//     await _preferences!
//         .setString(spCartVisibility, SharedPrefVar().CartVisibility);
//     await _preferences!.setString(spCategory, SharedPrefVar().Category);
//     await _preferences!.setString(spCurrentPrice, SharedPrefVar().CurrentPrice);
//     await _preferences!.setString(spDealer, SharedPrefVar().Dealer);
//     await _preferences!.setString(spDisplayOrder, SharedPrefVar().DisplayOrder);
//     await _preferences!.setString(spImagePath, SharedPrefVar().ImagePath);
//     await _preferences!.setString(spMileage, SharedPrefVar().Mileage);
//     await _preferences!.setString(spModel, SharedPrefVar().Model);
//     await _preferences!.setString(spPk_Id, SharedPrefVar().Pk_Id);
//     await _preferences!.setString(spPlannerCode, SharedPrefVar().Pk_Id);
//     await _preferences!.setString(spQuantity, SharedPrefVar().Quantity);
//     await _preferences!.setString(spSMoffervalue, SharedPrefVar().SMoffervalue);
//     await _preferences!.setString(spSMsaleprice, SharedPrefVar().SMsaleprice);
//     await _preferences!.setString(
//         spSaveMaxQuantitylater, SharedPrefVar().SaveMaxQuantitylater);
//     await _preferences!.setString(spSavelater, SharedPrefVar().Savelater);
//     await _preferences!
//         .setString(spStartingPrice, SharedPrefVar().StartingPrice);
//     await _preferences!.setString(spStock, SharedPrefVar().Stock);
//     await _preferences!.setString(spVariant, SharedPrefVar().Variant);
//     await _preferences!.setString(spVehType, SharedPrefVar().VehType);
//     await _preferences!.setString(
//         spadditionaldiscountflag, SharedPrefVar().additionaldiscountflag);
//     await _preferences!
//         .setString(spdisplayremarks, SharedPrefVar().displayremarks);
//     await _preferences!
//         .setString(spextradiscount, SharedPrefVar().extradiscount);
//     await _preferences!
//         .setString(spremainingcount, SharedPrefVar().remainingcount);
//   }

//   // Add To The Cart Item Getter
//   static Future getAddtoCart() async {
//     await _preferences!.getString(spBrand);
//     await _preferences!.getString(spCartVisibility);
//     await _preferences!.getString(spCategory);
//     await _preferences!.getString(spCurrentPrice);
//     await _preferences!.getString(spDealer);
//     await _preferences!.getString(spDisplayOrder);
//     await _preferences!.getString(spImagePath);
//     await _preferences!.getString(spMileage);
//     await _preferences!.getString(spModel);
//     await _preferences!.getString(spPk_Id);
//     await _preferences!.getString(spPlannerCode);
//     await _preferences!.getString(spQuantity);
//     await _preferences!.getString(spSMoffervalue);
//     await _preferences!.getString(spSMsaleprice);
//     await _preferences!.getString(spSaveMaxQuantitylater);
//     await _preferences!.getString(spSavelater);
//     await _preferences!.getString(spStartingPrice);
//     await _preferences!.getString(spStock);
//     await _preferences!.getString(spVariant);
//     await _preferences!.getString(spVehType);
//     await _preferences!.getString(spadditionaldiscountflag);
//     await _preferences!.getString(spdisplayremarks);
//     await _preferences!.getString(spextradiscount);
//     await _preferences!.getString(spremainingcount);
//   }
// }
