/*
 * Pin connection between Arduino Mega and HC-SR04 Ultrasonic sensor
 *  Arduino Mega pin 2 -> HC-SR04 trig
 *  Arduino Mega pin 3 -> HC-SR04 echo
 *  Arduino Mega GRD -> HC-SR04 GRD
 *  Arduino Mega 5V -> HC-SR04 VCC
*/
void setup() {
  Serial.begin (9600);
  int trigPin = 2;
  int echoPin = 3;
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  digitalWrite(echoPin, HIGH);
}
void loop() {
  // Distance
  float duration, distance;
  digitalWrite(trigPin, LOW);     // Added this line
  delayMicroseconds(2);           // Added this line
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);          // Added this line
  digitalWrite(trigPin, LOW);
  //delayMicroseconds(300);
  distance = pulseIn(echoPin, HIGH);
  distance = (distance / 2.0) / 29.1;
  Serial.print(distance, 3);
  Serial.println(" cm");
  delay(500);
}

