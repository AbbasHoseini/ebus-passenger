library dropdownsearch;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/model.dart';

///DropDownSearch has customized autocomplete text field functionality
///
///Parameters
///
///value - dynamic - Optional value to be set into the Dropdown field by default when this field renders
///
///icon - Widget - Optional icon to be shown to the left of the Dropdown field
///
///hintText - String - Optional Hint text to be shown
///
///hintStyle - TextStyle - Optional styling for Hint text. Default is normal, gray colored font of size 18.0
///
///labelText - String - Optional Label text to be shown
///
///labelStyle - TextStyle - Optional styling for Label text. Default is normal, gray colored font of size 18.0
///
///required - bool - True will validate that this field has a non-null/non-empty value. Default is false
///
///enabled - bool - False will disable the field. You can unset this to use the Dropdown field as a read only form field. Default is true
///
///items - List<dynamic> - List of items to be shown as suggestions in the Dropdown. Typically a list of String values.
///You can supply a static list of values or pass in a dynamic list using a FutureBuilder
///
///textStyle - TextStyle - Optional styling for text shown in the Dropdown. Default is bold, black colored font of size 14.0
///
///inputFormatters - List<TextInputFormatter> - Optional list of TextInputFormatter to format the text field
///
///setter - FormFieldSetter<dynamic> - Optional implementation of your setter method. Will be called internally by Form.save() method
///
///onValueChanged - ValueChanged<dynamic> - Optional implementation of code that needs to be executed when the value in the Dropdown
///field is changed
///
///strict - bool - True will validate if the value in this dropdown is amongst those suggestions listed.
///False will let user type in new values as well. Default is true
///
///itemsVisibleInDropdown - int - Number of suggestions to be shown by default in the Dropdown after which the list scrolls. Defaults to 3

typedef StringCallback(String data);

