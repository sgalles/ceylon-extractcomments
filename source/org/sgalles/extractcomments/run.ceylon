import ceylon.file {
    File,
    parsePath
}
"Run the module `org.sgalles.extractcomments`."
shared void run() {
    value auto = Automaton();
    value filePath = parsePath("""C:\Users\admin\Documents\GitHub\ceylon-walkthrough\source\fr\01bases.ceylon""");
    assert (is File file = filePath.resource);
    try (reader = file.Reader("UTF-8")) {
        while(exists line =  reader.readLine()){
            for(c in line){
                auto.process(c);
            }
            auto.process(newLine);
        }
    }
    auto.printBuffer();
    
}