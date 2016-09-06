Diety 1.0

Description: Diety is a recipe book holder that stores recipes in 5 different categories - breakfast, brunch, lunch, afternoon snack, dinner. 

Login Screen
The user can enter his credentials to login in the app. The app uses Kinvey as BaaS.
If a field is left empty an error is displayed
If the user enters incorrect credentials a suitable error is displayed.
If there is not internet connection, a suitable error is displayed.
When login is pressed the user is segued to the main screen of the app.
When Sign up is pressed the user is segued to the registration scree.

Registration screen
The user can register for the app. After successful registration the user is redirected towards the main screen.
If a field is left empty an error is displayed
If passwords do not match, an error is displayed
If there is not internet connection, a suitable error is displayed.
When the login button is pressed, the user is segued to the Login screen.

Main Screen
The main screen is a tab controller.
When logout is pressed, the user is logout out of the app and returned to the Login/Registration screen.
When add is pressed, the user is redirected to the Add Meal screen.

The featured tab
Shows an image of Diety
Allows user to change theme - theme settings are persisted using NSUserDefaults

The Diety tab
shows the 5 categories - breakfast, brunch, lunch, afternoon snack, dinner
When a user clicks a category, he/she can see the recipes in this category

Add Screen
Add a meal by inputing title, ingredients and category from picker view
If a field is left empty an error is displayed
Meals are stored with CoreData, they are not connected to an account.

Meal Category Screen
Shows all the meals for a given category
If no meals, app displays an appropriate message