class DropDownSearch extends FormField<String> {
  // const DropDownSearch({ Key key }) : super(key: key);
  final dynamic value;
  final Widget? icon;
  final double? iconSize;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final bool? required;
  final bool enabled;
  final List<dynamic>? items;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<dynamic>? setter;
  final ValueChanged<dynamic>? onValueChanged;
  final bool? strict;
  final int? itemsVisibleInDropdown;
  final FocusNode? focusNode;
  final StringCallback? textChanged, textSubmitted;
  void setCurrentSource;
  final TextInputAction? textIAction;
  void hideDropDown;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  TextEditingController? controller;
  DropDownSearch(
      {Key? key,
      this.controller,
      this.setCurrentSource,
      this.textIAction,
      this.value,
      this.required: false,
      this.icon,
      this.iconSize,
      this.hintText,
      this.hintStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.white, fontSize: 18.0),
      this.labelText,
      this.labelStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 18.0),
      this.inputFormatters,
      this.items,
      this.textStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14.0),
      this.setter,
      this.onValueChanged,
      this.itemsVisibleInDropdown: 5,
      this.focusNode,
      this.enabled: true,
      this.strict: true,
      this.textSubmitted,
      this.textChanged,
      this.hideDropDown})
      : super(
            key: key,
            initialValue: controller != null ? controller.text : (value ?? ''),
            onSaved: setter,
            builder: (FormFieldState<String> field) {
              final DropDownSearchState state = field as DropDownSearchState;
              final ScrollController _scrollController = ScrollController();
              final InputDecoration effectiveDecoration = InputDecoration(
                fillColor: const Color.fromRGBO(238, 237, 237, 1),
                focusColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40),
                ),
                filled: false,
                labelText: labelText,
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(78, 218, 146, 1)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: icon,
                ),
                labelStyle: const TextStyle(
                    color: Colors.black38, fontSize: 16, height: 1.5),
              );

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          scrollPadding: const EdgeInsets.only(bottom: 200),
                          onEditingComplete: () {
                            print('onEditingComplete raaaaaaaaand::: ');
                            state.setState(() => state._onChanged = false);
                            state.setState(() => state._showdropdown = false);
                          },
                          onChanged: (search) {
                            state.newList(search, items);
                            state.setState(() => state._onChanged = true);
                            state.setState(() => state._showdropdown = true);

                            //call function ...
                            //finish call
                          },
                          onTap: () {
                            state.setState(() => state._showdropdown = true);
                          },
                          onFieldSubmitted: textSubmitted,
                          controller: state._effectiveController,
                          decoration: effectiveDecoration.copyWith(
                              errorText: field.errorText),
                          style: textStyle,
                          textAlign: TextAlign.start,
                          autofocus: false,
                          obscureText: false,
                          maxLengthEnforced: true,
                          maxLines: 1,
                          enabled: enabled,
                          inputFormatters: inputFormatters,
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_drop_down,
                              size: iconSize,
                              color: const Color.fromRGBO(78, 218, 146, 1)),
                          onPressed: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            state.setState(() {
                              
                              FocusScope.of(field.context).requestFocus(FocusNode());

                              print('dropdown pressed');
                              state._showdropdown = !state._showdropdown;
                              state._onChanged = !state._onChanged;
                              print('LLLLLLLL ${state._showdropdown.toString() + 'pppppp' + state._onChanged.toString()}');
                            });
                          }),
                    ],
                  ),

                  // ignore: sdk_version_ui_as_code
                  if (state._showdropdown == false && state._onChanged == false)
                    Container()
                  // Container(
                  //   child: Text(
                  //       'showdropdown: ${state._showdropdown} onchange: ${state._onChanged}'),
                  // )
                  else if (state._showdropdown && state._onChanged)
                    Container(
                      alignment: Alignment.topCenter,
                      height: itemsVisibleInDropdown! *
                          48.0, //limit to default 3 items in dropdownlist view and then remaining scrolls
                      width: MediaQuery.of(field.context).size.width,
                      child: ListView.builder(
                          itemCount: state._myList.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   child: Text(
                                //       '2. showdropdown: ${state._showdropdown} onchange: ${state._onChanged}'),
                                // ),
                                ListTile(
                                  title: Text(
                                    state._myList[index].title!,
                                    style: const TextStyle(
                                        color: Color(0xff7f7f7f), fontSize: 18),
                                  ),
                                  enabled: false,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: state._myList[index].ts!.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    color: Color.fromRGBO(
                                                        78, 218, 146, 1)),
                                                GestureDetector(
                                                  onTap: () {
                                                    int cityCode = state
                                                        ._myList[index]
                                                        .ts![i]
                                                        .code;
                                                    controller!.text =
                                                        cityCode.toString();

                                                    state._effectiveController
                                                        .clear();
                                                    state._effectiveController
                                                            .text =
                                                        state._myList[index]
                                                            .ts![i].title;

                                                    // String content = state
                                                    //     ._myList[index]
                                                    //     .ts[i]
                                                    //     .title;
                                                    // var text = state
                                                    //     ._effectiveController[
                                                    //         0]
                                                    //     .text;
                                                    // var pos = state
                                                    //     ._effectiveController[
                                                    //         0]
                                                    //     .selection
                                                    //     .start;
                                                    // state
                                                    //     ._effectiveController[
                                                    //         0]
                                                    //     .value = TextEditingValue(
                                                    //   text: text.substring(
                                                    //           0, pos) +
                                                    //       content +
                                                    //       text.substring(pos),
                                                    //   selection: TextSelection
                                                    //       .collapsed(
                                                    //           offset: pos +
                                                    //               content
                                                    //                   .length),
                                                    // );
                                                    state.setState(() {
                                                      state._showdropdown =
                                                          false;
                                                      state._onChanged = false;
                                                    });

                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());

                                                    // finish func
                                                  },
                                                  child: Text(
                                                      state.myList[index].ts![i]
                                                          .title,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff252525),
                                                          fontSize: 18)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                const SizedBox(height: 10),
                              ],
                            );
                          }),
                    )
                  else
                    Container(
                      alignment: Alignment.topCenter,
                      height: itemsVisibleInDropdown! *
                          48.0, //limit to default 3 items in dropdownlist view and then remaining scrolls
                      width: MediaQuery.of(field.context).size.width,
                      child: ListView.builder(
                          itemCount: items!.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   child: Text(
                                //       'showdropdown: ${state._showdropdown} onchange: ${state._onChanged}'),
                                // ),
                                ListTile(
                                  title: Text(
                                    items[index].title,
                                    style: const TextStyle(
                                        color: Color(0xff7f7f7f), fontSize: 18),
                                  ),
                                  enabled: false,
                                ),

                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: items[index].townships.length,
                                    // controller: _scrollController,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (BuildContext context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    color: Color.fromRGBO(
                                                        78, 218, 146, 1)),
                                                GestureDetector(
                                                  onTap: () {
                                                    // This function inserts townships to textfield

                                                    state._effectiveController
                                                        .clear();
                                                    state._effectiveController
                                                            .text =
                                                        items[index]
                                                            .townships[i]
                                                            .title;
                                                    // String content =
                                                    //     items[index]
                                                    //         .townships[i]
                                                    //         .title;
                                                    // var text = state
                                                    //     ._effectiveController[0]
                                                    //     .text;
                                                    // var pos = state
                                                    //     ._effectiveController[0]
                                                    //     .selection
                                                    //     .start;
                                                    // state._effectiveController[0]
                                                    //         .value =
                                                    //     TextEditingValue(
                                                    //   text: text.substring(
                                                    //           0, pos) +
                                                    //       content +
                                                    //       text.substring(pos),
                                                    //   selection: TextSelection
                                                    //       .collapsed(
                                                    //           offset: pos +
                                                    //               content
                                                    //                   .length),
                                                    // );
                                                    state.setState(() {
                                                      state._showdropdown =
                                                          false;
                                                      state._onChanged = false;
                                                    });
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                    // finish func
                                                  },
                                                  child: Text(
                                                      items[index]
                                                          .townships[i]
                                                          .title,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xff252525),
                                                          fontSize: 18)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),

                                const SizedBox(height: 10),
                              ],
                            );
                          }),
                    ),
                ],
              );
            });

  @override
  DropDownSearchState createState() => DropDownSearchState();
}

