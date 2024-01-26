import 'user.dart';

class UserRepository {

  List<User> users = [];

  // Methoden zum adden, updatem, deleten etc 

  void addUser(User user) {
    users.add(user);
  }


  void deleteItem(User user) {
    users.remove(user);
  }



  void editItem(User user, String newPassword) {
  
    final index = users.indexOf(user);
    if (index != -1) {
      users[index].userPassword = newPassword;  
    }
  }
}