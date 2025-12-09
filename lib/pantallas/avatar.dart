import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://scontent.fmex19-1.fna.fbcdn.net/v/t39.30808-6/476836717_596674446547518_2754319387026559832_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeH4CjctZNMRXuIT3a0bHTFbL-tPtP79qysv60-0_v2rK9-bNcrjr_Ii0UaWFOnATb4dZisKAIdi2qB1Gx9Gupp7&_nc_ohc=SNqpwSkzYNoQ7kNvwFZ9rdP&_nc_oc=AdmXbpFMzgsNOTUmtifjRYcD62X1mrQzf1rfPsduR-EHmfseh-vNevFbwezdWF6zoUdOGYLlUgg9mnbr-pwwnxvQ&_nc_zt=23&_nc_ht=scontent.fmex19-1.fna&_nc_gid=HZSO_m5I8PGUJWnCfF6g5g&oh=00_AfdIlu4E6ipfoOkwe7p6Ko2jdUyaz22BDba2CcblV4XChA&oe=690AF9BD"),
              backgroundColor: Colors.brown,
            ),
          )
        ],
        ),
        body: Center(
          child: CircleAvatar(
            backgroundColor: Colors.amber,
            maxRadius: 110,
            backgroundImage: AssetImage('assets/perfil.jpg'),
          ),
        ),
    );
  }

}