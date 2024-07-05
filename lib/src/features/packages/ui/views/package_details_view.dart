import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/features/packages/cubit/packages_cubit.dart';
import 'package:jetboard/src/features/packages/ui/views/add_package_details.dart';
import 'package:jetboard/src/features/packages/ui/views/view_package_details.dart';

class PackageDetailsView extends StatefulWidget {
  final PackagesCubit cubit;
  final int packageId;
  final bool isAdd;

  const PackageDetailsView({
    required this.cubit,
    required this.packageId,
    required this.isAdd,
    super.key,
  });

  @override
  State<PackageDetailsView> createState() => _PackageDetailsViewState();
}

class _PackageDetailsViewState extends State<PackageDetailsView> {
  void _showDetails() {
    showDialog(
      context: NavigationService.context,
      builder: (context) {
        return ViewPackageDetails(
          cubit: widget.cubit,
          packageDetails: widget.cubit.packageDetails!,
        );
      },
    );
  }

  void _addDetails() {
    showDialog(
      context: NavigationService.context,
      builder: (context) {
        return AddPackageDetails(
          cubit: widget.cubit,
          packageId: widget.packageId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (widget.isAdd) {
          _addDetails();
        } else {
          widget.cubit.getPackageDetails(
            id: widget.packageId,
            afterSuccess: () {
              _showDetails();
            },
          );
        }
      },
      icon: Icon(
        widget.isAdd ? Icons.add : Icons.remove_red_eye,
        color: AppColors.grey,
      ),
    );
  }
}
