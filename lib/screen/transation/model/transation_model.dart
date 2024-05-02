class TrasacationModel
{
  String?title,amount,date,time,category;
  int?status,id;

  TrasacationModel(
      {this.title,
      this.amount,
      this.date,
      this.time,
      this.category,
      this.status,this.id});
  factory TrasacationModel.mapToModel(Map m1)
  {
    return TrasacationModel(time:m1['time'] ,title: m1['title'],amount:m1['amount'] ,date:m1['date'] ,status:m1['status'] ,category:m1['category'],id: m1['id'] );
  }
}