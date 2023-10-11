import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:provider/provider.dart';
import 'package:spesochat/app/styles.dart/styles.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/constants/colors.dart';
import 'package:spesochat/core/core.dart';
import 'package:spesochat/features/auth/presentation/provider/auth_provider.dart';
import 'package:spesochat/features/features.dart';
import 'package:spesochat/features/home/presentation/provider/home_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.params, super.key});
  final HomeViewParams params;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _handleFriends(int currentUser) async {
    await Provider.of<HomeProvider>(context, listen: false)
        .getFriends(FriendsModel(id: currentUser));
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _handleFriends(
        widget.params.id,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            HeaderText(
              'Hello ',
              fontSize: 20,
            ),
            HeaderText(
              StringUtils.getFirstName(widget.params.username),
              fontSize: 20,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22),
            child: GestureDetector(
              onTap: () {
                context.read<AuthProvider>().logout(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextRegular(
                    'Logout',
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
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
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
              child: homeProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 3,
                      ),
                    )
                  : homeProvider.isLoading == false &&
                          homeProvider.availableData.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeaderText(
                                'Opps Sorry',
                                fontSize: 15,
                              ),
                              const Gap(5),
                              TextRegular(
                                "There are no friends to chat currently, When you create friends below, They'll all appear here ",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: homeProvider.availableData.length,
                          itemBuilder: (context, index) {
                            final item = homeProvider.availableData[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 30,
                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextRegular(
                                        item.username.toString(),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(
                                        width: screenWidth(context) / 2,
                                        child: TextRegular(
                                          item.emailAddress.toString(),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () async {
                                      await homeProvider
                                          .deleteFriends(
                                        item.id!,
                                        widget.params.id,
                                      )
                                          .then((value) {
                                        // Logger().d(value);
                                        value
                                            ? FlushBarNotification.showSuccess(
                                                context: context,
                                                message:
                                                    'User Deleted Successfully',
                                              )
                                            : FlushBarNotification.showError(
                                                context: context,
                                                message: 'Somethng went Wrong',
                                              );
                                      });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: AppColors.kDanger,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          );
        },
      ),
    );
  }
}

class HomeViewParams {
  HomeViewParams({required this.id, required this.username});

  final String username;
  final int id;
}
