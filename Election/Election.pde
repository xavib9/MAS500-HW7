
final int WINDOW_SIZE = 400;
// how many milliseconds to show each state for
final int MILLIS_PER_STATE= 1000;
 
// will hold our anti-aliased font
PFont font;
// when did we last change states?
int lastStateMillis = 0;
// loads and holds the data in the election results CSV
ElectionData data;
// holds a list of state postal codes
String[] statePostalCodes;
// what index in the statePostalCodes array are we current showing
int currentStateIndex = 0;
int present = 0;
int past = 0;
int j = 0;
int offset = 350;
int step = 25;
/**
 * This is called once at the start to initialize things
 **/
void setup() {
  // create the main window
  size(1125, 500);
  // load the font
  font = createFont("Arial",10,true);
  // load in the election results data
  data = new ElectionData(loadStrings("data/2012_US_election_state.csv"));
  statePostalCodes = data.getAllStatePostalCodes();
  print("Loaded data for "+data.getStateCount()+" states");
}

/**
 * This is called repeatedly
 */
void draw() {
  // reset everything
  smooth();
  background(255);
  j =20;
  int aux = 200;
  String currentPostalCode0 = statePostalCodes[ currentStateIndex ];
  StateData state0 = data.getState(currentPostalCode0);
  past = (int)Math.round(state0.pctForRomney)+30;
  ellipse(j, past, 3, 3);
  fill(50);
  text(state0.name,j,aux);
  fill(50);
  textFont(font,12);
  text(str((int)Math.round(state0.pctForObama))+"%",j,past);
  aux = aux + 20;
  currentStateIndex = (currentStateIndex+1) % statePostalCodes.length;
  // draw the obama title
  fill(50,50,250);  // blue
  text("Obama",525,30);
  //Information for Obama
  for (int i = 0; i < 42; i ++){
    String currentPostalCode = statePostalCodes[ currentStateIndex ];
    StateData state = data.getState(currentPostalCode);
    stroke(0);
    strokeWeight(2);
    present = (int)Math.round(state.pctForObama)+30;
    line(j, past ,j+step ,  present );
    ellipse(j+step, present, 3, 3);
    fill(50);
    text(state.name,j+step,aux);
    fill(50);
    text(str((int)Math.round(state.pctForObama))+"%",j+step,present);
    aux = aux + 20;
    if (aux == 300){
      aux = 200;
    }
    j = j + step;
    past = present;
    currentStateIndex = (currentStateIndex+1) % statePostalCodes.length;
  }
  // draw the romney vote count and title
  fill(201,50,50);  // red
  text("Romney",525,475);
  //Information for Romney
  j =20;
  currentStateIndex = 0;
  String currentPostalCode1 = statePostalCodes[ currentStateIndex ];
  StateData state1 = data.getState(currentPostalCode1);
  past = (int)Math.round(state1.pctForRomney)+offset;
  ellipse(j, past, 3, 3);
  fill(50);
  textFont(font,12);
  text(str((int)Math.round(state1.pctForRomney))+"%",j,past);
  currentStateIndex = (currentStateIndex+1) % statePostalCodes.length;
  for (int i = 0; i < 42; i ++){
    String currentPostalCode = statePostalCodes[ currentStateIndex ];
    StateData state = data.getState(currentPostalCode);
    stroke(0);
    strokeWeight(2);
    present = (int)Math.round(state.pctForRomney)+offset;
    line(j, past ,j+step ,  present );
    ellipse(j+step, present, 3, 3);
    fill(50);
    text(str((int)Math.round(state.pctForRomney))+"%",j+step,present);
    j = j + step;
    past = present;
    currentStateIndex = (currentStateIndex+1) % statePostalCodes.length;
  }
  delay(1000);

 
}
