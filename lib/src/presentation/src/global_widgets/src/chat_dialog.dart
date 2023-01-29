import 'package:carzoum/carzoum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatDialog extends StatelessWidget {
  const ChatDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubItemTitle(
                  title: "Select chat option",
                  trailing: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 18.sp,
                    ),
                  ),
                ),
                6.h.ph,
                GestureDetector(
                  child: Text('WhatsApp'),
                  onTap: () async {
                    String number = "+237672367020";
                    String message = "Is this vehicle still available?";
                    String url = 'whatsapp://send?phone=$number&text=$message';

                    Uri uri = Uri.parse(url);

                    await canLaunchUrl(
                      uri,
                    )
                        ? launchUrl(uri)
                        : debugPrint("Can't open whatsapp");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
