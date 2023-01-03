// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wholesaler_partner/app/modules/main/view/partner_main_view.dart';
// import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/register_ceo_employee_1_view.dart';
// import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/register_ceo_employee_2_view.dart';
// import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/register_ceo_employee_3_view.dart';
// import 'package:wholesaler_partner/app/modules/register_ceo_employee/views/register_ceo_employee_4_view.dart';
// import 'package:wholesaler_user/app/constants/dimens.dart';
// import 'package:wholesaler_user/app/modules/product_detail/views/Product_detail_view.dart';
// import 'package:wholesaler_user/app/widgets/snackbar.dart';

// class mAppBar extends StatelessWidget with PreferredSizeWidget {
//   final String prevPage;
//   final String title;
//   bool hasHomeBtn;
//   mAppBar({
//     required this.prevPage,
//     required this.title,
//     this.hasHomeBtn = true,
//   });

//   homeBtnBuilder() {
//     if (hasHomeBtn) {
//       return Container(
//         width: 40,
//         height: 40,
//         child: IconButton(
//           onPressed: () {
//             Get.to(() => PartnerMainView());
//           },
//           icon: Image.asset('assets/icons/ic_home.png'),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: MyDimensions.appbarElevation,
//       leadingWidth: 100,
//       leading: Row(
//         children: [
//           // Back button
//           IconButton(
//             onPressed: () {
//               if (prevPage == 'PRODUCT_MGMT') {
//                 mSnackbar(message: 'appbar error');
//               } else if (prevPage == 'HOME') {
//                 Get.to(() => PartnerMainView()); // 0 = 1st tab which is HOME
//               } else if (prevPage == 'MY_PAGE') {
//                 Get.to(() => PartnerMainView()); // 2 = 3rd tab which is MY_PAGE
//               } else if (prevPage == 'LOGIN') {
//                 // TODO implement login page in partner
//               } else if (prevPage == 'REGISTER_CEO_EMPLOYEE_1') {
//                 Get.to(() => RegisterCeoEmployeePage1View());
//               } else if (prevPage == 'REGISTER_CEO_EMPLOYEE_2') {
//                 Get.to(() => RegisterCeoEmployeePage2View());
//               } else if (prevPage == 'REGISTER_CEO_EMPLOYEE_3') {
//                 Get.to(() => RegisterCeoEmployeePage3View());
//               } else if (prevPage == 'REGISTER_CEO_EMPLOYEE_4') {
//                 Get.to(() => RegisterCeoEmployeePage4View());
//               }
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//           ),
//           // Home button
//           homeBtnBuilder(),
//         ],
//       ),
//       title: Text(
//         title,
//         style: TextStyle(color: Colors.black),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }
