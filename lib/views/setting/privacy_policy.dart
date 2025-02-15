import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy policy"),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Color(0xff242424),
            )),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                text: "At Twinote, we are committed to protecting the privacy and security of our users' personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our social media app.\n\n\nInformation We Collect:\nAccount Information: When you create an account, we collect information such as your username, email address, and password.\n\n\nProfile Information: We may collect additional information you choose to provide, such as your name, profile picture, bio, and other details.\n\n\nUsage Data: We automatically collect information about how you interact with our app, including your posts, comments, likes, messages, and otheractivities.\n\n\nDevice Information: We may collect device-specific information such as your device type, operating system, browser type, and IP address.\n\n\nLocation Information: With your consent, we may collect location data to provide location-based features or services.\n\n\nHow We Use Your Information:\nProvide and Improve Our Services: We use your information to deliver, maintain, and enhance our app's functionality, features, and user experience.\n\n\n\nPersonalization: We may personalize your experience by showing content, ads, or recommendations tailored to your interests, preferences, or location.\n\n\nCommunications: We may send you service-related communications, updates, newsletters, or promotional messages.\n\n\nAnalytics and Research: We use data analytics to analyze app usage, trends, and performance to improve our services and develop new features.\n\nSecurity: We employ measures to protect the security and integrity of user data, including encryption, access controls, and regular security audits.\n\n\nData Sharing and Disclosure:\nThird-Party Service Providers: We may share your information with third-party service providers to assist us in operating, maintaining, or enhancing our app.\n\n\nLegal Compliance: We may disclose your information if required by law, regulation, legal process, or governmental request, or to protect our rights, property, or safety.\n\n\nBusiness Transfers: In the event of a merger, acquisition, or sale of assets, user information may be transferred or disclosed as part of the transaction.\n\n\nYour Choices and Rights:\n\nAccount Settings: You can update or modify your account settings, profile information, and privacy preferences within the app.\n\n\nOpt-Out: You can opt out of receiving promotional communications or disable location tracking through your device settings.\n\n\nData Access and Deletion: You may request access to or deletion of your personal information by contacting us at mrrajparihar281@gmail.com\n\n\nChildren's Privacy:\nOur app is not intended for children under the age of 13. We do not knowingly collect personal information from children without parental consent. If you believe we have inadvertently collected personal information from a child under 13, please contact us to request its deletion.\n\n\nUpdates to this Privacy Policy:\nWe may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will notify you of any material changes by posting the updated Privacy Policy on our website or within the app.\n\n\nContact Us:\n\nIf you have any questions, concerns, or feedback regarding this Privacy Policy or our data practices, please contact us at mrrajparihar281@gmail.com\n\n\nEffective Date: 20/2/2024\n\n\nThank you for using Twinote. Your privacy and trust are important to us.\n",
              )
            ]))
          ],
        ),
      ),
    );
  }
}
