import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchField extends StatefulWidget {
  final String initialValue;
  final String hint;

  final void Function(String value) onChanged;

  SearchField({
    @required this.initialValue,
    @required this.hint,
    @required this.onChanged,
  });

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> with RouteAware {
  final _searchController = BehaviorSubject<String>();
  final _isSearching = BehaviorSubject<bool>();
  TextEditingController _textEditingController;
  StreamSubscription _searchSubscription;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.initialValue ?? "");
    _searchSubscription = _searchController
        .distinct()
        .debounceTime(
          Duration(milliseconds: 500),
        )
        .listen(
      (value) {
        widget.onChanged(value);
        if (value.length == 0) {
          _isSearching.add(false);
        } else {
          _isSearching.add(true);
        }
      },
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _isSearching.close();
    _searchController.close();
    _searchSubscription.cancel();

    super.dispose();
  }

  @override
  void didPushNext() {
    FocusScope.of(context).requestFocus(new FocusNode());
    super.didPushNext();
  }

  @override
  void didPopNext() {
    FocusScope.of(context).requestFocus(new FocusNode());
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(32, 54, 93, 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
       padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
        controller: _textEditingController,
        onChanged: (String value) {
          _searchController.add(value);
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.blueGrey[200]),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(22.0),
            ),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hint,
          hintStyle: const TextStyle(
              color: Color(0xff20365D),
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ),
    );
  }
}
