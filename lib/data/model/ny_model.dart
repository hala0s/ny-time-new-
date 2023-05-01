class Results {
  Results ({required this.url , required this.uri, required this.id, required this.source, required this.date,
  required this.type , required this.title , required this.abstract , required this.assetId});
  String? uri ;
   String? url ;
   int? id , assetId ;
   String? source ;
   String? date ;
   String? type ;
   String? title;
   String? abstract ;


static Results fromJson(Map<String, dynamic> json ) {
  return Results (
    abstract: json['abstract'],
    uri: json['uri'],
    url: json['url'],
    id: json['id'],
    assetId: json['assetid'],
    source: json['source'],
    date: json['date'],
    type: json['type'],
    title: json['title'],
  );
}

static List<Results> fromJsonToModel(List<dynamic> list) =>
      list.isEmpty ? [] :    list.map((e) => fromJson(e)).toList();

}