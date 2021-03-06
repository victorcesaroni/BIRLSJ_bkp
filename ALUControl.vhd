library ieee ;
	use ieee.std_logic_1164.all ;
	use ieee.numeric_std.all ;

entity ALUControl is
  
  port ( funct				 : in std_logic_vector(5 downto 0) ;
			ALUOp 			: in std_logic_vector(2 downto 0) ;
			Opcode 			: in std_logic_vector(3 downto 0) ;
  	      operacao 		: out std_logic_vector(2 downto 0)
  ) ;

end ALUControl; -- uc

architecture arch of ALUControl is

begin
	process(funct, ALUOp, Opcode)
		begin 
		case ALUOp is 
			when "000" => operacao <= "010"; -- lw e sw
			when "001" => operacao <= "011"; -- branch
			when "010" => -- tipo R
				case funct is
					when "000000" => operacao <= "010"; -- add
					when "000001" => operacao <= "011"; -- sub
					when "000010" => operacao <= "000"; -- and
					when "000011" => operacao <= "001"; -- or
					when "000100" => operacao <= "010"; -- jr
					when OTHERS => NULL;
				end case;
			when "011" => -- tipo I
				case Opcode is
					when "0001" => operacao <= "010"; -- addi
					when "0010" => operacao <= "011"; -- subi
					when "0011" => operacao <= "000"; -- andi
					when "0100" => operacao <= "001"; -- ori
					when OTHERS => NULL;
				end case;
			when OTHERS => NULL;
		end case;
	
	end process;
end architecture ; -- arch