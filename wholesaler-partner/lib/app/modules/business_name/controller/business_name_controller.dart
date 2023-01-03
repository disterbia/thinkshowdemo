import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/register_ceo_employee/address.dart';
import 'package:wholesaler_partner/app/modules/page3_my_page/controllers/page3_my_page_controller.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';
import 'dart:convert';

class BusinessInfoController extends GetxController {
  pApiProvider _apiProvider = pApiProvider();
  Page3MyPageController page3MyPageController = Get.put(Page3MyPageController());
  late TextEditingController companyNameController;
  late TextEditingController typeController;
  late TextEditingController ownerNameController;
  late TextEditingController pointController;
  late TextEditingController buildingController;
  late TextEditingController floorController;
  late TextEditingController hosooController;
  late TextEditingController createDateController;

  RxBool isLoading = false.obs;
  RxString companyName = ''.obs;
  RxString type = ''.obs;
  RxString ownerName = ''.obs;
  RxList<dynamic> employee = [].obs;
  RxString point = ''.obs;
  RxString building = ''.obs;
  RxString floor = ''.obs;
  RxString hosoo = ''.obs;
  RxString createDate = ''.obs;
  RxList<Address> buildings = <Address>[].obs;
  RxList<Address> floors = <Address>[].obs;
  RxList<Address> units = <Address>[].obs;

  @override
  void onInit() {
    super.onInit();
    companyNameController = TextEditingController();
    typeController = TextEditingController();
    ownerNameController = TextEditingController();
    pointController = TextEditingController();
    buildingController = TextEditingController();
    floorController = TextEditingController();
    hosooController = TextEditingController();
    createDateController = TextEditingController();
    getCompanyInfo();
  }

  @override
  void dispose() {
    super.dispose();
    companyNameController.dispose();
    typeController.dispose();
    ownerNameController.dispose();
    pointController.dispose();
    buildingController.dispose();
    floorController.dispose();
    hosooController.dispose();
    createDateController.dispose();
  }

  getCompanyInfo() {
    isLoading.value = true;
    _apiProvider.getOwnerInfo().then((StatusModel response) {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.data.toString());
        companyNameController.text = json['business_name'];
        typeController.text = json['is_privilege'];
        ownerNameController.text = json['account_owner_name']??" ";
        employee.value = json['staff_list'];
        pointController.text = json['point'].toString();
        buildingController.text = json['store_building_location_id'].toString();
        floorController.text = json['store_floor_location_id'].toString();
        hosooController.text = json['store_unit_location_id'].toString();
        createDateController.text = json['created_at'];
        companyName.value=json['business_name'];

        json['is_privilege']=="Y"? typeController.text="띵동":"일반";
        getBuildings();
      } else {
        //mSnackbar(message: response.message);
      }

      //isLoading.value = false;
    });
  }

  getBuildings() async {
    buildings.value = await _apiProvider.getStoreLocations(
        buildingType: BuildingType.building);
    getFloors(int.parse(buildingController.text));
    for (var element in buildings) {
      element.id.toString() == buildingController.text
          ? buildingController.text = element.name!.value
          : null;
    }
  }

  getFloors(int buildingId) async {
    floors.value = await _apiProvider.getStoreLocations(
        buildingType: BuildingType.floor, parent_id: buildingId);
    getUnits(int.parse(floorController.text));
    for (var element in floors) {
      element.id.toString() == floorController.text
          ? floorController.text = element.name!.value
          : null;
    }
  }

  getUnits(int floorId) async {
    units.value = await _apiProvider.getStoreLocations(
        buildingType: BuildingType.unit, parent_id: floorId);
    for (var element in units) {
      element.id.toString() == hosooController.text
          ? hosooController.text = element.name!.value
          : null;
    }
    isLoading.value = false;
  }

saveCompanyName() {
  isLoading.value = true;
  _apiProvider.saveCompanyName({
    "business_name":
        companyNameController.text.isEmpty ? companyName.value : companyNameController.text,
  }).then((StatusModel response) {
    if (response.statusCode == 200) {
      //mSnackbar(message: response.message);
      page3MyPageController.getUserInfo();
      Get.back();
    } else {
      //mSnackbar(message: response.message);
    }

    isLoading.value = false;
  });
}
}
