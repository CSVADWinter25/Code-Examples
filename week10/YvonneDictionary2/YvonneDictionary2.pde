import java.net.*;
import java.io.*;
import controlP5.*;

int cols = 15;
int rows = 15;
float cellSize;
String inputText = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?@#$%^&*"; // Default text
float[][] noiseValues;
ControlP5 cp5;
Textfield inputField;
float timeFactor = 0;
int lastUpdateTime = 0;
int updateInterval = 8; 
ArrayList<PVector> trail = new ArrayList<>();
int trailLength = 10;
float transitionFactor = 0.5;

void setup() {
  size(800, 800);
  frameRate(30);
  cellSize = width / cols;
  noiseValues = new float[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      noiseValues[i][j] = random(1000);
    }
  }

  cp5 = new ControlP5(this);

  cp5.addSlider("transitionFactor")
     .setPosition(550, height - 40)
     .setSize(150, 20)
     .setRange(0, 1)
     .setValue(0.5)
     .onChange(new CallbackListener() {
       public void controlEvent(CallbackEvent event) {
         transitionFactor = event.getController().getValue();
       }
     });

  inputField = cp5.addTextfield("Input Text")
                  .setInputFilter(ControlP5.STRING)
                  .setPosition(20, height - 40)
                  .setSize(300, 30)
                  .setFont(createFont("Arial", 18))
                  .setAutoClear(false);
}

// ✅ Detect ENTER key press to update `inputText` immediately
void keyPressed() {
  if (key == ENTER || key == RETURN) {
    String userInput = inputField.getText().trim();
    if (!userInput.isEmpty()) {
      inputText = userInput;  // ✅ Instantly update `inputText`
      fetchDefinition(userInput);  // ✅ Fetch definition immediately
    }
  }
}

void fetchDefinition(String word) {
  if (word.isEmpty()) return;

  String apiUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/" + word;
  String jsonData = fetchJSON(apiUrl);

  if (jsonData != null && !jsonData.equals("")) {
    parseDictionaryResponse(jsonData);
  } else {
    inputText = "Definition not found.";
  }

}

// HTTP Request function
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
        inputText = definitionsArray.getJSONObject(0).getString("definition"); // ✅ **Update `inputText` immediately**
      }
    }
  }
}

void draw() {
  background(255, 200, 220);
  timeFactor += 0.05;

  trail.add(new PVector(mouseX, mouseY));
  if (trail.size() > trailLength) {
    trail.remove(0);
  }

  if (millis() - lastUpdateTime > updateInterval) {
    lastUpdateTime = millis();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        float baseX = i * cellSize + cellSize / 2;
        float baseY = j * cellSize + cellSize / 2;

        float waveX = baseX + map(noise(noiseValues[i][j] + timeFactor), 0, 1, -30, 30);
        float waveY = baseY + map(noise(noiseValues[i][j] + timeFactor + 1000), 0, 1, -30, 30);
        float x = lerp(baseX, waveX, transitionFactor);
        float y = lerp(baseY, waveY, transitionFactor);

        float d = dist(mouseX, mouseY, x, y);

        for (PVector t : trail) {
          float trailDist = dist(t.x, t.y, x, y);
          if (trailDist < cellSize * 1.2) {
            d = trailDist;
          }
        }

        float noiseValue = noise(noiseValues[i][j]);
        float sizeFactor = map(noiseValue, 0, 1, 0.5, 1.1);
        float alpha = map(noiseValue, 0, 1, 150, 255);

        char displayChar = inputText.charAt(int(random(inputText.length())));

        if (d < cellSize * 1.2) {
          sizeFactor *= map(d, 0, cellSize * 4, 1.5, 1);
          alpha *= map(d, 0, cellSize * 2, 255, 150);
          displayChar = inputText.charAt((i + j) % inputText.length());
        }

        float hueShift = map(noise(timeFactor), 0, 1, 0, 255);
        float yellowIntensity = map(d, 0, cellSize * 2, 50, 80); // Closer to mouse is brighter yellow
        float trailIntensity = 255 - map(d, 0, cellSize * 2, 50, 80); // Further in trail is lighter yellow
        if (d < cellSize * 2) {
          fill(255, yellowIntensity, 100, alpha); // Brighter yellow near mouse
        } else {
          fill(50, 100, 255, alpha); // Keep rest of the text fully blue
        } // Dynamic color shift // Blue text with transparency
        textSize(cellSize * sizeFactor);
        text(displayChar, x, y);
      }
    }
  }
}
