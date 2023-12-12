import 'dart:developer';

import 'package:dars3/model/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() => runApp(const MaterialApp(
    // home: MainPage()

    home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var dio = Dio();

  List<ModelUser> listModelUser = [];
  late ModelUser modelUser;
  bool boolDataLoading = false;

  Future<List<ModelUser>> getDataInternet() async {
    try {
      Response response = await dio.post(
        "https://jsonplaceholder.typicode.com/posts",
      );
      modelUser = ModelUser.fromJson(response.data);
      log("serverdan ma'lumot => ${modelUser.id}");
      // boolDataLoading = true;
      listModelUser =
          (response.data as List).map((e) => ModelUser.fromJson(e)).toList();
      return listModelUser;
    } on DioException catch (e) {
      log(e.toString());
      return [];
    }
  }

  void doNothing(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              /// Xatolikni topib to'girlang
              MaterialButton(
                onPressed: () async {
                  boolDataLoading = false;
                  await getDataInternet();
                  boolDataLoading = true;
                  setState(() {});
                },
                color: Colors.blue,
                child: const Text("Get data 'post'"),
              ),

              /// get so'rov orqali listni to'ldiring
              MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                child: const Text("Get data 'Get'"),
              ),

              /// linkni o'zgartirib(xato yozib) 404 xatoligini markazga chiqaring
              MaterialButton(
                onPressed: () async {
                  boolDataLoading = false;
                  await getDataInternet();
                  boolDataLoading = true;
                  setState(() {});
                },
                color: Colors.blue,
                child: const Text("Get error '404'"),
              ),
            ],
          )),
          boolDataLoading
              ? SizedBox(
                  height: 200,
                  child: listModelUser.isEmpty
                      ? Center(
                          child: Text(modelUser.id.toString(),
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black)),
                        )
                      : ListView.builder(
                          itemCount: listModelUser.length,
                          itemBuilder: (context, index) => Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: const ValueKey(0),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: const Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.share,
                                  label: 'Share',
                                ),
                              ],
                            ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  // An action can be bigger than the others.
                                  flex: 2,
                                  onPressed: doNothing,
                                  backgroundColor: const Color(0xFF7BC043),
                                  foregroundColor: Colors.white,
                                  icon: Icons.archive,
                                  label: 'Archive',
                                ),
                                SlidableAction(
                                  onPressed: doNothing,
                                  backgroundColor: const Color(0xFF0392CF),
                                  foregroundColor: Colors.white,
                                  icon: Icons.save,
                                  label: 'Save',
                                ),
                              ],
                            ),

                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: ListTile(
                              leading: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      listModelUser[index].id.toString(),
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  )),
                              // title: Text(listModelUser[index].title.toString()),
                              trailing: const Icon(Icons.arrow_right_rounded),
                              subtitle: const Text("sub title"),
                            ),
                          ),
                        ))
              : const Center(
                  child: CupertinoActivityIndicator(),
                )
        ],
      ),
    ));
  }
}
