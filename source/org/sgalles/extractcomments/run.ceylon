import ceylon.file {
    parsePath,
    Directory,
    File,
    Path, Resource
}

"Run the module `org.sgalles.extractcomments`."
shared void run() {
    
    Resource fileDir = parsePath("""C:\Users\admin\Documents\GitHub\ceylon-walkthrough\source\fr""").resource;
    assert(is Directory fileDir);
    for(value file in fileDir.children("*.ceylon")){
        assert (is File file);
        value auto = Automaton();
        print("--------");
        print(file.name);
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
   
    
}