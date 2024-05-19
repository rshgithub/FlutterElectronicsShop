import 'package:flutter/material.dart';
import 'package:ft_e_buy/components/my_appbar.dart';
import 'package:provider/provider.dart';
import '../../../../AppResource/app_colors.dart';
import '../../../../providers/auth_provider.dart';

class EditUserInfoScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<AuthProvider>(builder: (context, provider, c) {
          return provider.currentLoggedUser == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          provider.updateUserImage();
                        },
                        child: Container(
                          child: provider.currentLoggedUser!.imageUrl == null
                              ? CircleAvatar(
                                  radius: 70.0,
                                  backgroundImage:
                                      AssetImage("assets/images/user.jpeg"))
                              : CircleAvatar(
                                  radius: 70.0,
                                  backgroundImage: NetworkImage(
                                    provider.currentLoggedUser!.imageUrl!,
                                  )),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.adminBrown,
                                  width: 2)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileItem(
                          'userName:',
                          ((provider.currentLoggedUser!.userName!)),
                          provider.profileUserNameController,TextInputType.name),
                      ProfileItem(
                          'userAddress:',
                          ((provider.currentLoggedUser!.userAddress!)),
                          provider.profileUserAddressController,TextInputType.text,),
                      ProfileItem(
                          'Phone Number:',
                          ((provider.currentLoggedUser!.userPhone!)),
                          provider.profilePhoneController,TextInputType.phone,),
                      ProfileItem(
                          'Email:',
                          ((provider.currentLoggedUser!.userEmail!)),
                          provider.profileEmailController , TextInputType.emailAddress, true),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            bool isValid = formKey.currentState!.validate();
                            if (isValid) {
                              provider.updateUserInfo();
                            }
                          },
                          child: Text(
                            'Update User Info',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Mulish',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainBrown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  String label;
  String content;
  TextEditingController controller;
  bool? readOnlyOption;
  TextInputType? keyboardType;

  ProfileItem(this.label, this.content, this.controller , this.keyboardType , [ this.readOnlyOption]);

  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.mainBrown, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: AppColors.mainBrown)),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
              keyboardType: keyboardType,
              focusNode: myFocusNode,
              decoration: InputDecoration(
                helperText: label == 'Email:' ? '* sorry you cant change Email' : '',
                helperStyle: TextStyle(color: Colors.red , fontSize: 15),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.lightBrown),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:AppColors.mainBrown),
                ),
              ),
              readOnly: readOnlyOption == null ? false : true,
              cursorColor: AppColors.mainBrown,
              validator: (String? x) {
                if (x == null || x.isEmpty) {
                  return "this field is required";
                }
              },
              controller: controller,
              style: TextStyle(fontSize: 18)),
        ),
      ]),
    );
  }
}
