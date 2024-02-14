import 'package:takeh_customer/Models/Option.dart';

class Question {
  int id = 0;
  String slug = '';
  String type = '';
  bool is_enabled = true;
  bool is_req = true;
  int min_val = 0;
  String name = '';
  String text = '';
  String desc = '';
  //
  String error = '';
  //
  List<Option> options = [];
  //

  int min = 0;
  int max = 0;
  int inRow = 0;
  double height = 0;
  String layout = 'GridView';

  String price_type = '';
  String val = '';
  String locationType = '';
  String fromTimeRange = '';
  String toTimeRange = '';

  Question({
    this.id = 0,
    this.slug = '',
    this.type = '',
    this.is_enabled = true,
    this.is_req = true,
    this.min_val = 0,
    this.name = '',
    this.text = '',
    this.desc = '',
    this.error = '',
    this.min = 0,
    this.max = 0,
    this.inRow = 0,
    this.layout = 'GridView',
    this.price_type = '',
    this.val = '',
    this.locationType = '',
    //
    this.fromTimeRange = '',
    this.toTimeRange = '',
  });

  Question.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.type = data['type'];
    } catch (e) {}
    try {
      this.is_enabled = data['is_enabled'];
    } catch (e) {}
    try {
      this.is_req = data['is_req'];
    } catch (e) {}
    try {
      this.min_val = data['min_val'];
    } catch (e) {}
    try {
      this.name = data['name'];
    } catch (e) {}

    try {
      this.text = data['desc'];
    } catch (e) {}

    try {
      if (this.text.contains('{desc=') && this.text.contains('=desc}')) {
        String start = '{desc=';
        String end = '=desc}';
        final startIndex = this.text.indexOf(start);
        final endIndex = this.text.indexOf(end, startIndex + start.length);

        try {
          this.desc = this.text.substring(startIndex + start.length, endIndex);
        } catch (e) {}
      }
    } catch (e) {}

    //
    try {
      if (this.text.contains('{error=') && this.text.contains('=error}')) {
        String start = '{error=';
        String end = '=error}';
        final startIndex = this.text.indexOf(start);
        final endIndex = this.text.indexOf(end, startIndex + start.length);

        try {
          this.error = this.text.substring(startIndex + start.length, endIndex);
        } catch (e) {}
      }
    } catch (e) {}

    this.options = [];
    try {
      if (data['options'] != null)
        for (var element in data['options'])
          this.options.add(Option.fromAPI(element));
    } catch (e) {}

    try {
      if (this.type == 'slider') {
        if (this.slug.contains('{min=') && this.slug.contains('=min}')) {
          String start = '{min=';
          String end = '=min}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.min = int.parse(
                this.slug.substring(startIndex + start.length, endIndex));
          } catch (e) {}
        }
      }
    } catch (e) {}
    try {
      if (this.type == 'slider') {
        if (this.slug.contains('{max=') && this.slug.contains('=max}')) {
          String start = '{max=';
          String end = '=max}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.max = int.parse(
                this.slug.substring(startIndex + start.length, endIndex));
          } catch (e) {}
        }
      }
    } catch (e) {}
    try {
      if (this.type == 'options') {
        if (this.slug.contains('{row=') && this.slug.contains('=row}')) {
          String start = '{row=';
          String end = '=row}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.inRow = int.parse(
                this.slug.substring(startIndex + start.length, endIndex));
          } catch (e) {}
        }
      }
    } catch (e) {}
    try {
      if (this.type == 'options') {
        if (this.slug.contains('{height=') && this.slug.contains('=height}')) {
          String start = '{height=';
          String end = '=height}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.height = double.parse(
                this.slug.substring(startIndex + start.length, endIndex));
          } catch (e) {}
        }
      }
    } catch (e) {}
    //
    try {
      if (this.type == 'options') {
        if (this.slug.contains('{layout=') && this.slug.contains('=layout}')) {
          String start = '{layout=';
          String end = '=layout}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.layout =
                this.slug.substring(startIndex + start.length, endIndex);
          } catch (e) {}
        }
      }
    } catch (e) {}
    //
    try {
      // if (this.type == 'slider') {
      if (this.slug.contains('{price_type=') &&
          this.slug.contains('=price_type}')) {
        String start = '{price_type=';
        String end = '=price_type}';
        final startIndex = this.slug.indexOf(start);
        final endIndex = this.slug.indexOf(end, startIndex + start.length);

        try {
          this.price_type =
              this.slug.substring(startIndex + start.length, endIndex);
        } catch (e) {}
      }
      // }
    } catch (e) {}
    //
    try {
      // if (this.type == 'slider') {
      if (this.slug.contains('{val=') && this.slug.contains('=val}')) {
        String start = '{val=';
        String end = '=val}';
        final startIndex = this.slug.indexOf(start);
        final endIndex = this.slug.indexOf(end, startIndex + start.length);

        try {
          this.val = this.slug.substring(startIndex + start.length, endIndex);
        } catch (e) {}
      }
      // }
    } catch (e) {}
    //
    try {
      if (this.type == 'from-to-address' || this.type == 'address') {
        if (this.slug.contains('{location-type=') &&
            this.slug.contains('=location-type}')) {
          String start = '{location-type=';
          String end = '=location-type}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.locationType =
                this.slug.substring(startIndex + start.length, endIndex);
          } catch (e) {}
        }
      }
    } catch (e) {}

    //
    try {
      if (this.type == 'options') {
        if (this.slug.contains('{time-in-from=') &&
            this.slug.contains('=time-in-from}')) {
          String start = '{time-in-from=';
          String end = '=time-in-from}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.fromTimeRange =
                this.slug.substring(startIndex + start.length, endIndex);
          } catch (e) {}
        }
      }
    } catch (e) {}

    //
    try {
      if (this.type == 'options') {
        if (this.slug.contains('{time-in-to=') &&
            this.slug.contains('=time-in-to}')) {
          String start = '{time-in-to=';
          String end = '=time-in-to}';
          final startIndex = this.slug.indexOf(start);
          final endIndex = this.slug.indexOf(end, startIndex + start.length);

          try {
            this.toTimeRange =
                this.slug.substring(startIndex + start.length, endIndex);
          } catch (e) {}
        }
      }
    } catch (e) {}
  }
}
