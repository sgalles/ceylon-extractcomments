import ceylon.collection { ArrayList }
abstract class State()
        of code | commentBlockStart1 | commentBlockStart2 | commentBlock | 
        commentBlockEnd1 | commentBlockEnd2 | commentLineStart1 | commentLineStart2 | commentLine{} 

        object code extends State() {}
        object commentBlockStart1 extends State() {}
        object commentBlockStart2 extends State() {}
        object commentBlock extends State() {}
        object commentBlockEnd1 extends State() {}
        object commentBlockEnd2 extends State() {}
        object commentLineStart1 extends State() {}
        object commentLineStart2 extends State() {}
        object commentLine extends State() {}
        

shared abstract class NewLine() of newLine{}object newLine extends NewLine() {}


class Automaton() {
   
    value buffer = ArrayList<Character>();
   
    variable State s = code;

    shared alias Event => Character|NewLine;
    
    shared void process(Event e){
        switch (e)
        case (newLine) { buffer.add('N');}
        case (is Character) { buffer.add(e);}
        
    }

    shared void printBuffer(){
        print(String(buffer));
    }
    
    
}