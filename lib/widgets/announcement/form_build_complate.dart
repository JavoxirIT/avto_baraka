import 'package:flutter/material.dart';

SafeArea fomBuildComplate(fnc) {
  return SafeArea(
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Ma`lumotlar saqlandi"),
          OutlinedButton(
            child: const Text("E`lon qo`shish"),
            onPressed: () => fnc(),
          )
        ],
      ),
    ),
  );
}
