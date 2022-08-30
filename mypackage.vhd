library ieee;
use ieee.std_logic_1164.all;

package mypackage is 

component twos_complement is

port(

input :in std_logic_vector(4 downto 0);
output:out std_logic_vector(4 downto 0)

);

 
end component;

end mypackage;