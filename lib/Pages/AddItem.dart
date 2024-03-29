import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khana_mobile_application/UI/CustomColors.dart';
import 'package:khana_mobile_application/Widgets/appbar.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AddItemPage extends StatefulWidget {
  final Map editItem;

  const AddItemPage({Key key, this.editItem}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _ItemID = TextEditingController();
  final TextEditingController _ItemName = TextEditingController();
  final TextEditingController _ItemDescription = TextEditingController();
  int numberOfItem = 1;
  int priceOfItem = 5;
  File _image;
  Timer timer;
  final picker = ImagePicker();

  bool isEditing = false;

  _imgFromGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.editItem != null) {
      _ItemID.text = widget.editItem['id'];
      _ItemName.text = widget.editItem['name'];
      _ItemDescription.text = widget.editItem['des'];
      numberOfItem = widget.editItem['numOfPieces'];
      priceOfItem = widget.editItem['price'];
      String img = widget.editItem['image'];

      _image = File(img);
      isEditing = true;
      setState(() {});
    }
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (s) {
        bool lang = s.lang;
        return Scaffold(
          appBar: appbar('Add Item', context),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(height: 20),
              //////////////////////////////////////////////////////////////////
              /// Clear Button
              Center(
                child: clearButton(CustomColors.darkGray, Feather.x, s),
              ),
              SizedBox(height: 20),
              ////////////////////////////////////////////////////////////////
              /// Item ID
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "ID",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(hint: '1345', controller: _ItemID),
              SizedBox(height: 20),
              ////////////////////////////////////////////////////////////////
              /// Item Name
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Name",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(hint: 'Example', controller: _ItemName),
              SizedBox(height: 20),
              ////////////////////////////////////////////////////////////////
              /// Item Description
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Information",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(
                  hint: 'Some description about item',
                  controller: _ItemDescription),
              SizedBox(height: 20),
              //////////////////////////////////////////////////////////////////
              Row(children: [
                ////////////////////////////////////////////////////////////////
                /// Number Of Items
                Expanded(
                  child: Column(children: [
                    Text("Number of Items", textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                                num: true,
                                icon: Feather.minus,
                                color: CustomColors.red),
                            Text("$numberOfItem"),
                            CustomButton(
                                num: true,
                                icon: Feather.plus,
                                color: CustomColors.green),
                          ]),
                    )
                  ]),
                ),
                ////////////////////////////////////////////////////////////////
                /// Price in Dollar
                Expanded(
                  child: Column(
                    children: [
                      Text("Price in dollar", textAlign: TextAlign.center),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomButton(
                                  num: false,
                                  icon: Feather.minus,
                                  color: CustomColors.red),
                              Text("$priceOfItem\$"),
                              CustomButton(
                                  num: false,
                                  icon: Feather.plus,
                                  color: CustomColors.green),
                            ]),
                      )
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 30),
              //////////////////////////////////////////////////////////////////
              /// Select Image
              Text("Upload Image", textAlign: TextAlign.center),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  _imgFromGallery();
                },
                child: _image == null
                    ? Container(
                        width: 50,
                        height: 50,
                        child: SvgPicture.asset("assets/img/upload_image.svg"))
                    : Image.file(_image,
                        width: 100, height: 100, fit: BoxFit.cover),
              ),
              //////////////////////////////////////////////////////////////////
              /// Add Button && Edit Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                    color: CustomColors.blue2,
                    borderRadius: BorderRadius.circular(10)),
                child: FlatButton(
                  onPressed: () {
                    isEditing ? editItemFromStorage(s) : addItemMethod(s);
                  },
                  child: Text(
                    isEditing ? 'Edit Item' : 'Add Item',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // //////////////////////////////////////////////////////////////////
              // /// read Button
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //       color: CustomColors.whiteRed,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: FlatButton(
              //     onPressed: () {
              //       s.readItemsFromStorage();
              //     },
              //     child: Text(
              //       'read Item',
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // // //////////////////////////////////////////////////////////////////
              // /// delete Button
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //       color: CustomColors.whiteRed,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: FlatButton(
              //     onPressed: () {
              //       s.cleanData();
              //     },
              //     child: Text(
              //       'delete Item',
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
            ]),
          ),
        );
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Edit item
  void editItemFromStorage(s) async {
    Map items = {
      '\"id\"': "\"${_ItemID.text.trim()}\"",
      '\"name\"': "\"${_ItemName.text.trim()}\"",
      '\"des\"': "\"${_ItemDescription.text.trim()}\"",
      '\"numOfPieces\"': numberOfItem,
      '\"numOfLeftPieces\"': numberOfItem,
      '\"price\"': priceOfItem,
      '\"image\"': _image != null ? "\"${_image.path}\"" : "\"\"",
    };
    int index = 0;
    List ITEM = await s.readItemsFromStorage();
    ITEM.forEach((value) {
      if (value['id'] == widget.editItem['id']) {
        index = ITEM.indexOf(value);
        setState(() {});
      }
    });
    ITEM.insert(index, items);
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Add Item
  void addItemMethod(s) async {
    await Permission.storage.request();

    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");

    if (!file.existsSync()) {
      file.create();
      String data = '{\"data\": [],\"list\": []}';
      file.writeAsString(data);
    }

    try {
      String data = await file.readAsString();
      if (!data.contains(_ItemID.text)) {
        Map items = {
          '\"id\"': "\"${_ItemID.text.trim()}\"",
          '\"name\"': "\"${_ItemName.text.trim()}\"",
          '\"des\"': "\"${_ItemDescription.text.trim()}\"",
          '\"numOfPieces\"': numberOfItem,
          '\"numOfLeftPieces\"': numberOfItem,
          '\"price\"': priceOfItem,
          '\"image\"': _image != null ? "\"${_image.path}\"" : "\"\"",
        };
        s.addItemToStorage(items);
      } else {
        s.showToast('invalid ID');
      }
    } catch (e) {
      print('can not write $e');
    }

    clearMethod();
  }

  CircleAvatar CustomButton({IconData icon, Color color, bool num}) {
    return CircleAvatar(
        backgroundColor: color,
        child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              try {
                timer = Timer.periodic(Duration(milliseconds: 100), (t) {
                  setState(() {
                    if (icon == Feather.plus) {
                      if (num) {
                        numberOfItem++;
                      } else {
                        priceOfItem++;
                      }
                    } else {
                      if (num && numberOfItem > 0) {
                        numberOfItem--;
                      } else if (!num && priceOfItem > 0) {
                        priceOfItem--;
                      }
                    }
                  });
                });
              } catch (e) {
                timer.cancel();
              }
            },
            onTapUp: (TapUpDetails details) {
              timer.cancel();
            },
            onTapCancel: () {
              timer.cancel();
            },
            onTap: () {
              setState(() {
                if (icon == Feather.plus) {
                  if (num) {
                    numberOfItem++;
                  } else {
                    priceOfItem++;
                  }
                } else {
                  if (num && numberOfItem > 0) {
                    numberOfItem--;
                  } else if (!num && priceOfItem > 0) {
                    priceOfItem--;
                  }
                }
              });
            },
            child: Icon(
              icon,
              color: CustomColors.white,
              size: 20,
            )));
  }

  CircleAvatar clearButton(Color color, IconData icon, s) {
    return CircleAvatar(
        backgroundColor: color,
        child: InkWell(
          onTap: () {
            clearMethod();
          },
          child: Icon(
            icon,
            color: CustomColors.white,
            size: 20,
          ),
        ));
  }

  clearMethod() {
    setState(() {
      _ItemID.text = '';
      _ItemName.text = '';
      _ItemDescription.text = '';
      numberOfItem = 1;
      priceOfItem = 5;
      _image = null;
    });
  }

  Container textField({String hint, TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0xFFE2F8FE).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: InputBorder.none,
            hintText: hint),
      ),
    );
  }
}
