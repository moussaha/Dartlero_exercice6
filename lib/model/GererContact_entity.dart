part of dartlero_exercice6;

class GererContact { 
  String _numero; 
  Personne proprietaire; 
  int _pin_code; 
  final DateTime date_created; 
  DateTime date_modified; 


  String get numero => _numero; 
  set numero(value) { 

    if (value == null || value.isEmpty) 
        throw new ArgumentError("Pas de valeur de No retournée"); 
    
    // Tester le formatage
    var exp = new RegExp(r"[0-9]{3}-[0-9]{7}-[0-9]{2}"); 
    if (exp.hasMatch(value)) _numero = value; 
  } 

  int get code_pin => _pin_code; 
  set code_pin(value) { 
    if (value >= 1 && value <= 999999) _pin_code = value; 
  } 
  
  
  GererContact.fromJson(Map json):  date_created = DateTime.parse(json["creation_date"]) { 
      this.numero = json["numero"]; 
      this.proprietaire = new Personne.fromJson(json["proprietaire"]); 
      this.code_pin = json["code_pin"]; 
      this.date_modified = DateTime.parse(json["modified_date"]); 
    } 
  GererContact.fromJsonString(String jsonString): this.fromJson(JSON.decode(jsonString)); 

 
  Map<String, Object> toJson() {
    var acc = new Map<String, Object>();
    acc["numero"] = numero;
    acc["proprietaire"] = proprietaire.toJson();
    acc["code_pin"] = code_pin;
    acc["creation_date"] = date_created.toString();
    acc["modified_date"] = date_modified.toString();
    return acc;
  }
  
  // constructeurs: 
  GererContact(this.proprietaire, numero, code_pin): date_created = new DateTime.now() { 
    this.numero = numero; 
    this.code_pin = code_pin; 
    date_modified = date_created;
  } 

  String toString() => 'Gestion Contact par $proprietaire avec numero $numero'; 
} 










