// import 'package:ebus/core/viewmodels/MainViewModel.dart';
// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:provider/provider.dart';

// class DropDownSearch extends StatelessWidget {
//   const DropDownSearch({Key key}) : super(key: key);
//   SourceView

//     static const List<String> _kOptions = <String>[
//     'aardvark',
//     'bobcat',
//     'chameleon',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MainViewModel>(
//       builder: (_, MainViewModel, __),

//       child: Autocomplete<String>(
//         optionsBuilder: (TextEditingValue textEditingValue) {
//           if (textEditingValue.text == '') {
//             // return const Iterable<String>.empty();
//             // return _kOptions;
//             return sourceViewModel.capitalSourceTownsList
//           }
//           return _kOptions.where((String option) {
//             return option.contains(textEditingValue.text.toLowerCase());
//           });
//         },
//         onSelected: (String selection) {
//           debugPrint('You just selected $selection');
//         },
//       ),
//     );
// }

//   //   DropdownSearch<String>(
//   //       mode: Mode.MENU,
//   //       items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//   //       // label: "مبدا",
//   //       hint: "country in menu mode",
//   //       popupItemDisabled: (String s) => s.startsWith('I'),
//   //       onChanged: print,
//   //       selectedItem: "مبدا");
//   // }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return DropdownButton<String>(
//   //     items: <String>['A', 'B', 'C', 'D'].map((String value) {
//   //       return DropdownMenuItem<String>(
//   //         value: value,
//   //         child: Text(value),
//   //       );
//   //     }).toList(),
//   //     onChanged: (_) {},
//   //   );
//   // }
// }


