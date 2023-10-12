// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spesochat/app/styles.dart/text_styles.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/constants/app_fonts.dart';
import 'package:spesochat/core/constants/colors.dart';
import 'package:spesochat/features/chat/chat.dart';
import 'package:spesochat/features/chat/presentation/provider/chat_provider.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({
    required this.params,
    super.key,
  });

  final ChatScreenViewParams params;

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  List<ChatModels> chatMessages = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, initMessages);
    super.initState();
  }

  Future<void> initMessages() async {
    await context.read<ChatProvider>().getMessage(
          context,
          ChatModels(
            message: '',
            type: ChatModelsModelType.Text,
            senderId: widget.params.senderId,
            recieverId: widget.params.recieverId,
          ),
        );
    setState(() {
      chatMessages = context.read<ChatProvider>().messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages =
        chatMessages.map<types.Message>((e) => e.toMessage()).toList();
    return Scaffold(
      appBar: ChatAppBar(
        status: 'Active',
        userName: widget.params.recieverName,
        userImage: AppAssets.profile,
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          return Chat(
            theme: DefaultChatTheme(
              backgroundColor: AppColors.lightGrey,
              inputBackgroundColor: AppColors.white,
              inputTextColor: AppColors.ash,
              inputBorderRadius: BorderRadius.circular(0),
              inputTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: AppFonts.montserrat,
                color: AppColors.textColor,
              ),
              primaryColor: AppColors.primaryColor,
              secondaryColor: AppColors.lightGrey1,
              receivedMessageBodyTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.montserrat,
              ),
              attachmentButtonIcon: SvgPicture.asset(AppAssets.emoji),
            ),
            showUserAvatars: true,
            showUserNames: true,
            emptyState: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
              ),
              child: Column(
                children: [
                  const Gap(27),
                  TextRegular(
                    'If anything suspicious happens, please report it to us.',
                    textAlign: TextAlign.center,
                  ),
                  const Gap(5),
                  TextBold(
                    'Contact Help Centre.',
                    color: AppColors.primaryColor,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            messages: messages,
            hideBackgroundOnEmojiMessages: false,
            onSendPressed: _handleSendPressed,
            user: types.User(
              id: widget.params.senderId,
              firstName: 'Tester',
              lastName: 'NA',
              imageUrl: 'photo',
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleSendPressed(
    types.PartialText message,
  ) async {
    await context.read<ChatProvider>().sendMessage(
          context,
          ChatModels(
            type: ChatModelsModelType.Text,
            senderId: widget.params.senderId,
            recieverId: widget.params.recieverId,
            message: message.text,
          ),
        );
    await initMessages();
  }
}

class ChatScreenViewParams {
  String recieverId;
  String senderId;
  String recieverName;
  ChatScreenViewParams({
    required this.recieverId,
    required this.senderId,
    required this.recieverName,
  });
}