class DropDownSearchState extends FormFieldState<String> {
  TextEditingController? _controller = TextEditingController();

  bool _showdropdown = false;
  bool _isSearching = true;
  String _searchText = "";
  bool _onChanged = false;
  StringCallback? textChanged, textSubmitted;
  Function? _setCurrentSource;

  FocusNode? _focusNode;
  bool _isKeyboardActivated = false;

  @override
  DropDownSearch get widget => super.widget as DropDownSearch;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!;

  List<dynamic>? get _items {
    List myList = [];
    widget.items!
        .map((e) => e.townships.map((s) => myList.add(s.title)).toList())
        .toList();
    return myList;
  }

  List<Datum> myList = [];
  List<Datum> get _myList => myList;

  void newList(String str, items) {
    List<Datum> empty = [];
    myList = empty;

    for (var item in items) {
      Datum myObject = Datum();
      myObject.ts = [];
      for (var i in item.townships) {
        if (i.title.contains(str)) {
          if (myObject.id == item.id) {
            myObject.ts!.add(i);
          } else {
            myObject.id = item.id;
            myObject.title = item.title;
            myObject.ts!.add(i);
            myList.add(myObject);
          }
        }
      }
    }
  }

  void toggleDropDownVisibility() {}

  void clearValue() {
    setState(() {
      _effectiveController.text = '';
    });
  }

  @override
  void didUpdateWidget(DropDownSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller!.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    }

    _effectiveController.addListener(_handleControllerChanged);
    _searchText = _effectiveController.text;
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue!;
    });
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }
}
