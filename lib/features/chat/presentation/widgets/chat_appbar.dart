// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:spesochat/app/app.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/constants/colors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    required this.status,
    required this.userName,
    required this.userImage,
    super.key,
  });

  final String status;
  final String userName;
  final String userImage;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            bottom: 10,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: SvgPicture.asset(
                  AppAssets.arrowleftLine2,
                ),
              ),
              const Gap(14),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              child: ClipRRect(
                                child: SvgPicture.asset(
                                  AppAssets.profile,
                                  width: 35,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 0,
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.activeDot,
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextBold(
                                userName,
                                maxLines: 1,
                              ),
                            ),
                            const Gap(2),
                            TextRegular(status),
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      AppAssets.callButtonLight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
