import 'dart:convert';
import 'dart:ui';
import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preference/customs/colors.dart';
import 'package:shared_preference/customs/contact_model.dart';
import 'package:shared_preference/customs/custome_textfield.dart';
import 'package:shared_preference/customs/mytext.dart';
import 'package:shared_preference/main_screens/animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import '../customs/responsive.dart';

class ContactCreatePage extends StatefulWidget {
  const ContactCreatePage({super.key});

  @override
  State<ContactCreatePage> createState() => _ContactCreatePageState();
}

class _ContactCreatePageState extends State<ContactCreatePage> {
  final _numberRegex = RegExp(r'^[6789][0-9]{9}$');
  final _nameRegex = RegExp(r'^[a-zA-Z ]{2,}$');
  String number = "";
  String _name = "";

  //error Text
  bool numbervalid = true;
  bool namevalid = true;

  List<Contact> contactList = List.empty(growable: true);
  SharedPreferences? sp;

  // Function to initialize SharedPreferences
  getSharedPreference() async {
    sp = await SharedPreferences.getInstance();
  }

  int selectedIndex = -1;

  // Function to save contacts to SharedPreferences
  saveInfo() {
    List<String> contactListsString = contactList.map((contact) => jsonEncode(contact.toJson())).toList();
    sp?.setStringList("myData", contactListsString);
  }

  // Function to read contacts from SharedPreferences
  readFromStringList() {
    List<String>? contactListsString = sp?.getStringList('myData');
    if (contactListsString != null) {
      contactList = contactListsString.map((contact) => Contact.fromJson(json.decode(contact))).toList();
      setState(() {});  // Update UI after loading data
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference().then((_) {
      readFromStringList();  // Load the contact list when SharedPreferences is ready
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/contacts.jpg"), // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: CustomText(
            letterspacing: 2,

            text: "Contact Lists",
            fontSize: 30,

          ),
          centerTitle: true,
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40,),
          // Text fields for entering contact name and number
          Form(
            key:formKey,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: CustomTextField(
                labelText: CustomText(text: "Name"),
                isObsecre: false,
                controller: nameController,
                onChanged: (value) {
                  setState(() {
                    namevalid = _nameRegex.hasMatch(value);
                    _name = value;
                  });

                },
                errorText: namevalid ?  null :"Please provide a valid name",
                validator: (value) {
                  if (nameController.text.length != null && nameController.text.length <= 3) {
                    return "Please provide a valid name";
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: CustomTextField(
              maxlength: 10,
              
              isObsecre: false,
              labelText: CustomText(text: "Number"),
              controller: numberController,
              onChanged: (value) {
                setState(() {
                  numbervalid = _numberRegex.hasMatch(value);
                number = value;
                });
              },
              errorText: numbervalid ? null : "Please provide a valid number",
              validator: (value) {
                if (numberController.text.isEmpty && _numberRegex.hasMatch(numberController.text)) {
                  return "Please provide a valid number";
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 50),
          // Buttons for Save and Update
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customButton(context, "Save", () {
                String name = nameController.text.trim();
                String contact = numberController.text.trim();
                if (formKey.currentState!.validate() && name.isNotEmpty && contact.isNotEmpty && _numberRegex.hasMatch(contact) ) {
                  setState(() {
                    nameController.text = "";
                    numberController.text = "";
                    contactList.add(Contact(name: name, phoneNumber: contact));

                  });
                  saveInfo(); // Save to SharedPreferences
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: blueColor,
                      content: Text("Contact saved successfully!"),
                duration: Duration(seconds: 2))// Duration for how long the SnackBar will be displayed
                 );}

              }),


              customButton(context, "Update", () {
                String name = nameController.text.trim();
                String contact = numberController.text.trim();
                if (formKey.currentState!.validate() && name.isNotEmpty && contact.isNotEmpty && _numberRegex.hasMatch(contact) && selectedIndex != -1) {
                  setState(() {

                    contactList[selectedIndex].name = name;
                    contactList[selectedIndex].phoneNumber = contact;
                    nameController.clear();
                    numberController.clear();
                    selectedIndex = -1;
                  });
                  saveInfo();// Save updated contact to SharedPreferences
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(backgroundColor: blueColor,
                content: Text("Contact updated successfully!"),
                duration: Duration(seconds: 2))// Duration for how long the SnackBar will be displayed
                );

                }
    //             Navigator.push(context, MaterialPageRoute(builder: (Context)=>AnimatedBorderPage()));
              }),
            ],
          ),
          SizedBox(height: 30),
          // Display the list of contacts
          Flexible(
            child: ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context)||Responsive.isDesktopLarge(context) ? 200:
                  20),
                  child: ListTile(

                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),


                  ),
                  leading: Icon(Icons.person,color: blueColor,),
                  title: CustomText(
                    text: contactList[index].name,

                  ),
                  subtitle: CustomText(
                    text: contactList[index].phoneNumber,

                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            contactList.removeAt(index); // Remove contact
                          });
                          saveInfo();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(backgroundColor: blueColor,
                                  content: Text("Contact deleted!"),
                                  duration: Duration(seconds: 2))// Duration for how long the SnackBar will be displayed
                          );// Save after removal
                        },
                      ),
                      IconButton(onPressed: (){
                        setState(() {
                          nameController.text = contactList[index].name;
                          numberController.text = contactList[index].phoneNumber;
                          selectedIndex = index;
                        });

                      }, icon: Icon(Icons.edit,color: greenColor,))
                    ],
                  ),

                  onTap: () {
                    // Allow the user to edit the selected contact
                    setState(() {
                      selectedIndex = index;
                      nameController.text = contactList[index].name;
                      numberController.text = contactList[index].phoneNumber;
                    });
                  },
                                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Custom button widget
  Widget customButton(BuildContext context, String text, void Function()? onTap) {
    return Container(
      width: 100,
      height: 40,
      decoration: const BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: CustomText(text: text, color: whiteColor),
        ),
      ),
    );
  }

}
