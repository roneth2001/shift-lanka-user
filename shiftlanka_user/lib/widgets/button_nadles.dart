// class buttonHandles{
//   Future<void> _handleSignUp(String route) async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       // Simulate API call
//       await Future.delayed(const Duration(seconds: 2));

//       setState(() {
//         _isLoading = false;
//       });

//       // Add your sign up logic here
//       // Navigate to home screen or login screen on success
//       Navigator.pushNamed(context, route);
//     }
// }