import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:takeh_customer/Models/Appimage.dart';
import 'package:takeh_customer/Provider/TabBarProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'dart:io';

import 'package:takeh_customer/main.dart';

selectImagePopUp(BuildContext context, {bool onlyOne = false}) async {
  tabBarProvider.pickeds = [];
  tabBarProvider.is_picked = false;

  return await showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: Consumer<TabBarProvider>(
          builder: (_, v, __) {
            return Container(
              height: v.pickeds.length > 0
                  ? MediaQuery.of(context).size.height * 0.7
                  : MediaQuery.of(context).size.height * 0.40,
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: globalText(
                          S.current.takeImage,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        end: 0,
                        child: InkWell(
                          onTap: () => NavMove.closeDialog(context),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                  setHeightSpace(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        setHeightSpace(20),
                        GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            // mainAxisExtent: 100,
                            mainAxisExtent: 80,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            InkWell(
                              onTap: () async {
                                if (!onlyOne) {
                                  await v.picker.pickMultiImage().then((value) {
                                    if (value.length > 0)
                                      v.pickeds.addAll(value);
                                  });
                                  if (v.pickeds.length > 0) v.is_picked = true;
                                } else {
                                  await v.picker
                                      .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 25,
                                  )
                                      .then((value) {
                                    if (value != null) v.pickeds = [value];
                                  });
                                  if (v.pickeds.length > 0) v.is_picked = true;
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.orange,
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                //
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image),
                                    globalText(S.current.gallery),
                                  ],
                                ),
                              ),
                            ),
                            //
                            InkWell(
                              onTap: () async {
                                await v.picker
                                    .pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 25,
                                )
                                    .then((value) {
                                  if (value != null) {
                                    if (onlyOne)
                                      v.pickeds = [value];
                                    else
                                      v.pickeds.add(value);
                                  }
                                });
                                if (v.pickeds.length > 0) v.is_picked = true;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.orange,
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera),
                                    globalText(S.current.camera),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        setHeightSpace(30),
                        if (v.pickeds.length > 0)
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisExtent: 150,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemCount: onlyOne
                                  ? v.pickeds.length
                                  : v.pickeds.length + 1,
                              // itemCount: v.pickeds.length,
                              itemBuilder: (context, index) {
                                if (v.pickeds.length <= index && !onlyOne)
                                  return Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: index == 0
                                            ? AppColor.secondary
                                            : AppColor.orange,
                                        width: 0.5,
                                      ),
                                    ),
                                    // child: Center(
                                    //   child: globalText(
                                    //     S.current.addImage,
                                    //     style: TextStyle(
                                    //       color: Colors.black,
                                    //     ),
                                    //   ),
                                    // ),
                                    child: Container(
                                      padding: EdgeInsets.all(25),
                                      child: Icon(Icons.add),
                                    ),
                                  );

                                XFile file = v.pickeds[index];
                                return InkWell(
                                  onTap: () => NavMove.goToPage(context,
                                      ImageShowPage(v.pickeds, index: index)),
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: index == 0
                                            ? AppColor.secondary
                                            : AppColor.orange,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          child: Center(
                                            child: Image.file(File(file.path)),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          top: 0,
                                          end: 0,
                                          child: InkWell(
                                            onTap: () => v.removeFile(file),
                                            child: Container(
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: AppColor.orange,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.delete_outline,
                                                // color: AppColor.orange,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        setHeightSpace(30),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: globalButton(
                          S.current.cancel,
                          () => NavMove.goBack(context),
                          backColor: Colors.transparent,
                          borderColor: Colors.red,
                          textColor: Colors.red,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      setWithSpace(10),
                      Expanded(
                        child: globalButton(
                          S.current.done,
                          () => NavMove.goBack(
                            context,
                            data: {
                              'pickeds': v.pickeds,
                              'is_picked': v.is_picked,
                            },
                          ),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  setHeightSpace(10),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

class ImageShowPage extends StatelessWidget {
  final image;
  final int index;
  const ImageShowPage(this.image, {super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => NavMove.goBack(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColor.orange),
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image is File) ...[
                  Expanded(child: Image.file(image)),
                ] else if (image is String &&
                    (image.contains('http') && image.contains('.svg'))) ...[
                  Expanded(
                    child: SvgPicture.network(image),
                  ),
                ] else if (image is String && image.contains('http')) ...[
                  Expanded(child: NetworkImagePlace(image: image)),
                ] else if (image is Appimage) ...[
                  Expanded(child: NetworkImagePlace(image: image.image))
                ] else if (image is List) ...[
                  Expanded(
                    child: PageView.builder(
                      controller: PageController(initialPage: index),
                      itemCount: image.length,
                      itemBuilder: (context, index) {
                        return images(image[index], context);
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget images(imm, BuildContext context) {
    if (imm is File)
      return Expanded(child: Image.file(imm));
    else if (imm is XFile)
      return Expanded(child: Image.file(File(imm.path)));
    else if (imm is String && (imm.contains('http') && imm.contains('.svg')))
      return Expanded(
        child: SvgPicture.network(imm),
      );
    else if (imm is String && imm.contains('http'))
      return Expanded(child: NetworkImagePlace(image: imm));
    else if (imm is Appimage)
      return Expanded(child: NetworkImagePlace(image: imm.image));

    return Container();
  }
}
