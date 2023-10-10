import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:spesochat/app/styles.dart/styles.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/constants/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: HeaderText('Friends'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextRegular(
                      'Logout',
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: ListView(
          children: [
            const Gap(30),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppAssets.userIcon,
                    height: 50,
                    width: 50,
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRegular(
                        'John Francas',
                        fontWeight: FontWeight.w500,
                      ),
                      TextRegular(
                        'John@gmail.com',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  HeaderText(
                    '28 Jan',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppAssets.userIcon,
                    height: 50,
                    width: 50,
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRegular(
                        'John Francas',
                        fontWeight: FontWeight.w500,
                      ),
                      TextRegular(
                        'John@gmail.com',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  HeaderText(
                    '28 Jan',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppAssets.userIcon,
                    height: 50,
                    width: 50,
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRegular(
                        'John Francas',
                        fontWeight: FontWeight.w500,
                      ),
                      TextRegular(
                        'John@gmail.com',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  HeaderText(
                    '28 Jan',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppAssets.userIcon,
                    height: 50,
                    width: 50,
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextRegular(
                        'John Francas',
                        fontWeight: FontWeight.w500,
                      ),
                      TextRegular(
                        'John@gmail.com',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  HeaderText(
                    '28 Jan',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}