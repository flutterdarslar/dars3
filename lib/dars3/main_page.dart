import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Online market",
          style: myTextStyle(),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300,
                      child: Image.network(
                        alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          "https://uzbazar.husanibragimov.uz/media/ProductVariable/30.jpg")),
                ),
              ];
            },
            body: Container(
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                    /// ustunlar soni
                    crossAxisCount: 2,

                    /// qatorlar orasidaga gorizontal bo'shliqni boshqarish
                    mainAxisSpacing: 0.0,

                    /// ustun orasidaga vertikal bo'shliqni boshqarish
                    crossAxisSpacing: 0.0,

                    ///gridview "child"iga default beradigan qiymati(height,width) bor. Shu o'lchamni o'ziga nisbati.
                    ///  height = 100 %,  childAspectRatio = 2 bersak ekrandagi height = 50% bo'ladi.
                    childAspectRatio: 1),
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey, blurRadius: 1, spreadRadius: 1)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                        width: 120,
                        child: Image.network(
                            fit: BoxFit.cover,
                            "https://uzbazar.husanibragimov.uz/media/ProductVariable/11.jpeg"),
                      ),
                      Text(
                        index.toString(),
                        style: myTextStyle(),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  TextStyle myTextStyle() {
    return const TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
  }
}
