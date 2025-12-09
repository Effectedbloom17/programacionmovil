import 'package:flutter/material.dart';
import 'package:flutter_application_2/pantallas/pantallas.dart';
import 'package:flutter_application_2/theme/tema.dart';

class CardV extends StatelessWidget {
  const CardV({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cardviews")),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          Tarjeta1(),
          SizedBox(height: 15),
          Tarjeta2(
            imgUrl:
                "https://scontent-hou1-1.xx.fbcdn.net/v/t39.30808-6/487326013_627692753445687_7374565234547800140_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeH5hurQGkNEfLZn-9UMofnLKaKU89JwBKkpopTz0nAEqfW5YwSuhiLEhAfPDxzQd2vegex1j4xYjtjYIyp5f9Fo&_nc_ohc=SrO2R6g5ngsQ7kNvwH03m9M&_nc_oc=AdmDMP-oHyeaNpqgq5umhaNvGjv97Wc8fAlZYUqKQBSeqhhTJhOoVkEZiNUtik3jU6E&_nc_zt=23&_nc_ht=scontent-hou1-1.xx&_nc_gid=OVV1VF2LaOUU6_ue140-Mw&oh=00_Aff9DwnShOA828cqnbIvpF1VLModcwva1LLVCLjDy0gFDw&oe=6906CD54",
            texto: "texto1",
          ),
          SizedBox(height: 15),
          Tarjeta2(
            imgUrl:
                "https://scontent-hou1-1.xx.fbcdn.net/v/t39.30808-6/465004785_530789326469364_8647010009749887797_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeF0HTF7LjJ0MpAo42H7Hiyp0qlS9zCj6ADSqVL3MKPoAClzONxuLno4QOxbKWsxkw4jdHur7auyOYgQedB1xe5w&_nc_ohc=pYstxwvuq8UQ7kNvwFof8hw&_nc_oc=AdmNWWd4qxBrG-cV1peX372dRY2XK2AxXJTAzJOIQLkJCI5dDbyfW417pr_7Yv2KDok&_nc_zt=23&_nc_ht=scontent-hou1-1.xx&_nc_gid=W0nitW7ckD3Pta_4i54xLg&oh=00_Afd9EhFD-t1jwhxquE6Uuf4K_Ci_yLkGFetLsiEye5YmOQ&oe=6906E6C3",
            texto: "texto2",
          ),
          SizedBox(height: 15),
          Tarjeta2(
            imgUrl:
                "https://scontent-hou1-1.xx.fbcdn.net/v/t39.30808-6/476798793_596692273212402_2369919639368528185_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeEU6rA7o8JfQXAR4I0v0tpvzu-ewArfQzLO757ACt9DMqaUIW7be5aoHzGkjL3kkFh2_f4wyPaKHhZJHuscvXGX&_nc_ohc=RmPN6of0wLEQ7kNvwHDec6I&_nc_oc=AdlB6QkxsSIc4rNW6O6Pvs45g_SuYugApNs5brpeyDN99tC8BFA9WTpAaTOms6e068I&_nc_zt=23&_nc_ht=scontent-hou1-1.xx&_nc_gid=UaUkJef5sokaPbJrd-TFhQ&oh=00_AfdeRpjfO9vZPfigDV1QvQO_YkLTXUE1dXFqXLQ6WNM1-w&oe=6906BBBB",
          ),
        ],
      ),
    );
  }
}

class card1 extends StatelessWidget {
  const card1({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.add_comment_rounded, color: Tema.primary),
            title: Text("Esta es una tarjeta"),
            subtitle: Text("Esto es un subtítulo para la tarjeta"),
          ),
        ],
      ),
    );
  }
}
