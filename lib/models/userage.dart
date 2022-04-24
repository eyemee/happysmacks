class Userage {
 final int age;
 final String bdate;

 Userage({this.age, this.bdate});

 Map<String, dynamic> toMap() {
   return {
     'age': age,
     'bdate': bdate
   };
 }

}