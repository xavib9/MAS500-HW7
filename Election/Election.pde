/**
 * Example that loads up election data and draws something with it.
 * @author Rahul Bhargava
 */
 
// this is needed to do anti-aliased fonts
PFont font;
// how big to make the square window
final int WINDOW_SIZE = 400;
// how many milliseconds to show each state for
final int MILLIS_PER_STATE= 1000;
// when did we last change states?
int lastStateMillis = 0;
// loads and holds the data in the election results CSV
ElectionData data;
// holds a list of state postal codes
String[] statePostalCodes;
// what index in the statePostalCodes array are we current showing
int currentStateIndex = 0;

/**
 * This is called once at the start to initialize things
 **/
void setup() {
  // create the main window
  size(WINDOW_SIZE, WINDOW_SIZE);
  // load the font
  font = createFont("Arial",36,true); // STEP 3 Create Font
  // load in the election results data
  data = new ElectionData(loadStrings("data/2012_US_election_state.csv"));
  statePostalCodes = data.getAllStatePostalCodes();
  print("Loaded data for "+data.getStateCount()+" states");
}

/**
 * This is called repeatedly
 */
void draw() {
  // check if it is time to update the display
  if (millis() - lastStateMillis >= MILLIS_PER_STATE) {
    // reset everything
    smooth();
    background(0);
    fill(255);
    textFont(font,36);
    textAlign(CENTER);
    // draw the state name
    String currentPostalCode = statePostalCodes[ currentStateIndex ];
    StateData state = data.getState(currentPostalCode);
    text(state.name,WINDOW_SIZE/2,WINDOW_SIZE/4);
    // draw the obama vote count name
    fill(50,50,250);
    text("Obama",WINDOW_SIZE/4,WINDOW_SIZE/2);
    text(Math.round(state.pctForObama)+"%",WINDOW_SIZE/4,3*WINDOW_SIZE/4);
    // draw the romney vote count
    fill(201,50,50);
    text("Romney",3*WINDOW_SIZE/4,WINDOW_SIZE/2);
    text(Math.round(state.pctForRomney)+"%",3*WINDOW_SIZE/4,3*WINDOW_SIZE/4);
    // update which state we're showing
    currentStateIndex = (currentStateIndex+1) % statePostalCodes.length;
    // update the last time we drew a state
    lastStateMillis = millis();
  }
}

