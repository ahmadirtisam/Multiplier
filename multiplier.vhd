library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.mypackage.all;

entity multiplier is 

port (

clock:in std_logic;
reset :in std_logic;
enable:in std_logic;
number1 :in std_logic_vector(4 downto 0);
number2 :in std_logic_vector(4 downto 0);
product_reg :out std_logic_vector(9 downto 0)


);
end multiplier;

architecture myarch of multiplier is

signal complement1 :std_logic_Vector(4 downto 0);	--complement of number1 
type state is(initilize,state1,state2,state3,state4,state5);
signal present_state,next_state :state; 
 
begin 


U1:twos_complement port map(

input=>number1,
output=>complement1

);



	process(clock,reset)

	begin 
	
		if(reset='1')then 
			
			present_state<=initilize;

		elsif(rising_edge(clock))then 
		
			present_state<=next_state;
		
		end if;

	end process;

	process(clock,present_state,number1,number2)
	
		variable cp_bit :std_logic_vector(1 downto 0);--current and previous bit
		variable product_register:std_logic_Vector(9 downto 0);--Product Register	
		variable multiplicand:std_logic_vector(4 downto 0);
	
	begin
	
	if(rising_edge(clock)) then 
		
		case present_state is
		
			when initilize=> 
			
				if(enable='1')then 
				
					multiplicand:=number1;
					product_register(4 downto 0):=number2;
					cp_bit:="00";
					next_state<=state1;
					
				else 
				
					next_state<=initilize;
					
				end if;
					
			when state1=>
				
				cp_bit(0):=cp_bit(1);--current bit now at previous bit 
				cp_bit(1):=product_register(0);
				
				if(cp_bit="00")then	--Just RSA
			
					--product_register<=std_logic_Vector(shift_right(unsigned(product_register),2));
					product_register(8 downto 0):=product_register(9 downto 1);
					
					
				elsif(cp_bit="01")then	--Add to uper left half and then RSA
					
					product_register(9 downto 5):=product_register(9 downto 5)+multiplicand;
					product_register(8 downto 0):=product_register(9 downto 1);
				elsif(cp_bit="10") then	--Add complement of multiplicand to uper left half and then RSA
				 
					product_register(9 downto 5):=product_register(9 downto 5)+complement1;
					product_register(8 downto 0):=product_register(9 downto 1);	
		
				
				elsif(cp_bit="11")then 	--RSA[right shift arithmetic]
				
					product_register(8 downto 0):=product_register(9 downto 1);
		
				end if;
				
				next_state<=state2;
			
			when state2=>
			
				
				cp_bit(0):=cp_bit(1);--current bit now at previous bit 
				cp_bit(1):=product_register(0);
				
				if(cp_bit="00")then	--RSA[right shift arithmetic]
					
					product_register(8 downto 0):=product_register(9 downto 1);
		
					
				elsif(cp_bit="01")then	--Add from uper left half and then RSA
					
					product_register(9 downto 5):=product_register(9 downto 5)+multiplicand;
					product_register(8 downto 0):=product_register(9 downto 1);
				
				elsif(cp_bit="10") then	--Add complement of multiplicand to uper left half and then RSA
				
					product_register(9 downto 5):=product_register(9 downto 5)+complement1;
					product_register(8 downto 0):=product_register(9 downto 1);
		
				
				elsif(cp_bit="11")then 	--RSA[right shift arithmetic]
				
					product_register(8 downto 0):=product_register(9 downto 1);
				
				end if;
				
				next_state<=state3;
				
			when state3=>
			
				cp_bit(0):=cp_bit(1);--current bit is now at previous bit 
				cp_bit(1):=product_register(0);
				
				if(cp_bit="00")then	--RSA[right shift arithmetic]
					
					product_register(8 downto 0):=product_register(9 downto 1);
					
				elsif(cp_bit="01")then	--Add from uper left half and then RSA
					
					product_register(9 downto 5):=product_register(9 downto 5)+multiplicand;
					product_register(8 downto 0):=product_register(9 downto 1);
		
				
				elsif(cp_bit="10") then	--Add complement of multiplicand to uper left half and then RSA
				
					product_register(9 downto 5):=product_register(9 downto 5)+complement1;
					product_register(8 downto 0):=product_register(9 downto 1);	
				
				elsif(cp_bit="11")then 	--RSA[right shift arithmetic]
				
					product_register(8 downto 0):=product_register(9 downto 1);
	
				end if;
				
				next_state<=state4;
			
			when state4=>
			
				cp_bit(0):=cp_bit(1);--current bit is now at previous bit 
				cp_bit(1):=product_register(0);
				
				if(cp_bit="00")then	--RSA[right shift arithmetic]
					
					product_register(8 downto 0):=product_register(9 downto 1);
					
					
				elsif(cp_bit="01")then	--Add from uper left half and then RSA
					
					product_register(9 downto 5):=product_register(9 downto 5)+multiplicand;
					product_register(8 downto 0):=product_register(9 downto 1);
					
				
				elsif(cp_bit="10") then	--Add complement of multiplicand to uper left half and then RSA
				
					product_register(9 downto 5):=product_register(9 downto 5)+complement1;
					product_register(8 downto 0):=product_register(9 downto 1);	
					
				
				elsif(cp_bit="11")then 	--RSA[right shift arithmetic]
				
					product_register(8 downto 0):=product_register(9 downto 1);
	
				end if;
				
				next_state<=state5;
			
			when state5=>
			
				cp_bit(0):=cp_bit(1);--current bit now at previous bit 
				cp_bit(1):=product_register(0);
				
				if(cp_bit="00")then	--RSA[right shift arithmetic]
					
					product_register(8 downto 0):=product_register(9 downto 1);
					
				elsif(cp_bit="01")then	--Add from uper left half and then RSA
					
					product_register(9 downto 5):=product_register(9 downto 5)+multiplicand;
					product_register(8 downto 0):=product_register(9 downto 1);
				
				elsif(cp_bit="10") then	--Add complement of multiplicand to uper left half and then RSA
				
					
					product_register(9 downto 5):=product_register(9 downto 5)+complement1;
					product_register(8 downto 0):=product_register(9 downto 1);	
				
				elsif(cp_bit="11")then 	--RSA[right shift arithmetic]
				
					product_register(8 downto 0):=product_register(9 downto 1);
			
				end if; 
				

		end case;
					product_reg<=product_register;
					
	end if;
					
	end process comb_process;
	

	
end myarch; 
