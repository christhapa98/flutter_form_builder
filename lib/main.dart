// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class FormData {
  FormData({this.labeltitle, this.regex, this.onChange, this.inputType});
  String? labeltitle;
  String? regex;
  Function? onChange;
  TextInputType? inputType;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
        home: Scaffold(
            appBar: AppBar(title: const Text("Form Builder")),
            body: FormBuilder(
                onSubmit: (Map<String, dynamic> values) {
                  print(values);
                },
                formData: const [
                  'Name',
                  'Email',
                  'Password',
                  'Contact'
                ],
                customFormDat: [
                  FormData(labeltitle: 'Name', inputType: TextInputType.text),
                  FormData(
                      labeltitle: 'Email',
                      inputType: TextInputType.emailAddress),
                  FormData(
                      labeltitle: 'Password',
                      inputType: TextInputType.visiblePassword),
                  FormData(
                      labeltitle: 'Contact', inputType: TextInputType.phone),
                ])));
  }
}

class FormBuilder extends StatefulWidget {
  FormBuilder(
      {Key? key,
      required this.formData,
      required this.customFormDat,
      this.onSubmit})
      : super(key: key);
  List<String> formData;
  List<FormData> customFormDat;
  dynamic onSubmit;

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  List<TextEditingController> allController = [];
  Map<String, dynamic> formData = {};

  @override
  void initState() {
    widget.formData
        .map((e) => allController.add(TextEditingController()))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
            height: 80,
            child: TextButton(
                onPressed: () {
                  formData.clear();
                  widget.formData
                      .asMap()
                      .forEach((index, value) => setState(() {
                            {
                              formData.addAll({
                                widget.formData[index]:
                                    allController[index].text
                              });
                            }
                          }));
                  widget.onSubmit(formData);
                },
                child: const Text('Add'))),
        body: Form(
            child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: allController.length,
                itemBuilder: (ctx, ind) {
                  bool showHidePassword = true;
                  bool showHide = widget.customFormDat[ind].inputType ==
                      TextInputType.visiblePassword;
                  return TextFormField(
                      controller: allController[ind],
                      validator: (String? error) {},
                      obscureText: widget.customFormDat[ind].inputType ==
                          TextInputType.visiblePassword,
                      inputFormatters: const [],
                      onChanged: (String? val) {
                        if (val != null) {}
                      },
                      keyboardType: widget.customFormDat[ind].inputType,
                      decoration: InputDecoration(
                          labelText: widget.customFormDat[ind].labeltitle,
                          suffixIcon: showHide
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showHidePassword = !showHidePassword;
                                    });
                                  },
                                  icon: Icon(Icons.remove_red_eye,
                                      color: showHidePassword
                                          ? Colors.red
                                          : Colors.black))
                              : null));
                })));
  }
}
