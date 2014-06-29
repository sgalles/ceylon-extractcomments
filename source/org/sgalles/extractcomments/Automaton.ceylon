import ceylon.collection { ArrayList }
abstract class State()
        of code | commentBlockOrLineStart1  | commentBlock | 
        commentBlockEnd1  | commentLine{} 

        object code extends State() {}
        object commentBlockOrLineStart1 extends State() {}
        object commentBlock extends State() {}
        object commentBlockEnd1 extends State() {}
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
                    state = commentLine; b.push('\n');
                }else if(e == '*'){
                    state = commentBlock; b.push('\n');
                } else {
                    state = code;
                }
            }
            case (newLine) { state = code; }
        }
        case(commentBlock){
            switch (e)
            case (is Character) {
                if(e == '*'){
                    state = commentBlockEnd1; b.push(e);
                }else {
                    b.push(e);
                }
            }
            case (newLine) {b.push(' ');}
        }
        case(commentBlockEnd1){
            switch (e)
            case (is Character) {
                if(e == '/'){
                    state = code; b.pop();
                }else {
                    state = commentBlock;
                }
            }
            case (newLine) { state = commentBlock; }
        }
        case(commentLine){
            switch (e)
            case (is Character) { b.push(e);}
            case (newLine) {state = code;}
        }
        
     
        
    }

    shared void printBuffer(){
        print(String(b));
    }
    
    
}