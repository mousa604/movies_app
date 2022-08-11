class MovieModel {
  String? name;
  String? id;
  String? description;
  String? image;
  String? rate;
  String? type;
  String? actor1;
  String? actor2;
  String? actor3;
  bool? isfav;



  MovieModel({this.name,this.image,this.id,this.actor1,this.actor2,this.actor3,this.description,this.isfav,this.rate,this.type});

  MovieModel.fromJson(Map<String,dynamic> json){

    name=json['name'];
    image=json['image'];
    id=json['id'];
    description=json['description'];
    actor1=json['actor1'];
    actor2=json['actor2'];
    actor3=json['actor3'];
    rate=json['rate'];
    type=json['type'];
    isfav=json['isfav'];


  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'image':image,
      'id':id,
      'description':description,
      'actor1':actor1,
      'actor2':actor2,
      'actor3':actor3,
      'rate':rate,
      'type':type,
      'isfav':isfav,
    };
  }

}