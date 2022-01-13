
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class Phase2 {

    /* Returns a list of copies of the Instructions with the
     * immediate field of the instruction filled in
     * with the address calculated from the branch_label.
     *
     * The instruction should not be changed if it is not a branch instruction.
     *
     * unresolved: list of instructions without resolved addresses
     * first_pc: address where the first instruction will eventually be placed in memory
     */

    

    public static List<Instruction> resolve_addresses(List<Instruction> unresolved, int first_pc) 
    {

        LinkedList<Instruction> address_resolved_tals = new LinkedList<Instruction>();
        LinkedList<LinkedList<Object>> mapping_list = new LinkedList<LinkedList<Object>>();

        int pc = first_pc;      //program counter

        for(int i = 0; i < unresolved.size(); i++)
        {
            Instruction currInstruction = unresolved.get(i);
            LinkedList<Object> mappings = new LinkedList<Object>();

            if(mappings.size() != 0)    //does not have a branch label
            {
                mapping_list.add(mappings);
            }
            if(currInstruction.label_id != 0)   //jump and branch instructions   
            {
                int label_pc = first_pc;
                int label = currInstruction.label_id;
                mappings.add(label);
                mappings.add(label_pc);
            }
            first_pc += 4;
            for(int j = 0; j < unresolved.size(); j++)  //i
            {
                int id = currInstruction.instruction_id;
                currInstruction = unresolved.get(j);    // instruction //i

                if(id == 5 || id == 6 || id == 100 || id == 101)
                {
                    for(int k = 0; k < mapping_list.size(); k++)  
                    {
                        LinkedList<Object> currMapping = mapping_list.get(k);
                        int address = (Integer)currMapping.get(1);

                        if(currMapping.get(0) == (Object)currInstruction.branch_label)
                        {
                            int immAddress = (address - pc)/4 - 1; 

                            Instruction newInstruction = new Instruction(currInstruction.instruction_id, 
                                currInstruction.rs, currInstruction.rd, currInstruction.rt, 
                                immAddress, currInstruction.jump_address, currInstruction.shift_amount, 
                                currInstruction.label_id, currInstruction.branch_label);

                            currInstruction = newInstruction;

                        }
                    }
                }
                pc += 4;
                address_resolved_tals.add(currInstruction);
            }
            //return address_resolved_tals;
        }
         return address_resolved_tals;
    }

}
