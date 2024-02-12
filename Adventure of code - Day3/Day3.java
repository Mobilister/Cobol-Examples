package Day3;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class Day3 {

    int SIZE = 200;
    String filePath = "day3.txt";
    boolean isNumberBuildingInProgress = false;
    int currentNumber = 0;
    int sum = 0;
    String[] buf = new String[3];

    public Day3() {

        /** Initiera med lite tomma tecken o så.. */

        for (int i = 0; i < 3; i++) {
            buf[i] = new String(new char[SIZE]).replace('\0', ' ');
        }

        /** Läs filen **/

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;

            while ((line = reader.readLine()) != null) {
                process(line);
            }

            // Vi behöver läsa in en tom "dummy" rad i slutet för att kunna köra vår
            // ootroligt smarta algoritm
            process(new String(new char[SIZE]));

            // Skriv ut summan
            System.out.println("Summan blir: " + sum);
        }

        catch (IOException e) {
            System.err.println("Det uppstod ett fel vid läsning av filen: " + e.getMessage());
        }

    }

    /**
     * Den här funktionen processerar en rad som blivit inläst
     */

    private void process(String line) {

        /*
         * Ny rad läses in i buffer 3, övriga skiftar uppåt
         * den raden vi arbetar med är alltid buffer nummer 2
         */

        buf[0] = buf[1];
        buf[1] = buf[2];
        buf[2] = " " + line.replace(".", " ") + "  ";

        /*
         * Obs.. vi lägger till ett tomt tecken i slutet för att slippa hålla på att
         * kolla gränser
         * Lazy I knowww.....
         */

        for (int i = 1; i < buf[1].length() - 1; i++) {

            if (buf[1].substring(i, i + 1).matches("\\d+")) {
                isNumberBuildingInProgress = true;
                currentNumber = (currentNumber * 10) + Character.getNumericValue(buf[1].charAt(i));
            }

            /*
             * Ok, Vi har börjat bygga ett nummer och nu verkar numret vara slut.. vad gör
             * vi?
             */

            else if (isNumberBuildingInProgress) {
                // Nu kollar vi om det finns några specialtecken
                if (checkSpecialCharacter(i - Integer.toString(currentNumber).length() - 1, i, buf)) {
                    sum += currentNumber;
                } 
                /** Nollställ variabel för nummer och och markera att vi slutat sätta ihop ett nummer */
                currentNumber = 0;
                isNumberBuildingInProgress = false;
            }

        }
    }

    /**
     * Funktionen söker från höger till vänster tre tecken "åt gången" efter ett
     * specialtecken
     * Så fort något specialtecken hittas så returneras true
     */

    private boolean checkSpecialCharacter(int start, int stop, String[] buf) {

        /** Matchar alla tecken utom siffror och space */
        for (int j = 0; j <= 2; j++) {
            for (int i = start; i <= stop; i++) {
                if (buf[j].substring(i, i + 1).matches("[^0-9 ]")) {
                    return true;
                }
            }
        }
        return false;
    }
}
