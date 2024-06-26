import 'package:flutter/material.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamInfoPage extends StatelessWidget {
  // List of team members (name, image, social links)
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Esraa Ehab',
      image: 'assets/Images/esraa.png',
      linkedIn: 'https://www.linkedin.com/in/esraa-syam17/',
      github: 'https://github.com/EsraaSyam',
      email: 'esraasyam15@gmail.com',
    ),
    TeamMember(
      name: 'Shorok Atwa',
      image: 'assets/Images/shorok.png',
      linkedIn: 'https://www.linkedin.com/in/shorokatwa14',
      github: 'https://github.com/shorokatwa14',
      email: 'shorokrashid14@gmail.com',
    ),
    TeamMember(
      name: 'Radwa Nagy',
      image: 'assets/Images/radwa.png',
      linkedIn:
          'https://www.linkedin.com/in/radwa-nagy-3020ab254?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app',
      github: 'https://github.com/RadwaNagy44',
      email: 'radwanagy561@gmail.com',
    ),
    TeamMember(
      name: 'Gehad Ahmed',
      image: 'assets/Images/gehad.png',
      linkedIn:
          'https://www.linkedin.com/in/gehad-shalaby-7aa3b5250?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app',
      github: 'https://github.com/Gehad555',
      email: 'gehadshalaby66@gmail.com',
    ),
    TeamMember(
      name: 'Kholoud Osama',
      image: 'assets/Images/khoulod.png',
      linkedIn:
          'https://www.linkedin.com/in/kholoud-osama-176a99240?trk=contact-info',
      github: 'https://github.com/KhouloodOsama',
      email: '',
    ),
    TeamMember(
      name: 'Alaa shokry',
      image: 'assets/Images/alla.png',
      linkedIn: 'https://www.linkedin.com/in/alaa-shokry/',
      github: 'https://github.com/AlaaShokry76',
      email: 'alaa.shokry760@gmail.com',
    ),
    TeamMember(
      name: 'Sherry ahmos',
      image: 'assets/Images/sherry.png',
      linkedIn:
          'https://www.linkedin.com/in/sherry-ahmos-413a02222/?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      github: 'https://github.com/sherryahmos473',
      email: 'sherry.ahmos@gmail.com',
    ),
    TeamMember(
      name: 'Abdelffatah',
      image: 'assets/Images/abdo.png',
      linkedIn:
          'https://www.linkedin.com/in/abdelfatah-mohammed-554205282?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      github: 'https://github.com/AbdelfatahMohammed',
      email: 'abdelfatahmoha575@gmail.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "معلومات عنا",
      ),
      endDrawer: CustomEndDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'نهتم بكل ما يخص صحتك',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'استجابةً للحاجة المتزايدة للرعاية الصحية المجتمعية الشاملة، يسعى مشروعنا إلى توفير منصة سهلة الاستخدام. تمكّن هذه المنصة الأفراد من جميع الأعمار من إدارة صحتهم بشكل استباقي، حيث توفر ميزات مثل تتبع التطعيمات ومراقبة الصحة وتحديد الاستعدادات الوراثية والتواصل السلس مع المستشفيات. بالإضافة إلى ذلك، يتوفر روبوت دردشة مخصص للإجابة على الاستفسارات الطبية للمستخدمين.',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'هدفنا',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xff28CC9E),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'يهدف مشروعنا إلى إحداث ثورة في إمكانية الوصول إلى الرعاية الصحية من خلال تقديم نهج شامل. من خلال تسهيل إدارة الصحة الشخصية من خلال الميزات المتقدمة، نسعى إلى تمكين الأفراد من تولي مسؤولية رفاههم بغض النظر عن العمر.',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'فريق العمل',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15.0),
            _buildTeamMembersGrid(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTeamMembersGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8,
      ),
      itemCount: teamMembers.length,
      itemBuilder: (context, index) {
        return _buildTeamMemberInfo(teamMembers[index]);
      },
    );
  }

  Widget _buildTeamMemberInfo(TeamMember member) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 50.0,
          backgroundImage: AssetImage(member.image),
        ),
        const SizedBox(height: 10.0),
        Text(
          member.name,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImageIcon('assets/Images/linkedin.png', () {
              _launchURL(member.linkedIn);
            }),
            _buildImageIcon('assets/Images/github.png', () {
              _launchURL(member.github);
            }),
            _buildImageIcon('assets/Images/email logo.png', () {
              _launchEmail(member.email);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildImageIcon(String imagePath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath,
          width: 20.0,
          height: 20.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class TeamMember {
  final String name;
  final String image;
  final String linkedIn;
  final String github;
  final String email;

  TeamMember({
    required this.name,
    required this.image,
    required this.linkedIn,
    required this.github,
    required this.email,
  });
}
