import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Terms of use"),
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                color: Color(0xff242424),
              )),
        ),
        body: const SingleChildScrollView(
            child: Column(children: [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Welcome to Twinote These Terms of Use (Terms+) govern your access to and use of our social media app and services. By accessing or using our app, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our app.\n\n1. Eligibility:You must be at least 13 years old to use our app. By using our app, you represent and warrant that you meet this eligibility requirement.\n\n2. Account Registration:To access certain features of our app, you may be required to create an account. You agree to provide accurate, current, and complete information during the registration process and to keep your account information updated.\n\n3. User Content:You retain ownership of any content you post, upload, or share on our app User Content.By posting User Content, you grant us anon-exclusive transferable, sublicensable, royalty-free license to use, reproduce, modify, adapt, publish, translate, distribute, and display such User Content in connection with our app.\n\n4. Prohibited Conduct:\nYou agree not to engage in any of the following prohibited activities:Violating any applicable laws, regulations, or third-party rights.\nImpersonating another person or entity.\nPosting or sharing illegal, harmful, or offensive content.\nHarassing, bullying, or threatening other users.\nInterfering with the operation of our app or disrupting the user experience.\n\n5. Intellectual Property:All content and materials available on our app, including but not limited to text, graphics, logos, images, and software, are the property of [Your Company Name] or its licensors and are protected by intellectual property laws.\n\n6. Third-Party Links:Our app may contain links to third-party websites or services that are not owned or controlled by us. We are not responsible for the content or practices of any third-party websites or services, and your use of such websites or services is at your own risk.\n\n7. Disclaimer of Warranties:Our app is provided on an as+ is andas availablebasis without warranties of any kind, whether express or implied. We do not warrant that our app will be error-free, uninterrupted, secure, or meet your expectations.\n\n8. Limitation of Liability:To the fullest extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of our app.\n\n9. Indemnification:You agree to indemnify and hold harmless [Your Company Name] and its affiliates, officers, directors, employees, and agents from any and all claims, liabilities, damages, losses, costs, expenses, or fees arising out of or relating to your use of our app or violation of these Terms.\n\n10. Changes to Terms:We reserve the right to modify or update these Terms at any time without prior notice. Any changes will be effective immediately upon posting on our app. Your continued use of our app after the posting of revised Terms constitutes your acceptance of such changes.\n\n11. Governing Law:These Terms shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law principles.\n\n12. Contact Us:If you have any questions, concerns, or feedback regarding these Terms, please contact us at mrrajparihar281@gmail.comThank you for using Twinote. We hope you enjoy your experience!")
          ]))
        ])));
  }
}
