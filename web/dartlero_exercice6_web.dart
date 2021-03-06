import 'dart:html';
import 'dart:convert';
import 'package:dartlero_exercice6/dartlero_exercice6.dart';

InputElement _name, email, phone, numero, birth_date, code_pin; 
ButtonElement btn_creer, btn_supprimer, btn_modifier; 

Personne per = new Personne(_name.value, email.value, phone.value, DateTime.parse(birth_date.value));
GererContact contact = new GererContact(per, numero.value, int.parse(code_pin.value)); 

List listContacts;
String select, donnee; 
SelectElement sel; 
TableElement table; 
GererContact _contact; 

void main() {
  
   _name = querySelector('#_name'); 
  email = querySelector('#email'); 
  numero = querySelector('#numero');
  phone = querySelector('#phone'); 
  birth_date = querySelector('#birth_date');
  code_pin = querySelector('#code_pin');
  
  btn_creer = querySelector('#btn_creer');
  btn_supprimer = querySelector('#btn_supprimer');
  btn_modifier = querySelector('#btn_modifier');

    // Attacher les évènements : 
    // Vérifier si mes attributs sont vides ou non sur l'évènement onBlur: 
    _name.onBlur.listen(notEmpty); 
    email.onBlur.listen(notEmpty); 
    phone.onBlur.listen(notEmpty); 
    numero.onBlur.listen(notEmpty);
    code_pin.onBlur.listen(notEmpty);
    
    birth_date.onChange.listen(notInFuture); 
    birth_date.onBlur.listen(notInFuture); 

    // Créer, supprimer et modifier le contact: 
    btn_creer.onClick.listen(enregistrerDonnee); 
    btn_supprimer.onClick.listen(supprimerDonnee);
    btn_modifier.onClick.listen(ModifierContact);
    
    
lireBDLocal();
constructPage();
sel.onChange.listen(voirContacts);
    
}

notEmpty(Event e) { 
      InputElement inel = e.currentTarget as InputElement; 
      var input = inel.value; 
      if (input == null || input.isEmpty) { 
       // window.alert("Tous les champs doivent être remplis ${inel.id}!"); 
        inel.focus(); 
      }
    } 

notInFuture(Event e) { 
  DateTime birthDate; 
  try { 
    birthDate = DateTime.parse(birth_date.value); 
  } on ArgumentError catch(e) { 
    window.alert("Cette date n'est pas valide!"); 
    birth_date.focus();
    return; 
  } 
  DateTime now = new DateTime.now(); 
  if (!birthDate.isBefore(now)) { 
    window.alert("La date ne peut être dans le futur!"); 
    birth_date.focus(); 
  } 
} 

enregistrerDonnee(Event e) { 
// Enregitrer données dans la BD local: 
try { 
 window.localStorage["GererContact:${per.phone}"] = JSON.encode(contact.toJson()); 
 window.alert("Les données du contact sont stockées dans le navigateur."); 
} on Exception catch (ex) { 
 window.alert("Donnée non stokée: La BD locale a été désactivée!"); 
  } 
} 

supprimerDonnee(Event e) => supprimer(); 

supprimer() { 
  window.localStorage.remove("GererContact:${per.phone}");
  _name.value = ""; 
    email.value = "";
     phone.value = ""; 
     birth_date.value = "";
     code_pin.value = "";
     numero.value = ""; 
  _name.focus(); 
}

ModifierContact(Event e) { 
  try {
  window.localStorage["GererContact:${per.phone}"] = JSON.encode(contact.toJson()); 
  } on Exception catch (ex) { 
    window.alert("Donnée non modifiée dans La BD locale!"); 
 } 
  // disable refresh screen: 
  e.preventDefault(); 
  e.stopPropagation(); 
} 

lireBDLocal() { 
  listContacts = []; 
  if (window.localStorage.isNotEmpty){
  for (var cle in window.localStorage.keys) { 
      listContacts.add(cle.substring(13)); 
  } 
 } 
} 

constructPage() { 
// make dropdown list and fill with data: 
  var el = new Element.html(constructSelect()); 
  document.body.children.add(el); 

// preparer la table html pour l'information du contact: 
  var el1 = new Element.html(constructTable()); 
  document.body.children.add(el1); 

  sel = querySelector('#contacts'); 
  table = querySelector('#accdonnee'); 
  table.classes.remove('border'); 
} 


String constructSelect() { 
  var sb = new StringBuffer(); 
  sb.write('<select id="contacts">'); 
  sb.write('<option selected>Selectionner un contact:</option>'); 
  listContacts.forEach( (acc) => sb.write('<option>$acc</option>')  ); 
  sb.write('</select>'); 
  
  return sb.toString(); 
} 

 
String constructTable() { 
  var sb = new StringBuffer(); 
  sb.write('<table id="accdonnee" class="border">'); 
  sb.write('</table>'); 

  return sb.toString(); 
} 


voirContacts(Event e) { 
  table.children.clear(); 
  table.classes.remove('border'); 

  // Retourner numero selectionne: 
  sel = e.currentTarget; 
  if (sel.selectedIndex >= 1) { // un contact a été choisi 
   
    var listContact = listContacts[sel.selectedIndex - 1]; 

    var cle = 'GererContact:$listContact'; 
    String acc_json = window.localStorage[cle]; 
    _contact = new GererContact.fromJsonString(acc_json); 
    
    // Voir donnees: 
    table.classes.add('border'); 
    
    _name.value = _contact.proprietaire.name; 
    email.value = _contact.proprietaire.email;
     phone.value = _contact.proprietaire.phone; 
     birth_date.valueAsDate = _contact.proprietaire.date_birth;
     code_pin.value = _contact.code_pin.toString();
     numero.value = _contact.numero;
    
  } 
} 







