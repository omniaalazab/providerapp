import 'package:flutter/material.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/view/home.dart';

class HousemanDetails extends StatelessWidget {
  HousemanDetails({
    super.key,
    required this.imagePath,
    required this.textHouseMan,
  });
  String imagePath;
  String textHouseMan;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      height: 250,
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image(
                      height: 140,
                      fit: BoxFit.fill,
                      width: 160,
                      image: NetworkImage(
                        imagePath,
                      )))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            textHouseMan,
            style: TextStyleHelper.textStylefontSize15,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Home()));
                  },
                  child: Image.asset("assets/images/Calling.png")),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Home()));
                  },
                  child: Image.asset("assets/images/Message.png")),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Home()));
                  },
                  child: Image.asset(
                    "assets/images/Chat.png",
                    color: Colors.grey,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
