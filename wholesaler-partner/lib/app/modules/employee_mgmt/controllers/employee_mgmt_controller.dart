import 'package:get/get.dart';
import 'package:wholesaler_user/app/models/status_model.dart';
import 'package:wholesaler_user/app/widgets/snackbar.dart';

import '../../../data/api_provider.dart';
import '../../../models/staff_model.dart';

class EmployeeMgmtController extends GetxController {
  pApiProvider apiProvider = pApiProvider();
  RxBool isLoading = false.obs;
  RxBool isLoadingApprovalRight = false.obs;
  RxBool isLoadingApprovalLeft = false.obs;
  RxBool isLoadingDelete = false.obs;
  List<StaffModel> staffs = [];

  @override
  void onInit() {
    super.onInit();
    getStaffs();
  }

  getStaffs() {
    isLoading.value = true;
    apiProvider.getStaffs().then((response) {
      staffs.clear();
      staffs.addAll(response);
      isLoading.value = false;
    });
  }

  Future<void> setStaffStatus(
      {required String id, required bool isApproval}) async {
    if (isApproval) {
      isLoadingApprovalRight.value = true;
    } else {
      isLoadingApprovalLeft.value = true;
    }
    StatusModel statusModel = await apiProvider
        .setStaffStatus(data: {"is_approval": isApproval}, id: id);

    if (isApproval) {
      isLoadingApprovalRight.value = false;
    } else {
      isLoadingApprovalLeft.value = false;
    }

    Get.back();
   // mSnackbar(message: statusModel.message);
    print(statusModel.statusCode);

    if (statusModel.statusCode == 200) {
      getStaffs();
    }
  }

  Future<void> deleteStaff({required String id}) async {
    isLoadingDelete.value = true;

    StatusModel statusModel = await apiProvider.deleteStaff(id: id);

    isLoadingDelete.value = false;

    mSnackbar(message: statusModel.message);

    if (statusModel.statusCode == 200) {
      getStaffs();
    }
  }
}
