# OnTheTrainOf : Nikita Borisov, Dimitriy Leksanov, Joelle Lum
## Flat Land Diner
### Description
Our project is a spinoff of Diner Dash. Users will play as a waiter of a diner, also known as Flo. To seat customers, users can drag them to desired tables. Once customers are seated, timers will start to indicate their level of patience for having their order taken, food served, and food for. By clicking on seated customers, users can serve them. After each interaction with customers, the timers will reset.  After customers have paid for their food, they will automatically leave to the left of the screen. If the user fails to serve a customer before his/her patience runs out, the customer will leave without paying. In fact, the user will be deducted the cost of that customer's order, because the user has wasted food!

The objective of the game is to make $50 before time runs out (100 seconds). Different food have different values, so the game keeps going until this objective is met.

### Key:
* Waiter (user) : person
* Customer : triangles
* Signal that customer needs waiter : exclamation point that appears 5 seconds after each interaction with user
* Food : concentric circles with centers of different colors according to different foods
* Tables : squares of different colors
* Timer for each customer : 15 seconds, customer turns gradiates from original color to red (red meaning time has run out and the customer will leave angrily)
* Timer for entire game: top right corner
* Money Tracker: bottom right corner
* Dish Washer: gray box near top right corner

### How to play

1. Click on tables or the left most dish to have the waiter walk to them. 
2. Drag customers (customers appear in groups of four but are treated as one) from the bottom (front) of the line to a table to seat them. The other customers will then step down the line. 
3. If a customer isn't released over a table then they will go back to the front of the line. 
4. Starting after they are seated, customers will alert the user with an exclamation mark that they want to be served. This exclamation mark appears 5 seconds after each interaction with the user. 
5. After exclamation marks appear, customers will wait 10 seconds before getting angry and leaving the diner without paying. Go to their table to take their order. 
6. Then bring them their food and wait for them to finish their meal and are ready to pay. 
7. Click on the customer again to help them pay. After they pay, customers will leave. 
8. Click on the table to carry the dirty dish to the gray square dishwasher and click once more on the dishwasher to put it in the dishwasher and have it disappear.
9. Collect 50 dollars to win the game before you run out of time (100 seconds).

### Queues and ArrayLists within this game

The customers stand in a queue. The first customer to get in line is the first one allowed to get a table. The user is restricted to only selecting the first customer on line by continuously shifting down customers and finding the frontmost spot in line. This maintains a queue. 

The food is also produced in a queue like fashion. When a customer orders food prior to someone else, their food is made first and can only be picked up first. The leftmost food is the front of the queue and the other foods shift down, when it is dequeued.

### Bugs and things to watch out for
If the waiter is at the customer's table but they are still growing more impatient, try going to a different table and coming back. Sometimes it may still be a bit too early for them to order. When they have an exclamation mark hovering over them, they are ready to order, eat, or pay.

If user is holding a dish already while going to help a customer pay, there is a glitch because when the user goes to serve
the dish in hand, the finished dish from the customer that pays appears at its side (even though the user is not by the table). This causes dishes to hop tables and stay there until the washing glitch removes them (explained in next bug).

Hint:
When multiple finished dishes are lying around, if the user has come in contact with more than one finished dish, washing the dish in the user's hands will cause all dishes that the user has gone to to disappear (not just the one that was in the user's hands.

## Launch Instructions
1. Have either your terminal or command prompt open.
2. Proceed into the directory where you want our game to reside.
3. Enter this command to clone our repo: 
`git clone git@github.com:joellie43/OnTheTrainOf.git`
4. Enter OnTheTrainOf, and then proceed into the directory titled `FlatLandDiner`
5. Type `processing FlatLandDiner.pde` into the terminal after having cloned this repo. Make sure that you Processing downloaded in order for this to work.
6. When the processing window opens, click upon the green arrow to run the program.
Enjoy!
