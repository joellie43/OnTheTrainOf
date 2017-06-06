# OnTheTrainOf : Nikita Borisov, Dimitriy Leksanov, Joelle Lum
## Flat Land Diner
### Description
Our project is a spinoff of Diner Dash. Users will play as a waiter of a diner, also known as Flo. To seat customers, users can drag them to desired tables. Once customers are seated, timers will start to indicate their level of patience for having their order taken, food served, and food for. By clicking on seated customers, users can serve them. After each interaction with customers, the timers will reset.  After customers have paid for their food, they will automatically leave to the left of the screen. If the user fails to serve a customer before his/her patience runs out, the customer will leave without paying. In fact, the user will be deducted the cost of that customer's order, because the user has wasted food!

The objective of the game is to make $100 before time runs out (100 seconds). Different food have different values, so the game keeps going until this objective is met.

### Key:
Waiter (user) : person
Customer : triangles
Food : concentric circles with centers of different colors according to different foods
Tables : squares of different colors
Timer for each customer : 15 seconds, customer turns gradiates from original color to red (red meaning time has run out and the customer will leave angrily)
Timer for entire game: top right corner
Money Tracker: bottom right corner

### How to play

Click on tables or the left most dish to have the waiter walk to them. 

Click and drag the customer group (customers act in groups of four but are treated as one) at the bottom (front) of the line to a table and release them over it. The other customers will then step down the line. If the customer isn't released over a table then they will go back to the front of the line. After 5 seconds the customers will alert the user with an exclamation mark(10 seconds after the exclamation mark shows up they will leave). Go to their table to take their order them before they turn red and walk out. Then bring them their food and wait for them to be ready to pay with the same patience time restrictions as before. Carry the dirty dish to the white square dishwasher and click once more to put it in the dishwasher and have it disappear

Collect 50 dollars to win the game before you run out of time.

### Queues and ArrayLists within this game

The customers stand in a queue. The first customer to get in line is the first one allowed to get a table. The user is restricted to only selecting the first customer on line by continuously shifting down customers and finding the frontmost spot in line. This maintains a queue. 

The food is also produced in a queue like fashion. When a customer orders food prior to someone else, their food is made first and can only be picked up first. The leftmost food is the front of the queue and the other foods shift down, when it is dequeued.

### Bugs and things to watch out for
If the waiter is at the customer's table but they are still growing more impatient, try going to a different table and coming back. Sometimes it may still be a bit too early for them to order. When they have an exclamation mark hovering over them, they are ready to order, eat, or pay.

If you are having difficulty clicking on the food to pick it up from the kitchen, try clicking on the center of the left most dish(the one you are trying to pick up) or slightly to the left of it.

If user is holding a dish already while going to help a customer pay, there is a glitch because when the user goes to serve
the dish in hand, the finished dish from the customer that pays appears at its side (even though the user is not by the table). This causes dishes to hop tables and stay there until the washing glitch removes them (explained in next bug).

When multiple dishes are lying around, washing just one dish will cause all dishes to disappear (not just the one that was being washed).

## Launch Instructions
1. Have either your terminal or command prompt open.
2. Proceed into the directory where you want our game to reside.
3. Enter this command to clone our repo: 
`git clone git@github.com:joellie43/OnTheTrainOf.git`
4. Enter OnTheTrainOf, and then proceed into the directory titled `sketch_170521a`
5. Type `processing sketch_170521a.pde` into the terminal after having cloned this repo. Make sure that you Processing downloaded in order for this to work.
6. When the processing window opens, click upon the green arrow to run the program.

