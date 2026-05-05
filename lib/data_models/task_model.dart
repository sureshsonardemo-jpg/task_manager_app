
class TaskModel {
   int? id;
   String? title,description,createdAt,dueDate;
   bool? isCompleted;
  TaskModel({this.id,required this.title, required this.description, required this.createdAt, required this.dueDate,required this.isCompleted});


   TaskModel.fromJson(Map<String,dynamic> map){
     id=map['id'];
     title=map['title'];
     description=map['description'];
     createdAt=map['created_at'];
     dueDate=map['due_date'];
     isCompleted=map['is_completed'];
   }
   Map<String,dynamic> toJson(){
     return {
       'title':title,
       'description':description,
       'created_at':createdAt,
       'due_date':dueDate,
       'is_completed':isCompleted
     };
   }

}
