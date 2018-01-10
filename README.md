# DE2-Board-Lab3
**Part 1:**  
Figure 1 shows a positive-edge-triggered flip-flop with some multiplexers. In this part of the lab, you will use eight instances of the circuit in Figure 1 to design a left/right 8-bit rotating register with parallel load. The LoadLeft input of all eight instances of the circuit in Figure 1 should be tied to a single rotating register input RotateRight. The loadn input of all eight instances should be tied to a single rotating register input ParallelLoadn. The clock input of all eight instances should be tied to a single rotating register input clock.  

Create an 8-bit-wide rotating register input DATA_IN, whose individual wires DATA_IN7… DATA_IN0 are tied to the D input of each instance of the circuit in Figure 1. Likewise, create an 8-bit-wide rotating register output Q, whose individual wires Q7… Q0 are tied to the Q output of each instance of the circuit in Figure 1.  

The remaining connections between the eight instances of the circuit in Figure 1 should realize the following behavior. When ParallelLoadn is a logic-0, the value on DATA_IN is stored in the flip-flops on the next positive clock edge (i.e. parallel load behavior).  

When ParallelLoadn is a logic-1 and RotateRight is a logic-1, the bits of the register rotate to the right on each positive clock edge (notice the bits rotate to the right with wrap around):  

  Q7Q6Q5Q4Q3Q2Q1Q0  
  Q0Q7Q6Q5Q4Q3Q2Q1  
  Q1Q0Q7Q6Q5Q4Q3Q2  
  . . .  
When ParallelLoadn is a logic-1 and RotateRight is a logic-0, the bits of the register rotate to the left on each positive clock edge:  

  Q7Q6Q5Q4Q3Q2Q1Q0  
  Q6Q5Q4Q3Q2Q1Q0Q7  
  Q5Q4Q3Q2Q1Q0Q7Q6  

![image](https://user-images.githubusercontent.com/19510655/34781240-4d09953c-f5f3-11e7-88d3-b54753418e86.png)  
Figure 1. Sub-circuit for part 1.  

![image](https://user-images.githubusercontent.com/19510655/34781270-659222e0-f5f3-11e7-8013-a93ee9810f04.png)  
Figure 2. Overall circuit for Part 1.  

Figure 2 shows the inputs and outputs of the overall left/right rotating register circuit with parallel load, which will contain eight instances of the circuit in Figure 1.  

Do the following steps:  
1. Draw a schematic for the 8-bit rotating register with parallel load. Your schematic should contain eight instances of the circuit in Figure 1. Paste the schematic into your lab book. Label the signals on your schematic.  
2. Create a new Quartus II project.  
3. Write a Verilog module for the circuit in Figure 1.  
4. Write a Verilog module for the rotating register with parallel load that instantiates eight instances of your Verilog module for Figure 1. This Verilog module should match with the schematic in your lab book. Use SW7−0 as the inputs DATA_IN7−0. Use SW8 as the RotateRight input and SW9 as the ParallelLoadn input. Use KEY0 as the clock. The outputs Q should be displayed on the red LEDs (LEDR7−0).  
5. Include the Verilog code in your project.  
6. Compile your Verilog code and simulate the design with QSim. In your simulation, you should use the parallel load to initialize the rotating register to 0x5E (hexadecimal) at the start of the simulation. Then, clock the register for several cycles to demonstrate rotation in the left and right directions.  
7. Download your circuit into the Cyclone II FPGA on the DE2 board.  
8. Test the functionality of your rotating register.  

Note: if you run into bounce problems with KEY0 for your clock you are welcome to try using any of the keys. Although the DE2 keys/switches are supposed to be debounced, as mechanical switches, a single push/toggle may cause multiple high-frequency toggles (making it difficult to create “clean” clock edges).  

**Part 2.**  
You will use the ALU you designed in Part 3 of Lab 2 to build the circuit shown below in Figure 3. The circuit contains an 8-bit register that drives the B input of the ALU. Design your register with an active-low asynchronous reset. Observe that at each positive clock edge, the data on the ALU output is stored in the register, and as such, it becomes an operand in the next computation. This circuit can do a variety of computations, based on the “instruction” appearing on the 3-bit-wide OPCODE input, and where the result of a computation is stored in memory (the 8-bit register).  

![image](https://user-images.githubusercontent.com/19510655/34781288-70d6e49c-f5f3-11e7-9a83-f4134f2f65e0.png)  
Figure 3. Circuit for part 2.  

We wish to display the hexadecimal value of the 8-bit number B_IN on the two 7-segment displays, HEX1−0. Likewise, we wish to display the hexadecimal value of the 8-bit number DATA on the two 7-segment displays, HEX3 − 2. You will need to design a 7-segment decoder that displays the correct hexadecimal digit for a 4-bit binary input. Your design will instantiate four instances of your decoder.  
Use KEY0 for the clock input. Use SW11 for the reset input. Use SW7−0 for the DATA input. Use SW10−8 for the OPCODE input.  
1. Create a new Quartus II project which will be used to implement the desired circuit on the Altera DE2 board.  
2. Write a Verilog module that provides the necessary functionality.  
3. Include the Verilog file in your project and compile the circuit.  
4. Simulate the circuit with QSim for a few cycles to ensure your circuit is working properly. You should use the reset input to clear the register to 0x00 (hexadecimal) at the beginning of the simulation.  
5. Assign the pins on the FPGA to connect to the switches and 7-segment displays, as indicated in the User Manual for the DE2 board.  
6. Recompile the circuit and download it into the FPGA chip.  
7. Test the functionality of your design by toggling the switches, keys, and observing the output displays.  
