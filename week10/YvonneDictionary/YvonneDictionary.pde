import java.net.*;
import java.io.*;
import controlP5.*;

ControlP5 cp5;
Textfield textField;
String inputWord = "hello";  // Default word
String definition = "Enter a word and press ENTER.";

void setup() {
  size(600, 400);
  
  // Create input field
  cp5 = new ControlP5(this);
  textField = cp5.addTextfield("inputWord")
                 .setPosition(20, 20)
                 .setSize(200, 30)
                 .setFont(createFont("Arial", 16))
                 .setAutoClear(false)
                 .setFocus(true)
                 .setColorForeground(color(100, 100, 255)) // Highlight when active
                 .setColorBackground(color(240)) 
                 .setColorValue(color(0));
  
  fetchDefinition(inputWord);  // Fetch default word at startup
}

void draw() {
  background(255);
  fill(0);
  textSize(20);
  text("Word: " + inputWord, 20, 80);
  text("Definition:", 20, 110);
  text(definition, 20, 140, width - 40, height - 140);
}

// Detect ENTER key press to trigger search
void keyPressed() {
  if (key == ENTER || key == RETURN) {
    inputWord = textField.getText().trim();
    fetchDefinition(inputWord);
  }
}

// Fetch dictionary data
void fetchDefinition(String word) {
  if (word.isEmpty()) return;  // Ignore empty input
  
  String apiUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/" + word;
  String jsonData = fetchJSON(apiUrl);
  
  if (jsonData != null && !jsonData.equals("")) {
    parseDictionaryResponse(jsonData);
  } else {
    definition = "Definition not found.";
  }
}

// HTTP request function
String fetchJSON(String urlString) {
  try {
    URL url = new URL(urlString);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");

    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    StringBuilder response = new StringBuilder();
    String line;
    
    while ((line = reader.readLine()) != null) {
      response.append(line);
    }
    reader.close();
    
    return response.toString();
  } catch (Exception e) {
    e.printStackTrace();
    return null;
  }
}

// Parse API response
void parseDictionaryResponse(String json) {
  JSONArray wordData = parseJSONArray(json);
  
  if (wordData != null && wordData.size() > 0) {
    JSONObject firstEntry = wordData.getJSONObject(0);
    JSONArray meanings = firstEntry.getJSONArray("meanings");
    
    if (meanings.size() > 0) {
      JSONObject firstMeaning = meanings.getJSONObject(0);
      JSONArray definitionsArray = firstMeaning.getJSONArray("definitions");
      
      if (definitionsArray.size() > 0) {
        definition = definitionsArray.getJSONObject(0).getString("definition");
      }
    }
  }
}
