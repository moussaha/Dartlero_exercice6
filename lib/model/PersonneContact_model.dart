part of dartlero_exercice6;

class Personne { 
  // Les propriétés de la personne: 
  String _name, _email, _phone; 
  DateTime _date_birth; 
 
  String get name => _name;
  set name(value) { 
    if (value != null && !value.isEmpty) _name = value; 
  } 
 
  String get email => _email; 
  set email(value) { 
    if (value != null && !value.isEmpty) _email = value; 
  } 
  
  String get phone => _phone; 
    set phone(value) { 
      if (value != null && !value.isEmpty) _phone = value; 
    } 

  DateTime get date_birth =>  _date_birth; 
  set date_birth(value) { 
    DateTime now = new DateTime.now(); 
    if (value.isBefore(now)) _date_birth = value; 
  } 
    
  
  Personne.fromJson(Map json) { 
      this.name = json["name"]; 
      this.phone = json["phone"]; 
      this.email = json["email"]; 
      this.date_birth = DateTime.parse(json["birthdate"]); 
} 

  Map<String, Object> toJson() {
    var per = new Map<String, Object>(); 
    per["name"] = name;
    per["phone"] = phone;
    per["email"] = email;
    per["birthdate"] = date_birth.toString();
    return per;
  }
  
  // constructeur: 
  Personne(name, email, phone, date_birth) { 
    this.name = name; 
    this.email = email; 
    this.phone = phone; 
    this.date_birth = date_birth; 

  } 
  String toString() => 'Personne: $name, $email'; 
} 
