
class TaskModel {
   int? id;
   String? title,description,created_at,due_date;
   bool? is_completed;
  TaskModel({this.id,required this.title, required this.description, required this.created_at, required this.due_date,required this.is_completed});


   TaskModel.fromJson(Map<String,dynamic> map){
     id=map['id'];
     title=map['title'];
     description=map['description'];
     created_at=map['created_at'];
     due_date=map['due_date'];
     is_completed=map['is_completed'];
   }
   Map<String,dynamic> toJson(){
     return {
       'title':title,
       'description':description,
       'created_at':created_at,
       'due_date':due_date,
       'is_completed':is_completed
     };
   }

}
