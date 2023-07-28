LIBRARY ieee  ; 
    USE ieee.NUMERIC_STD.all  ; 
    USE ieee.std_logic_1164.all  ; 
    use ieee.math_real.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity i2c_driver_tb is
  generic (runner_cfg : string);
end;

architecture vunit_simulation of i2c_driver_tb is

    constant clock_period      : time    := 1 ns;
    constant simtime_in_clocks : integer := 500;
    
    signal simulator_clock     : std_logic := '0';
    signal simulation_counter  : natural   := 0;
    -----------------------------------
    -- simulation specific signals ----

    signal i2c_clock : std_logic := '0';
    signal clock_divider_counter : integer := 7;
    signal number_of_i2c_clocks : natural := 7;
    signal i2c_direction_is_write_when_1 : std_logic := '1';

    signal i2c_clock_was_received : boolean := false;
    signal number_received_i2c_clocks : natural := 0;

begin

------------------------------------------------------------------------
    simtime : process
    begin
        test_runner_setup(runner, runner_cfg);
        wait for simtime_in_clocks*clock_period;

        if run("i2c clock was detected") then
            check(i2c_clock_was_received, "i2c clock never triggered");
        elsif run("only proper number of clocks were recieved") then
            check(number_received_i2c_clocks = 7, "expected 7, got " & integer'image(number_received_i2c_clocks));
        end if;
        test_runner_cleanup(runner); -- Simulation ends here
        wait;
    end process simtime;	

    simulator_clock <= not simulator_clock after clock_period/2.0;
------------------------------------------------------------------------

    stimulus : process(simulator_clock)

    begin
        if rising_edge(simulator_clock) then
            simulation_counter <= simulation_counter + 1;

            if clock_divider_counter > 0 then
                clock_divider_counter <= clock_divider_counter -1;
            else
                clock_divider_counter <= 7 ;
            end if;

            if clock_divider_counter > 3 and number_of_i2c_clocks > 0 then
                i2c_clock <= '0';
            else
                i2c_clock <= '1';
            end if;

            if clock_divider_counter = 3 then
                if number_of_i2c_clocks > 0 then
                    number_of_i2c_clocks <= number_of_i2c_clocks - 1;
                end if;
            end if;


        end if; -- rising_edge
    end process stimulus;	
------------------------------------------------------------------------
    i2c_receiver : process(i2c_clock)
        
    begin
        if rising_edge(i2c_clock) then
            i2c_clock_was_received <= true;
            number_received_i2c_clocks <= number_received_i2c_clocks + 1;
        end if; --rising_edge
    end process i2c_receiver;	
------------------------------------------------------------------------
end vunit_simulation;
