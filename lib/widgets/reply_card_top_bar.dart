import 'package:flutter/material.dart';
import '../models/reply_model.dart';

import '../utils/helper.dart';
import '../utils/type_def.dart';

class ReplyCardTopBar extends StatelessWidget {
  final ReplyModel reply;
  final bool isAuthCard;
  final DeleteCallBack? callBack;

  const ReplyCardTopBar(
      {required this.reply, this.isAuthCard = false, this.callBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          reply.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(formateDateFromNow(reply.createdAt!)),
            const SizedBox(
              width: 10,
            ),
            isAuthCard
                ? GestureDetector(
                    onTap: () {
                      confirmBox("Are you sure ?",
                          "Once the comment is deleted you cannot get it back",
                          () {
                        callBack!(reply.id!);
                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : GestureDetector(child: const Icon(Icons.more_horiz))
          ],
        )
      ],
    );
  }
}
