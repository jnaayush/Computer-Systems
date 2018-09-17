----------------------
Addition as part 3
----------------------
We added a new GUI View to the program. We added a new case in old ViewFactory.
GUIView.java - This is the our GUIView for the program. It implements the View interface and extends the ViewImpl.
     It has two inner classes:
     1. GUIFrame - It makes and populates the gui elements on the frame.
     2. AnimationFrame - Inner class to the GUI view which does the dynamic changes.

TweenUtils.java - It has a static method which does the tweeing for all the attributes of the animation.


-----
Main
----
Main method consists of two parts, one is the:
EasyAnimator.java - starting point of our program.
StringParser.java - Parses the command line arguments, creates model, view, controller and gives
command to controller with the model and view.

Utils Package
-------------

Contains the file reader, model builder and View Factory
The file reader and model builder are from the previous part.

ViewFactory.java - acts are a factory class for the view and generates the view and passes it to the
 controller based on the type of view requested.

-----------------------------------------------------

For this part we have created Controller, ModelView and the View.

------------------------------------------------------

Controller
----------
Controller.java - acts as the controller for the program. Takes in a model and pass the model which
is packages with only the getters to the view.

-------------------------------------------------------------

View

-------------------------------------------------------------
View.java
This is the interface for the view and has a method to generate the view.


ViewImpl.java
This is the implementation of the View, and also the abstract class containing common code.

TextView.java
This is the text view of the program. It access the data in the model through the view model and
generates the formatted string based on the text view. It write the output to the file based on the
output file which is mentioned.

SvgView.java
This is the svg view of the program. It access the data in the model through the view model and
generates the formatted string based on the svg view.  It write the output to the file based on the
output file which is mentioned.

----------------------------------------------------------------------------

-----------------------------------------------------------

VIew Model

-----------------------------------------------------------
 This is the major change we did to the program.

 ViewModel is used to allow access to the view of the model. But the view can only access the data
 in the model to read it. The view cannot mutate the data.
 The maps containing the shapes and shapeAnimation are cloned and populated with shapeWithGetters
 and shapeAnimationGetters.

 ViewModel.java - The interface for the view model declaring the getter methods.

 ViewModelImpl - It implements the view model interface.

 ShapeWithGetters - this has only the getter methods which can be called on shape, the view is
 allowed access to the shapes through this and hence cannot change the data.

  ShapeAnimationWithGetters - this has only the getter methods which can be called on animations,
  the view is allowed access to the animations through this and hence cannot change the data.

---------------------------------------------------------------

Model

----------------------------------------------------------------

Shape.java
Shape is our Interface that handles all of the information that needs to be gotten and set about the shape by itself.
This includes:
Name – the shapes unique identifier
Anchor – where the shape’s position is derived from. This gives us more flexibility in positioning later.
Position – where the shapes anchor is located
Show Time – when the shape appears. Chose to use double in case milliseconds become important.
Hide Time – when the shape disappears. Chose to use double in case milliseconds become important.
Color – the color of the shape
Height – the height of the shape. This includes round shapes vertical diameter.
Width – the width of the shape. This includes round shapes horizontal diameter.
Type – the type of shape (e.g. “rectangle”, “circle”, etc.)
All of these have getters and setters in the Interface except for the name, type, and the hide/show times. We did not want to alter these, specifically the name as the name will be used as a key in a Map and is unique to each shape.

ShapeImpl.java
The abstract class that will be the base for all of our shapes that implements the Shape interface.  This declares all of the fields described above but the type which is given in the classes that extend this class. This also has a toString method that builds out the information that already exists for the shape for printing later.

Square.java and Oval.java
Classes that extend the ShapeImpl class and give the shape a type. They also complete the string representations of the shape in their toString.

ShapeAnimation.java
This is our Animation interface. It has the methods that get the shared data an animation stores which includes:
Name – the name of the shape the animation is a part of.
Start time – the time the animation starts
End time – the time the animation ends.
The name will be used to get the other starting information of the shape at the time the animation starts. This will be done in the ShapeMapImpl class. This also extends comparable because we will sort the animations later by start time to  print them out in order.

ShapeAnimationImpl.java
This is the abstract class that implements the ShapeAnimation Interface. It will implement all of the getter methods and make the constructor for the shared information that all animations have.

Resize.java
Extends ShapeAnimationImpl and adds fields for the original and new width and height. This class represents a shape changing its dimensions.

Translate.java
Extends ShapeAnimationImpl and adds fields for the new and old location of the anchor. This class represents a shape moving.

Recolor.java
Extends ShapeAnimationImpl and adds fields for the new and old color. This class represents a change in color of the shape.

ShapeMap.java
This is our Interface that creates the methods to add and remove shapes and animations and display their information.

ShapeMapImpl.java
This class implements ShapeMap and is our main model class.  It stores the shapes and animations in HashMap fields.  We chose to use HashMaps because the name of the shapes was unique and made for a perfect key to access the info quickly. The shapes can have multiple animations so we saved those in the map as a list. This is what also drove us to give animations the shapes name as a field.

AnchorPoint.java
This enumeration indicates our binding points for our shapes.  Rather than have a default location we use for reference, we allow the user to pick that point on the shape.







