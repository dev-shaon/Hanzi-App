import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tc_mcandy/constants/text_font_style.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/widgets/c_r_button.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/widgets/counter.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/widgets/set_from_field.dart';
import 'package:tc_mcandy/features/celebrity%20side/talent_profile/set_packages/widgets/set_price.dart';
import 'package:tc_mcandy/gen/colors.gen.dart';
import 'package:tc_mcandy/helpers/ui_helpers.dart';

class PackageContainer extends StatefulWidget {
  final TextEditingController price1Controller;
  final TextEditingController price2Controller;
  final TextEditingController price3Controller;
  final TextEditingController packageName1Controller;
  final TextEditingController packageName2Controller;
  final TextEditingController packageName3Controller;
  final TextEditingController offeringDetails1Controller;
  final TextEditingController offeringDetails2Controller;
  final TextEditingController offeringDetails3Controller;
  final ValueChanged<Map<String, dynamic>>? onPackageDataChanged;
  final List<int> initialRevisions;
  final List<int> initialDeliveryDays;
  final List<int?> initialCrValues;
  final List<int?> packageIds;

  const PackageContainer({
    super.key,
    required this.price1Controller,
    required this.price2Controller,
    required this.price3Controller,
    required this.packageName1Controller,
    required this.packageName2Controller,
    required this.packageName3Controller,
    required this.offeringDetails1Controller,
    required this.offeringDetails2Controller,
    required this.offeringDetails3Controller,
    this.onPackageDataChanged,
    this.initialRevisions = const [0, 0, 0],
    this.initialDeliveryDays = const [0, 0, 0],
    this.initialCrValues = const [0, 0, 0],
    this.packageIds = const [null, null, null],
  });

  @override
  State<PackageContainer> createState() => _PackageContainerState();
}

class _PackageContainerState extends State<PackageContainer> {
  int _selectedIndex = 0;
  late List<int> revisions;
  late List<int> deliveryDays;
  late List<int?> crValues;

  @override
  void initState() {
    super.initState();
    revisions = List.from(widget.initialRevisions);
    deliveryDays = List.from(widget.initialDeliveryDays);
    crValues = List.from(widget.initialCrValues);
  }

  void _notifyParent() {
    widget.onPackageDataChanged?.call({
      'packages': [
        {
          'price': widget.price1Controller.text,
          'package_name': widget.packageName1Controller.text,
          'offering_details': widget.offeringDetails1Controller.text,
          'revisions': revisions[0],
          'delivery_days': deliveryDays[0],
          'cr_value': crValues[0],
          'package_id': widget.packageIds[0],
        },
        {
          'price': widget.price2Controller.text,
          'package_name': widget.packageName2Controller.text,
          'offering_details': widget.offeringDetails2Controller.text,
          'revisions': revisions[1],
          'delivery_days': deliveryDays[1],
          'cr_value': crValues[1],
          'package_id': widget.packageIds[1],
        },
        {
          'price': widget.price3Controller.text,
          'package_name': widget.packageName3Controller.text,
          'offering_details': widget.offeringDetails3Controller.text,
          'revisions': revisions[2],
          'delivery_days': deliveryDays[2],
          'cr_value': crValues[2],
          'package_id': widget.packageIds[2],
        },
      ],
    });
  }

  @override
  Widget build(BuildContext context) {
    final priceControllers = [
      widget.price1Controller,
      widget.price2Controller,
      widget.price3Controller,
    ];
    final packageNameControllers = [
      widget.packageName1Controller,
      widget.packageName2Controller,
      widget.packageName3Controller,
    ];
    final offeringControllers = [
      widget.offeringDetails1Controller,
      widget.offeringDetails2Controller,
      widget.offeringDetails3Controller,
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(color: AppColors.cFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(3, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < 2 ? 8.w : 0),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedIndex == index
                              ? AppColors.cFF5C24
                              : AppColors.cADADAD,
                          width: _selectedIndex == index ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SetPrice(
                        hintText: "\$0.00",
                        controller: priceControllers[index],
                        onTap: () => setState(() => _selectedIndex = index),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          UIHelper.verticalSpace(8.h),
          Divider(color: AppColors.cADADAD),
          UIHelper.verticalSpace(30.h),

          SetFromField(
            hintText: 'Package name',
            controller: packageNameControllers[_selectedIndex],
          ),
          UIHelper.verticalSpace(10.h),
          SetFromField(
            hintText: 'What are you offering in this package?',
            controller: offeringControllers[_selectedIndex],
          ),

          UIHelper.verticalSpace(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Revisions",
                style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                  color: AppColors.c303030,
                ),
              ),
              Counter(
                value: revisions[_selectedIndex],
                increment: () {
                  setState(() => revisions[_selectedIndex]++);
                  _notifyParent();
                },
                decrement: () {
                  if (revisions[_selectedIndex] > 0) {
                    setState(() => revisions[_selectedIndex]--);
                    _notifyParent();
                  }
                },
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Divider(color: AppColors.cADADAD),
          UIHelper.verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Days",
                style: TextFontStyle.headline16w500c7C7C7Curbanist.copyWith(
                  color: AppColors.c303030,
                ),
              ),
              Counter(
                value: deliveryDays[_selectedIndex],
                increment: () {
                  setState(() => deliveryDays[_selectedIndex]++);
                  _notifyParent();
                },
                decrement: () {
                  if (deliveryDays[_selectedIndex] > 0) {
                    setState(() => deliveryDays[_selectedIndex]--);
                    _notifyParent();
                  }
                },
              ),
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Divider(color: AppColors.cADADAD),
          UIHelper.verticalSpace(12.h),
          CRButton(
            label: "Edit",
            initialValue: crValues[_selectedIndex],
            onChanged: (value) {
              setState(() => crValues[_selectedIndex] = value);
              _notifyParent();
            },
          ),
        ],
      ),
    );
  }
}
