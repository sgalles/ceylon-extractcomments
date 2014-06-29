import ceylon.collection { ArrayList }
abstract class State()
        of code | commentBlockOrLineStart1  | commentBlock | 
        commentBlockEnd1 | commentBlockEnd2 | commentLine{} 

        object code extends State() {}
        object commentBlockOrLineStart1 extends State() {}
        object commentBlock extends State() {}
        object commentBlockEnd1 extends State() {}
        object commentBlockEnd2 extends State() {}
        object commentLine extends State() {}
        

shared abstract class NewLine() of newLine{}object newLine extends NewLine() {}


class Automaton() {
   
    value b = ArrayList<Character>();
   
    variable State state = code;

    shared alias Event => Character|NewLine;
    
    shared void process(Event e){
        switch(state)
        case(code){
            switch (e)
            case (is Character) {
                if(e == '/'){
                    state = commentBlockOrLineStart1;
                }
            }
            case (newLine) {}
        }
        case(commentBlockOrLineStart1){
            switch (e)
            case (is Character) {
                if(e == '/'){
                    state = commentLine;
                }else if(e == '*'){
                    state = commentBlock;
                }
            }
            case (newLine) { b.pop(); state = code; }
        }
        case(commentBlock){
            switch (e)
            case (is Character) {b.push(e);}
            case (newLine) {b.push(' ');}
        }
        case(commentBlockEnd1){
            switch (e)
            case (is Character) {}
            case (newLine) {}
        }
        case(commentBlockEnd2){
            switch (e)
            case (is Character) {}
            case (newLine) {}
        }
        case(commentLine){
            switch (e)
            case (is Character) {}
            case (newLine) {}
        }
        
     
        
    }

    shared void printBuffer(){
        print(String(b));
    }
    
    
}