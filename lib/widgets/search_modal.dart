import 'package:flutter/material.dart';

Future<dynamic> searchModal(
    BuildContext context, SizedBox sizeBox20, RoundedRectangleBorder shape) {
  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height - 100.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Kerakli e`lonni qidirish",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          sizeBox20,
          ListTile(
            title: Text(
              "Hududni tanlang",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey[100],
            ),
            shape: shape,
            tileColor: Colors.black12,
          ),
          sizeBox20,
          ListTile(
            title: Text(
              "Modelni tanlang",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey[100],
            ),
            shape: shape,
            tileColor: Colors.black12,
          ),
          sizeBox20,
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Ishlab chiqarilgan yili",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text("yil dan"),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text("yil gacha"),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Narxi",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(),
              )
            ],
          )
        ],
      ),
    ),
  );
}
