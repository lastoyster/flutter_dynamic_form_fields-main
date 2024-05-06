import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form_fields/user_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    userModel = UserModel("", 18, []);
    userModel.emails.add("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Form"),
        backgroundColor: Colors.redAccent,
      ),
      body: _uiWidget(),
    );
  }

  Widget _uiWidget() {
    return Form(
      key: globalFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormHelper.inputFieldWidgetWithLabel(
              context,
              const Icon(Icons.person),
              "name",
              "User Name",
              userModel.userName,
              (value) {
                if (value.isEmpty) {
                  return 'User Name can\'t be empty.';
                }
                return null;
              },
              (value) => userModel.userName = value,
              prefixIconColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              const Icon(Icons.calendar_today),
              "age",
              "Age",
              userModel.userAge.toString(),
              (value) {
                if (value.isEmpty) {
                  return 'Age can\'t be empty.';
                }
                return null;
              },
              (value) => userModel.userAge = int.tryParse(value) ?? 0,
              keyboardType: TextInputType.number,
              prefixIconColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
            Text(
              "Email Address(s)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            emailsContainerUI(),
            const SizedBox(height: 20),
            FormHelper.submitButton(
              "Save",
              () {
                if (validateAndSave()) {
                  print(userModel.toJson());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget emailsContainerUI() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: userModel.emails.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: FormHelper.inputFieldWidget(
                  context,
                  const Icon(Icons.email),
                  "email_$index",
                  "",
                  userModel.emails[index],
                  (value) {
                    if (value.isEmpty) {
                      return 'Email ${index + 1} can\'t be empty.';
                    }
                    return null;
                  },
                  (value) => userModel.emails[index] = value,
                  prefixIconColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                icon: Icon(Icons.remove_circle),
                color: Colors.redAccent,
                onPressed: () => removeEmailControl(index),
              ),
              if (index == userModel.emails.length - 1)
                IconButton(
                  icon: Icon(Icons.add_circle),
                  color: Colors.green,
                  onPressed: addEmailControl,
                ),
            ],
          ),
        );
      },
    );
  }

  void addEmailControl() {
    setState(() {
      userModel.emails.add("");
    });
  }

  void removeEmailControl(int index) {
    setState(() {
      if (userModel.emails.length > 1) {
        userModel.emails.removeAt(index);
      }
    });
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
