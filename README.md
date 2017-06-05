# OnTheTrainOf : Nikita Borisov, Dimitriy Leksanov, Joelle Lum
## Flat Land Diner

Our project is a spinoff of Diner Dash. Users will play as a waiter of a diner. To seat customers, users are to drag them to desired tables. Once customers are seated, timers will start to indicate their level of patience for having their order taken, food served, check given, and check paid for. By clicking on the tables/food counter, users can interact with customers and pick up food to be served. After each interaction with customers, the timers will reset. If the user fails to serve a customer before his/her patience runs out, the customer will leave without paying.  After customers have paid for their food, they will automatically leave.

The objective of the game is to make $50 before time runs out. Different food values provide different sums of money, so the game keeps going until this objective is met.

Key:
Waiter (user) : person
Customer : triangles
Timer for each customer : exclamation mark (turns from green to yellow to red, red meaning time ran out)
Food : concentric circles with centers of either pink, green, or crimson to represent ham, lettuce, and sausage.
Tables : squares of different colors
Top right square that displays a time: Timer

## How to play

## Queues and ArrayLists within this game


## Bugs and things to watch out for
If the waiter is at the customer's table but they are still growing more impatient, try going to a different table and coming back. Sometimes it may still be a bit too early for them to order. When they have an exclamation mark hovering over them, they are ready to order, eat, or pay.

If you are having difficulty clicking on the food to pick it up from the kitchen, try clicking on the center of the left most dish(the one you are trying to pick up) or slightly to the left of it.

## Launch Instructions
1. Have either your terminal or command prompt open.
2. Proceed into the directory where you want our game to reside.
3. Enter this command to clone our repo: 
`git clone git@github.com:joellie43/OnTheTrainOf.git`
4. Enter OnTheTrainOf, and then proceed into the directory titled `sketch_170521a`
5. Type `processing sketch_170521a.pde` into the terminal after having cloned this repo. Make sure that you Processing downloaded in order for this to work.
6. When the processing window opens, click upon the green arrow to run the program.

