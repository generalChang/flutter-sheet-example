import "package:flutter/material.dart";

class RestaurantCard extends StatelessWidget {
  final String id;
  final String name;
  final Image image;
  final List<String> tags;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final bool isDetail;
  final String? detail;
  const RestaurantCard(
      {Key? key,
      required this.name,
      required this.id,
      required this.tags,
      required this.deliveryFee,
      required this.deliveryTime,
      required this.image,
      required this.ratings,
      required this.ratingsCount,
      required this.isDetail, this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(isDetail ? 0 : 16),
          child: image,
        ),
        SizedBox(height: 16,),
        Padding(padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
            SizedBox(height: 8,),
            Text(tags.join(" · "), style: TextStyle(fontSize: 14),),
            SizedBox(height: 8,),
            Row(
              children: [
                iconText(iconData: Icons.star, text: ratings.toString()),
                renderDot(),
                iconText(iconData: Icons.receipt, text: ratingsCount.toString()),
                renderDot(),
                iconText(iconData: Icons.timelapse_outlined, text: deliveryTime.toString()+"분"),
                renderDot(),
                iconText(iconData: Icons.monetization_on, text: deliveryFee == 0 ? "무료"  : "$deliveryFee원")
              ],
            ),
            if(isDetail && detail != null)
              Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Text(detail!,),)
          ],
        ),)
      ],
    );
  }

  renderDot(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        "·",
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }

  Widget iconText({required IconData iconData, required String text}){
    return Row(
      children: [
        Icon(iconData, color: Colors.orange,),
        SizedBox(width: 8,
        ),
        Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)
      ],
    );
  }
}
