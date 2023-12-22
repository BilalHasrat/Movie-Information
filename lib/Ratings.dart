class Ratings {
  Ratings({
       this.source,
       this.value,});

  Ratings.fromJson(dynamic json) {
    source = json['Source'];
    value = json['Value'];
  }
  String? source;
  String? value;

}