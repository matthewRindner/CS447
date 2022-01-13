
import java.util.LinkedList;
import java.util.List;
import java.lang.*;

public class Phase3 {

    /* Translate each Instruction object into
     * a 32-bit number.
     *
     * tals: list of Instructions to translate
     *
     * returns a list of instructions in their 32-bit binary representation
     *
     */
    

    public static List<Integer> translate_instructions(List<Instruction> tals) 
    {
        List<Integer> binary32 = new LinkedList<Integer>();
        //this.binary32 = binary32;
           
       for(int i = 0; i < tals.size(); i++)
       {
            Instruction currInstruction = tals.get(i);
            int id = currInstruction.instruction_id;
            /*
            int arrOfInstruction_id[] = {1, 2, 3, 5, 6, 8, 9, 10, 100, 101};
            for(int i = 0; i < arrOfInstruction_id.lenght; i++)
            {
                id = arrOfInstruction_id[i];
            }
            switch(id)
            {
                case 1: stuff;
                        break;
                case 2: stuff;
                        break;
                case 3: stuff;
                        break;
                case 5: stuff;
                        break;

            }
            */
            if(id == 1)//addiu
            {
                int immBit = currInstruction.immediate;
                int rtBit = currInstruction.rt << 16; 
                int rsBit = currInstruction.rs << 21;
                int opcodeBit = 33 << 26;
                int bit0_20 = (int)Math.pow(immBit, rtBit);
                int bit0_25 = (int)Math.pow(bit0_20, rsBit);
                int bit32 = (int)Math.pow(opcodeBit, bit0_25);

                String ans = Integer.toHexString(bit0_25);
                binary32.add(Integer.parseInt(ans, 16));
                continue;
            }
            else if(id == 2)//addu
            {
                int funct = 33;
                int rdBit = currInstruction.rd << 11;
                int rtBit = currInstruction.rt << 16; 
                int rsBit = currInstruction.rs << 21;
                int shamt = 0 << 10;
                int bit0_10 = (int)Math.pow(funct, shamt);
                int bit0_15 = (int)Math.pow(rdBit, bit0_10);
                int bit0_20 = (int)Math.pow(bit0_15, rtBit);
                int bit0_25 = (int)Math.pow(bit0_20, rsBit);

                String ans = Integer.toHexString(bit0_25);
                binary32.add(Integer.parseInt(ans, 16));
                continue;
            }
            else if(id == 3)//or   R-type
            {
                int funct = 37;
                int rdBit = currInstruction.rd << 11;
                int rtBit = currInstruction.rt << 16; 
                int rsBit = currInstruction.rs << 21;
                int shamt = 0 << 10;
                int bit0_10 = (int)Math.pow(funct, shamt);
                int bit0_15 = (int)Math.pow(rdBit, bit0_10);
                int bit0_20 = (int)Math.pow(bit0_15, rtBit);
                int bit0_25 = (int)Math.pow(bit0_20, rsBit);

                String ans = Integer.toHexString(bit0_25);
                binary32.add(Integer.parseInt(ans, 16));
                continue;
            }
            else if(id == 5)//beq   I-type
            {
                int rtBit = currInstruction.rt << 16; 
                int rsBit = currInstruction.rs << 21;
                int opcodeBit = 4 << 26;
                int immBit = currInstruction.immediate;
                int bit0_20 = (int)Math.pow(immBit, rtBit);
                int bit0_25 = (int)Math.pow(bit0_20, rsBit);
                int bit_32 = (int)Math.pow(opcodeBit, bit0_25);

                String ans = Integer.toHexString(bit_32);
                binary32.add(Integer.parseInt(ans, 16));
                continue;
            }
            else if(id == 6)//bne    I-type
            {
                int immBit = currInstruction.immediate;
                immBit = immBit^0xFFFF0000;
                int rtBit = currInstruction.rt << 16;
                int bit0_20 = (int)Math.pow(immBit, rtBit);
                int rsBit = currInstruction.rs << 21;
                int bit0_25 = (int)Math.pow(bit0_20, rsBit);
                int opcodeBit = 5 << 26;
                int bit_32 = (int)Math.pow(opcodeBit, bit0_25);

                String ans = Integer.toHexString(bit_32);
                binary32.add(Integer.parseInt(ans, 16));
                continue;
            }
            else if(id == 8)//slt    R-type
            {
                int funct = 42;
                int shamt = 0 << 10;
                int rdBit = currInstruction.rd << 11;
                int rtBit = currInstruction.rt << 16; 
                int rsBit = currInstruction.rs << 21;
                int bit0_10 = (int)Math.pow(funct, shamt);
                int bit0_15 = (int)Math.pow(rdBit, bit0_10);
                int bit0_20 = (int)Math.pow(bit0_15, rtBit);
                int bit0_25 = (int)Math.pow(bit0_20, rsBit);

                String ans = Integer.toHexString(bit0_25);
                binary32.add(Integer.parseInt(ans, 16));
                continue;
            }
            else if(id == 9)//lui    I-type
            {
                int immBit = currInstruction.immediate;
                int rtBit = currInstruction.rt << 16; 
                int rsBit = currInstruction.rs << 21;
                int bit0_20 = (int)Math.pow(immBit, rtBit);
                int bit32 = (int)Math.pow(bit0_20, rsBit);

                String ans = Integer.toHexString(bit32);
                binary32.add(Integer.parseInt(ans, 16));
                continue;
            }
            else if(id == 10)//ori   I-type
            {
                int immBit = 00;
                immBit = immBit << 15;
                int opcodeBit = 13 << 26;
                int rtBit = currInstruction.rt << 16;
                int rsBit = currInstruction.rs << 21;
                int bit0_20 = (int)Math.pow(immBit, rtBit);
                int bit0_25 = (int)Math.pow(bit0_20, rsBit);
                int bit32 = (int)Math.pow(opcodeBit, bit0_25);

                String ans = Integer.toHexString(bit32);
                binary32.add(Integer.parseInt(ans, 16));
                continue;

            }
        }
        return binary32; 
    }
}
