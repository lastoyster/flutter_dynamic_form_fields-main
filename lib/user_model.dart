void main() {
  // JSON data representing a user
  Map<String, dynamic> userData = {
    "UserName": "Raman",
    "UserAge": 30,
    "Emails": ["pratk95@proton.me", "pk65@gmail.com"]
  };

  // Create a UserModel instance from JSON data
  UserModel user = UserModel.fromJson(userData);

  // Print the user data
  print("User Name: ${user.userName}");
  print("User Age: ${user.userAge}");
  print("Emails: ${user.emails}");

  // Convert UserModel instance back to JSON
  Map<String, dynamic> jsonUser = user.toJson();

  // Print the JSON data
  print("JSON User Data: $jsonUser");
}
