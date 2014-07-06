import ceylon.collection {
    ArrayList
}
abstract class State(shared Boolean followingCommentInLine = false)
        of code | codeFollowingCommentLine | commentMiscStartSlash  | commentMiscStartSlashFollowingCommentLine | commentBlock | 
        commentBlockStopAsterisk  | commentLine{} 

object code extends State() {}
object codeFollowingCommentLine extends State(true) {}
object commentMiscStartSlash extends State() {}
object commentMiscStartSlashFollowingCommentLine extends State(true) {}
object commentBlock extends State() {}
object commentBlockStopAsterisk extends State() {}
object commentLine extends State() {}


shared abstract class NewLine() of newLine{}object newLine extends NewLine() {}


class Automaton() {
    
    value b = ArrayList<Character>();
    
    variable State state = code;
    
    shared alias Event => Character|NewLine;
    
    variable Integer currentLineNumber = 1;
    
    String linePrefix() => "\n``currentLineNumber``) ";
    
    void processEventInCodeState(Event e){
        switch (e)
        case (is Character) {
            if(e == '/'){
                state = state.followingCommentInLine then commentMiscStartSlashFollowingCommentLine else commentMiscStartSlash;
            }
        }
        case (newLine) { state = code;}
    }
    
    void processEventInCommentMiscStartSlashState(Event e){
        switch (e)
        case (is Character) {
            if(e == '/'){
                b.addAll(state.followingCommentInLine then " " else linePrefix());
                state = commentLine; 
            }else if(e == '*'){
                b.addAll(linePrefix());
                state = commentBlock; 
            } else {
                state = code;
            }
        }
        case (newLine) { state = code; }
    }
    
    void computeAutomaton(Event e) {
        switch(state)
        case(code){
            processEventInCodeState(e);
        }
        case(codeFollowingCommentLine){
            processEventInCodeState(e);
        }
        case(commentMiscStartSlash){
            processEventInCommentMiscStartSlashState(e);
        }
        case(commentMiscStartSlashFollowingCommentLine){
            processEventInCommentMiscStartSlashState(e);
        }
        case(commentBlock){
            switch (e)
            case (is Character) {
                b.push(e);
                if(e == '*'){
                    state = commentBlockStopAsterisk; 
                }
            }
            case (newLine) {b.push(' ');}
        }
        case(commentBlockStopAsterisk){
            switch (e)
            case (is Character) {
                if(e == '/'){
                    b.pop(); // remove added asterisk
                    state = code; 
                }else {
                    state = commentBlock;
                }
            }
            case (newLine) { state = commentBlock; }
        }
        case(commentLine){
            switch (e)
            case (is Character) { b.push(e); }
            case (newLine) { state = codeFollowingCommentLine; }
        }
    }
    
    
    
    shared void computeLineNumber(Event e) {
        switch (e)
        case (is Character) { }
        case (newLine) { currentLineNumber++; }
    }
    
    
    shared void process(Event e){
        computeLineNumber(e);
        computeAutomaton(e);
        
    }
    
    shared void printBuffer(){
        print(String(b));
    }
    
    
}