import de.bezier.data.sql.mapper.*;  // import NameMapper to map database names to instance names
import de.bezier.data.sql.*;  // import the MySQL library
import processing.serial.*;   // import the Serial library

MySQL msql;          // Create MySQL Object named msql.
Serial port;         // Created Serial object named port.
String username;     // Username of MySQL
String password;     // Password of MySQL
String dbHost;       // Host of database in MySQL
String database;     // Name of database in My SQL
final int breakChar = 10;    // Set the last character to be 10 (ASCII for linefeed) to break up individual messages.
final int baudR = 115200;    // Baud rate
String serial;       // Declare serial to keep string that is read from port.
String currentTime = "";     // Declare currentTime to keep string of current time.
int count = 0;       // Keep track and display on monitor for checking correctness.

/**
* This function is used to set up and initialize objects and variables that need to use in execution.
*/
void setup() {
  username = "LJMU";        // Username of MySQL
  password = "1234";        // Password of MySQL
  dbHost = "localhost";     // Host of database in MySQL
  database = "iot";         // Name of database in My SQL
  
  msql = new MySQL( this, dbHost, database, username, password );    // Initialize MySQL object to create the connection.
    
  port = new Serial(this, Serial.list()[0], baudR);   // Initialize serial object by assigning a port and baud rate.
  port.clear();  // Clear the first reading, in case we started reading in the middle of a string from Arduino.
  serial = port.readStringUntil(breakChar); // function that reads the string from serial port until a println and then assigns string to our string variable (called 'serial')
  serial = null; // initially, the string will be null (empty);
}

/**
* This function is used to execute
*/
void draw() 
{
  while (port.available() > 0) 
  { 
    //as long as there is data coming from serial port, read it and store it 
    serial = port.readStringUntil(breakChar);
  }
    if (serial != null) 
    {  
      // remove newline "\r\n"
      serial = serial.substring(0,serial.length()-2);
      //if the string is not empty, print the following
      int h = hour();
      int m = minute();
      int s = second();
      currentTime = h+":"+m+":"+s; // get the current time
      exeQuery(); 
    }
    delay(1000);
}

void exeQuery()
{
  if ( msql.connect() )
    {
        println(serial);
        msql.query( "insert into dataDistance(CurrentTime,Distance)values(\""+currentTime+"\",\""+serial+"\")" );
        count++;
        println("id: "+ count);
    }
    else
    {
        // connection failed !
        println("Can't connect to MySQL");
    }
    msql.close();  //Must close MySQL connection after Execution
}
