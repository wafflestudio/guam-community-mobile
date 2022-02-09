// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import '../../commons/custom_app_bar.dart';
// import 'package:provider/provider.dart';
// import '../../providers/user_auth/authenticate.dart';
//
// class SignUp extends StatelessWidget {
//   final _formKey = GlobalKey<FormBuilderState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(title: '회원가입'),
//         body: Column(
//           children: [
//             FormBuilder(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   FormBuilderTextField(
//                     name: 'name',
//                     decoration: InputDecoration(
//                       labelText: '이름',
//                     ),
//                     valueTransformer: (text) => text.trim(),
//                     validator: FormBuilderValidators.compose([
//                       FormBuilderValidators.required(context),
//                     ]),
//                     keyboardType: TextInputType.text,
//                   ),
//                   FormBuilderTextField(
//                     name: 'email',
//                     decoration: InputDecoration(
//                       labelText: '이메일',
//                     ),
//                     valueTransformer: (text) => text.trim(),
//                     validator: FormBuilderValidators.compose([
//                       FormBuilderValidators.required(context),
//                     ]),
//                     keyboardType: TextInputType.text,
//                   ),
//                   FormBuilderTextField(
//                     name: 'password',
//                     decoration: InputDecoration(
//                       labelText: '비밀번호',
//                     ),
//                     obscureText: true,
//                     valueTransformer: (text) => text.trim(),
//                     validator: FormBuilderValidators.compose([
//                       FormBuilderValidators.required(context),
//                     ]),
//                     keyboardType: TextInputType.text,
//                   ),
//                   FlatButton(
//                       onPressed: () {
//                         // if (_formKey.currentState.saveAndValidate()) {
//                         //   context.read<Authenticate>().signUp(params: _formKey.currentState.value)
//                         //       .then((val) => Navigator.of(context).popUntil((route) => route.isFirst));
//                         // }
//                       },
//                       child: const Text('확인')
//                   )
//                 ],
//               ),
//             )
//           ],
//         )
//     );
//   }
// }
