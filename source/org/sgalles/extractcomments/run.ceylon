import ceylon.file {
    parsePath,
    Directory,
    File,
    Resource
}
shared void runEnglish() { run("en"); }

shared void runSpanish() { run("es"); }

shared void runFrench() { run("fr"); }

"Run the module `org.sgalles.extractcomments`."
void run(String lang) {
    
    Resource fileDir = parsePath("""../ceylon-walkthrough/source/""" + lang).resource;
    assert(is Directory fileDir);
    for(value file in fileDir.children("*.ceylon")){
        assert (is File file);
        value automaton = Automaton();
        print("");
        print("--------");
        print(file.name);
        try (reader = file.Reader("UTF-8")) {
            while(exists line =  reader.readLine()){
                for(c in line){
                    automaton.process(c);
                }
                automaton.process(newLine);
            }
        }
        automaton.printBuffer();
    }
    
    
}