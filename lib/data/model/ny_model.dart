class AllResults {
  AllResults(
      {required this.status,
      required this.copyright,
      required this.numresult,
      required this.results});
  String? status;
  String? copyright;
  int? numresult;
  List<Results>? results;

  static AllResults fromJson(Map<String, dynamic> json) {
    return AllResults(
            status: json['status'],
            copyright: json['copyright'],
            numresult: json['numresult'],
            results: (json ['results'] as List).map((e) => Results.fromJson(e)).toList(),
            
            );
       
  }
  static List fromjsontomodel (List<dynamic> list) => 
  list.isEmpty ? [] :  list.map((e) => fromJson(e)).toList();

}
class Results {
  Results({
    required this.uri,
    required this.id,
    required this.assetId,
    required this.source,
    required this.puplishedDate,
    required this.abstract,
    required this.nytdsection,
    required this.section,
    required this.url,
    required this.subsection,
    required this.title,
    required this.type,
  });
  String? uri;
  String? url;
  int? id;
  int? assetId;
  String? source;
  String? puplishedDate;
  String? section;
  String? subsection;
  String? nytdsection;
  String? type;
  String? title;
  String? abstract;

  static Results fromJson(Map<String, dynamic> json) {
    return Results(
      
        uri: json['uri'],
        id: json['id'],
        assetId: json['assetId'],
        source: json['source'],
        puplishedDate: json['puplishedDate'],
        abstract: json['abstract'],
        nytdsection: json['nytdsection'],
        section: json['section'],
        url: json['url'],
        subsection: json['subsection'],
        title: json['title'],
        type: json['type']);
  }
  static List fromjsontomodel (List<dynamic> list) => 
  list.isEmpty ? [] :    list.map((e) => fromJson(e)).toList();
}
