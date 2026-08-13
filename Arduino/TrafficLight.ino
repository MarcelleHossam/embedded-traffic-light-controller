const int RED_PIN = 13;        //pin declarations
const int YELLOW_PIN = 12;    
const int GREEN_PIN = 11;     

void setup() {                //runs only once when arduino starts
  pinMode(RED_PIN, OUTPUT);
  pinMode(YELLOW_PIN, OUTPUT);
  pinMode(GREEN_PIN, OUTPUT);

  Serial.begin(9600);        //Enables Serial Monitor , 9600 = Speed , Without this Serial.println() won't work
}

void loop() {
  // red light on
  digitalWrite(RED_PIN, HIGH);
  digitalWrite(YELLOW_PIN, LOW);
  digitalWrite(GREEN_PIN, LOW);
  Serial.println("STATE: RED (Stopping)");
  delay(5000);  // 5 seconds
  
  // YELLOW Light ON
  digitalWrite(RED_PIN, LOW);
  digitalWrite(YELLOW_PIN, HIGH);
  digitalWrite(GREEN_PIN, LOW);
  Serial.println("STATE: YELLOW (Preparing for GO)");
  delay(2000);  // 2 seconds
  
  // GREEN Light ON
  digitalWrite(RED_PIN, LOW);
  digitalWrite(YELLOW_PIN, LOW);
  digitalWrite(GREEN_PIN, HIGH);
  Serial.println("STATE: GREEN (Go)");
  delay(5000);  // 5 seconds
}