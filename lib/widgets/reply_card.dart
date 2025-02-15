import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/reply_model.dart';
import '../utils/type_def.dart';
import 'circle_image.dart';
import 'reply_card_top_bar.dart';

class ReplyCard extends StatelessWidget {
  final ReplyModel reply;
  final bool isAuthCard;
  final DeleteCallBack? callback;
  const ReplyCard({
    required this.reply,
    this.isAuthCard = false,
    this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleImage(
                url: reply.user!.metadata?.image,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Comment top bar
                  ReplyCardTopBar(
                    reply: reply,
                    isAuthCard: isAuthCard,
                    callBack: callback,
                  ),
                  Text(reply.reply!),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: Color(0xff242424),
        )
      ],
    );
  }
}
