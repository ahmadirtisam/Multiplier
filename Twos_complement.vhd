library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity Twos_complement is 

port(

input :in std_logic_vector(4 downto 0);
output:out std_logic_vector(4 downto 0)
);

end Twos_complement;

architecture myarch of twos_complement is

signal store : std_logic_Vector(4 downto 0);

begin 

store<=input xor "11111";
output<=store+'1';

end myarch;