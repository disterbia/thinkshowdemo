import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wholesaler_partner/app/constant/enums.dart';
import 'package:wholesaler_partner/app/data/api_provider.dart';
import 'package:wholesaler_partner/app/models/register_ceo_employee/address.dart';
import 'package:wholesaler_partner/app/models/store_location_model.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/controllers/register_ceo_employee_1_controller.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/register_ceo_employee_3_view.dart';
import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/select_store_location_dialog.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

class RegisterCeoEmployee2Controller extends GetxController {
  RegisterCeoEmployee1Controller registerCeoEmployeeCtr =
      Get.put(RegisterCeoEmployee1Controller());
  pApiProvider apiProvider = pApiProvider();
  RxList<Address> buildings = <Address>[].obs;
  RxList<Address> floors = <Address>[].obs;
  RxList<Address> units = <Address>[].obs;

  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController unitController = TextEditingController();

  Rx<Address> selectedBuilding = Address.empty().obs;
  Rx<Address> selectedFloor = Address.empty().obs;
  Rx<Address> selectedUnit = Address.empty().obs;

  RxList<StoreLocation> storeLocations = <StoreLocation>[].obs;
  TextEditingController storeNameController = TextEditingController();

  RxBool isSearchCompanyName = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getBuildings();
  }

  getBuildings() async {
    buildings.value = await apiProvider.getStoreLocations(
        buildingType: BuildingType.building);
  }

  getFloors(int buildingId) async {
    floors.value = await apiProvider.getStoreLocations(
        buildingType: BuildingType.floor, parent_id: buildingId);
    // floors.addAll(response!);
    print(' floors added');
  }

  getUnits(int floorId) async {
    units.value = await apiProvider.getStoreLocations(
        buildingType: BuildingType.unit, parent_id: floorId);
    print(' unit: ${units.value}');
  }

  void nextBtnPressed() {
    if (selectedBuilding.value.id == 0) {
      mSnackbar(message: '건물을 선택해주세요.');
      return;
    }
    if (selectedFloor.value.id == 0) {
      mSnackbar(message: '층을 선택해주세요.'.tr);
      return;
    }
    if (selectedUnit.value.id == 0) {
      mSnackbar(message: '호수를 선택해주세요'.tr);
      return;
    }
    Get.to(() => RegisterCeoEmployeePage3View());
  }

  searchPressed(String searchValue) async {
    if (searchValue.isEmpty) {
      mSnackbar(message: '상호명을 입력해주세요.');
      return;
    }
    storeLocations.value = await apiProvider.getSearchStoreName(searchValue);
    SelectStoreLocationDialog();
  }

  Future<void> storeLocationSelectPressed(int index) async {
    print(' index $index');
    inspect(storeLocations[index]);
    // building
    Address building = Address(
        id: storeLocations[index].buildingInfo!.id!,
        type: BuildingType.building,
        name: storeLocations[index].buildingInfo!.name!.obs);
    selectedBuilding.value = building;
    buildingController.text = building.name!.value;
    // floor
    Address floor = Address(
        id: storeLocations[index].floorInfo!.id!,
        type: BuildingType.floor,
        name: storeLocations[index].floorInfo!.name!.obs,
        parent_id: building.id);
    print(' after Address floor ${floor.name}');
    selectedFloor.value = floor;
    floorController.text = floor.name!.value;
    // unit
    Address unit = Address(
      id: storeLocations[index].unitInfo!.id!,
      type: BuildingType.unit,
      name: storeLocations[index].unitInfo!.name!.obs,
      parent_id: floor.id,
      business_name: storeLocations[index].business_name!,
      store_id: storeLocations[index].id,
    );
    selectedUnit.value = unit;
    unitController.text = unit.name!.value + ' - ' + unit.business_name!;

    isSearchCompanyName.value = true;
  }

  // Drop down 1: building
  buildingDropdownChanged(Address building) async {
    // flush variables
    floors.value = [];
    units.value = [];
    selectedFloor.value = Address.empty();
    selectedUnit.value = Address.empty();

    selectedBuilding.value = building;
    await getFloors(building.id!);
  }

  floorDropdownChanged(Address floor) async {
    // flush variables
    units.value = [];
    selectedUnit.value = Address.empty();

    selectedFloor.value = floor;
    await getUnits(floor.id!);
  }

  unitDropdownChanged(Address unit) {
    selectedUnit.value = unit;
  }

  bool isBuildingSelectable(Address building) {
    // If CEO: user can select buildings without business name. ex: 102호
    // If Staff: user can select buildings WITH business name. ex: 102호 - 네이밋
    late bool isBuildingSelectable;
    if (registerCeoEmployeeCtr.isEmployee.value) {
      // condition 1: if business_name (ex: 네이밋) is not null, then selectable
      if (building.is_entering_store == null ||
          (building.is_entering_store != null && building.is_entering_store!)) {
        isBuildingSelectable = true;
      } else {
        isBuildingSelectable = false;
      }
    } else {
      isBuildingSelectable = building.is_entering_store == null ||
          (building.is_entering_store != null &&
              building.is_entering_store == false);
    }
    return isBuildingSelectable;
  }
}
