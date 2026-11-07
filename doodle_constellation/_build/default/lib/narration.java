import java.*.utils;
import java.Scanner;
import java.io.File;
import java.util.Scanner;

public class narration(){
    HashMap<String, String> dataset = new HashMap();

    public narration(){
        File file = new File("Constellations.txt");
        try(Scanner myReader = new Scanner(file)){
            while(myReader.hasNextLine()){
                //process each line here.
                //name is from index 0 to ".", "." will be used to divide the name and the narration
                String name = myReader.nextLine().substring(0, myReader.indexOf("."));
                String narrate = myReader.nextLine().substring(myReader.indexOf(".")+1);

                dataset.put(name, narrate);
            }
        } catch(FileNotFoundException e){
            System.out.println("An error occured due to a file issue");
            e.printStackTrace();
        }
    }

    public getStory(String constellationName){
        return dataset.get(constellationName);
    }

    //for debuging if needed
    public static HashMap<String, String> getDataset() {
        return dataset;
    }
}