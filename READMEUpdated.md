Simple Flask application that outputs hostname and server hits.

Endpoints:
  - /add_user : Adds a user to a mysql database based on the current user and host the application is running.
  - /users : List all users from database.


Notes:
The app now has a docker file which will be deployed via k8s, managed by helm, in managed nodes via EKS which is managed by terraform. There are parts 
of various manifests that aren't completely interpolated, as they were just a tad outside the scope of this project. I may have already scope creeped
a bit in the ask. 
