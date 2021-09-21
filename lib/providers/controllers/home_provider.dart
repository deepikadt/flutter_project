import 'dart:async';
import 'package:intl/intl.dart';
import 'package:product_hunt_app/models/post_model.dart';
import 'package:product_hunt_app/providers/base/provider_base.dart';
import 'package:product_hunt_app/providers/base/provider_helpers.dart';
import 'package:product_hunt_app/providers/base/provider_response.dart';
import 'package:product_hunt_app/services/api_service/api_services.dart';
import 'package:product_hunt_app/services/app_preferences/app_preference.dart';
import 'package:product_hunt_app/services/db_service/database.dart';
import 'package:product_hunt_app/utils/app_enums.dart';
import 'package:product_hunt_app/utils/app_keys.dart';

class HomeProvider extends ProviderBase {
  final _apiServices = ApiServices();
  final _appDatabaseBase = AppDatabase();
  final _appPreference = AppPreferences();

  HomeProvider() {
    getLatestProducts();
  }

  PostModel _collectionModel;
  PostModel get collectionModel => _collectionModel;

  // current selected date time
  DateTime _currentDate = DateTime.now();
  DateTime get currentDate => _currentDate;

  // date time for filter
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  set setDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  //done button tapped
  bool _saveSelection = false;
  bool get saveSelection => _saveSelection;
  set setSaveSelection(bool done) {
    _saveSelection = done;
    _currentDate = selectedDate;

    // update ui
    notifyListeners();

    // call api to get data based on updated date
    getLatestProducts();
  }

  Future<void> getLatestProducts() async {
    changeState(
      ProviderResponse(
        ProviderState.loading,
        ProviderEvent.fetchLatestCollection,
      ),
    );

    bool saveToDb = await saveToLocalDb();

    final response = await _apiServices.apiRequest(
      ApiRequestType.apiGet,
      ProviderEvent.fetchLatestCollection,
      ApiEndPoints.product,
      authHeader: true,
      queryParams: {
        "day": DateFormat("y-MM-d").format(_currentDate),
      },
    );

    if (response.state == ProviderState.success) {
      _collectionModel = PostModel.fromJson(response.data);
      if (saveToDb) {
        //updating date in preference
        _appPreference.saveTimeStamp(_currentDate.millisecondsSinceEpoch);
        //clear local db
        await _appDatabaseBase.clearData();
        //updating local db for today's product data
        await _appDatabaseBase.addProductData(_collectionModel);
      }
    } else {
      if (!saveToDb) {
        //TO-DO update date in selection bar for today
        _selectedDate =
            DateTime.fromMillisecondsSinceEpoch(_appPreference.lastTimeStamp);
        _currentDate = _selectedDate;
        //fetching data from local db
        _collectionModel = await _appDatabaseBase.fetchProductData();
      }
    }

    changeState(response);
  }

  Future<bool> saveToLocalDb() async {
    int val = _appPreference.lastTimeStamp;

    if (val != null) {
      DateTime todayDate = DateTime.now();
      DateTime date = DateTime.fromMillisecondsSinceEpoch(val);
      if (date.year == todayDate.year &&
          date.month == todayDate.month &&
          date.day == todayDate.day) {
        return false;
      } else {
        return true;
      }
    }

    return true;
  }
}
