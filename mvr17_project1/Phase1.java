import java.util.LinkedList;
import java.util.List;

public class Phase1 {

    /* Translates the MAL instruction to 1-3 TAL instructions
     * and returns the TAL instructions in a list
     *
     * mals: input program as a list of Instruction objects
     *
     * returns a list of TAL instructions (should be same size or longer than input list)
     */
    public static List<Instruction> mal_to_tal(List<Instruction> mals) {

        List<Instruction> tals = new LinkedList<Instruction>();

        for(int i = 0; i < mals.size(); i++)
        {
           Instruction currInstruction = mals.get(i);   //gets parts op each instruction
           int id = currInstruction.instruction_id;     // opcode
           int rs = currInstruction.rs;
           int rt = currInstruction.rt;
           int rd = currInstruction.rd;
           int imm = currInstruction.immediate;
           int jumpAddress = currInstruction.jump_address;
           int shiftAmount = currInstruction.shift_amount;
           int label = currInstruction.label_id;
           int branchLabel = currInstruction.branch_label;

           int at = 0;                                  //at register
           int upperImm = imm >>> 16;                   // for upper/lower immediate values if its over 2^15
           int lowerImm = imm << 16;

           
            if(id == 100)//blt
           {
                if(rt < rs)
                {
                    at = 1;
                }
                else
                {
                    at = 0;
                }

                tals.add(new Instruction(0, at, rs, rt, 0, 0, 0, 0, 0));         //slt
                tals.add(new Instruction(6, 0, at, 0, 0, 0, 0, 0,branchLabel));   //bne      
           }
           else if(id == 101)//bge
           {
                if(rt < rs)
                {
                    at = 1;
                }
                else 
                {
                    at = 0;
                }

                tals.add(new Instruction(8, at, rs, rt, 0, 0, 0, 0, 0));         //slt
                tals.add(new Instruction(5, 0, at, 0, 0, 0, 0, 0, branchLabel));  //beq
           }
           else if(id == 1 && imm > 0x7FFF)//addiu    32767
           {
                tals.add(new Instruction(9, 0, 0, at, upperImm, 0, 0, 0, 0));       //lui
                tals.add(new Instruction (10, 0, at, at, lowerImm, 0, 0, 0, 0));    //ori
                tals.add(new Instruction(2, rt, rs, at, 0, 0, 0, 0, 0));            //addu  
                at = 1;
           }

           else if(id == 10 && imm > 0x7FFF)//ori
           {
                tals.add(new Instruction(10, 0, at, at, lowerImm, 0, 0, 0, 0));  //ori
                tals.add(new Instruction(2, rt, rs, at, 0, 0, 0, 0, 0));         //addu
                at = 1;

           }
           else //the rest should be in tal form
           {
            tals.add(currInstruction);
           }
        }
        return tals;
    }
}


/*
 //check what type of instruction
            //if its  
            if(mal.instruction == 1)      //addiu
            {
                int immediate = mals.get(i).immediate;
                if(immediate & 0xffff != immediate)
                {
                    int lower = imm & 0xffff
                    int upper = 
                   // instruction gets spit up here
                }
            } 
            if(mal.instruction == 2)       //addu
            {
                int immediate = mals.get(i).immediate;
                if(immediate == 0xffff)
                {
                    
                }
            } 
            if(mal.instruction == 3)       //or
            {
                int immediate = mals.get(i).immediate;
                if(immediate == 0xffff)
                {
                    
                }
            } 
            if(mal.instruction == 5)       beq
            {
                int immediate = mals.get(i).immediate;
                if(immediate == 0xffff)
                {
                    
                }
            } 
*/