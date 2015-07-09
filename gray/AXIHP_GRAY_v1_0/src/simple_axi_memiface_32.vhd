library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity simple_axi_memiface_32 is
  port (
    clk : in std_logic;
    reset : in std_logic;
    data_address : in std_logic_vector(32-1 downto 0);
    data_din : in std_logic_vector(32-1 downto 0);
    data_dout : out std_logic_vector(32-1 downto 0);
    read_result : out std_logic_vector(32-1 downto 0);
    data_we : in std_logic;
    data_oe : in std_logic;
    data_length : out std_logic_vector(32-1 downto 0);
    busy : out std_logic;
    forbid : in std_logic;
    axi_reader_ARADDR : out std_logic_vector(32-1 downto 0);
    axi_reader_ARLEN : out std_logic_vector(8-1 downto 0);
    axi_reader_ARVALID : out std_logic;
    axi_reader_ARREADY : in std_logic;
    axi_reader_ARSIZE : out std_logic_vector(3-1 downto 0);
    axi_reader_ARBURST : out std_logic_vector(2-1 downto 0);
    axi_reader_ARCACHE : out std_logic_vector(4-1 downto 0);
    axi_reader_ARPROT : out std_logic_vector(3-1 downto 0);
    axi_reader_RDATA : in std_logic_vector(32-1 downto 0);
    axi_reader_RRESP : in std_logic_vector(2-1 downto 0);
    axi_reader_RLAST : in std_logic;
    axi_reader_RVALID : in std_logic;
    axi_reader_RREADY : out std_logic;
    axi_writer_AWADDR : out std_logic_vector(32-1 downto 0);
    axi_writer_AWLEN : out std_logic_vector(8-1 downto 0);
    axi_writer_AWVALID : out std_logic;
    axi_writer_AWSIZE : out std_logic_vector(3-1 downto 0);
    axi_writer_AWBURST : out std_logic_vector(2-1 downto 0);
    axi_writer_AWCACHE : out std_logic_vector(4-1 downto 0);
    axi_writer_AWPROT : out std_logic_vector(3-1 downto 0);
    axi_writer_AWREADY : in std_logic;
    axi_writer_WDATA : out std_logic_vector(32-1 downto 0);
    axi_writer_WLAST : out std_logic;
    axi_writer_WVALID : out std_logic;
    axi_writer_WREADY : in std_logic;
    axi_writer_WSTRB : out std_logic_vector(4-1 downto 0);
    axi_writer_BRESP : in std_logic_vector(2-1 downto 0);
    axi_writer_BVALID : in std_logic;
    axi_writer_BREADY : out std_logic
  );
end simple_axi_memiface_32;

architecture RTL of simple_axi_memiface_32 is


  signal clk_sig : std_logic;
  signal reset_sig : std_logic;
  signal data_address_sig : std_logic_vector(32-1 downto 0);
  signal data_din_sig : std_logic_vector(32-1 downto 0);
  signal data_dout_sig : std_logic_vector(32-1 downto 0) := (others => '0');
  signal read_result_sig : std_logic_vector(32-1 downto 0) := (others => '0');
  signal data_we_sig : std_logic;
  signal data_oe_sig : std_logic;
  signal data_length_sig : std_logic_vector(32-1 downto 0);
  signal busy_sig : std_logic;
  signal forbid_sig : std_logic;
  signal axi_reader_ARADDR_sig : std_logic_vector(32-1 downto 0) := (others => '0');
  signal axi_reader_ARLEN_sig : std_logic_vector(8-1 downto 0) := (others => '0');
  signal axi_reader_ARVALID_sig : std_logic := '0';
  signal axi_reader_ARREADY_sig : std_logic;
  signal axi_reader_ARSIZE_sig : std_logic_vector(3-1 downto 0);
  signal axi_reader_ARBURST_sig : std_logic_vector(2-1 downto 0);
  signal axi_reader_ARCACHE_sig : std_logic_vector(4-1 downto 0);
  signal axi_reader_ARPROT_sig : std_logic_vector(3-1 downto 0);
  signal axi_reader_RDATA_sig : std_logic_vector(32-1 downto 0);
  signal axi_reader_RRESP_sig : std_logic_vector(2-1 downto 0);
  signal axi_reader_RLAST_sig : std_logic;
  signal axi_reader_RVALID_sig : std_logic;
  signal axi_reader_RREADY_sig : std_logic := '0';
  signal axi_writer_AWADDR_sig : std_logic_vector(32-1 downto 0) := (others => '0');
  signal axi_writer_AWLEN_sig : std_logic_vector(8-1 downto 0) := (others => '0');
  signal axi_writer_AWVALID_sig : std_logic := '0';
  signal axi_writer_AWSIZE_sig : std_logic_vector(3-1 downto 0);
  signal axi_writer_AWBURST_sig : std_logic_vector(2-1 downto 0);
  signal axi_writer_AWCACHE_sig : std_logic_vector(4-1 downto 0);
  signal axi_writer_AWPROT_sig : std_logic_vector(3-1 downto 0);
  signal axi_writer_AWREADY_sig : std_logic;
  signal axi_writer_WDATA_sig : std_logic_vector(32-1 downto 0) := (others => '0');
  signal axi_writer_WLAST_sig : std_logic := '0';
  signal axi_writer_WVALID_sig : std_logic := '0';
  signal axi_writer_WREADY_sig : std_logic;
  signal axi_writer_WSTRB_sig : std_logic_vector(4-1 downto 0);
  signal axi_writer_BRESP_sig : std_logic_vector(2-1 downto 0);
  signal axi_writer_BVALID_sig : std_logic;
  signal axi_writer_BREADY_sig : std_logic := '0';

  signal read_state_busy : std_logic := '0';
  signal write_state_busy : std_logic := '0';
  signal tmp_0001 : std_logic;
  signal tmp_0002 : std_logic;
  type Type_write_seq is (
    write_seq_IDLE,
    write_seq_s0,
    write_seq_s1  
  );
  signal write_seq : Type_write_seq := write_seq_IDLE;
  signal write_seq_delay : signed(32-1 downto 0) := (others => '0');
  signal tmp_0003 : std_logic;
  signal tmp_0004 : std_logic;
  signal tmp_0005 : std_logic;
  signal tmp_0006 : std_logic;
  type Type_read_seq is (
    read_seq_IDLE,
    read_seq_s0,
    read_seq_s1  
  );
  signal read_seq : Type_read_seq := read_seq_IDLE;
  signal read_seq_delay : signed(32-1 downto 0) := (others => '0');
  signal tmp_0007 : std_logic;
  signal tmp_0008 : std_logic;

begin

  clk_sig <= clk;
  reset_sig <= reset;
  data_address_sig <= data_address;
  data_din_sig <= data_din;
  data_dout <= data_dout_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        data_dout_sig <= (others => '0');
      else
        if read_seq = read_seq_s1 then
          data_dout_sig <= axi_reader_RDATA_sig;
        end if;
      end if;
    end if;
  end process;

  read_result <= read_result_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_result_sig <= (others => '0');
      else
        if read_seq = read_seq_s1 then
          read_result_sig <= axi_reader_RDATA_sig;
        end if;
      end if;
    end if;
  end process;

  data_we_sig <= data_we;
  data_oe_sig <= data_oe;
  data_length <= data_length_sig;
  data_length_sig <= X"7fffffff";

  busy <= busy_sig;
  busy_sig <= tmp_0002;

  forbid_sig <= forbid;
  axi_reader_ARADDR <= axi_reader_ARADDR_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_reader_ARADDR_sig <= (others => '0');
      else
        if read_seq = read_seq_IDLE then
          axi_reader_ARADDR_sig <= data_address_sig;
        end if;
      end if;
    end if;
  end process;

  axi_reader_ARLEN <= axi_reader_ARLEN_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_reader_ARLEN_sig <= (others => '0');
      else
        if read_seq = read_seq_IDLE then
          axi_reader_ARLEN_sig <= X"00";
        end if;
      end if;
    end if;
  end process;

  axi_reader_ARVALID <= axi_reader_ARVALID_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_reader_ARVALID_sig <= '0';
      else
        if read_seq = read_seq_IDLE then
          axi_reader_ARVALID_sig <= data_oe_sig;
        elsif read_seq = read_seq_s0 then
          axi_reader_ARVALID_sig <= tmp_0007;
        end if;
      end if;
    end if;
  end process;

  axi_reader_ARREADY_sig <= axi_reader_ARREADY;
  axi_reader_ARSIZE <= axi_reader_ARSIZE_sig;
  axi_reader_ARSIZE_sig <= "010";

  axi_reader_ARBURST <= axi_reader_ARBURST_sig;
  axi_reader_ARBURST_sig <= "01";

  axi_reader_ARCACHE <= axi_reader_ARCACHE_sig;
  axi_reader_ARCACHE_sig <= X"3";

  axi_reader_ARPROT <= axi_reader_ARPROT_sig;
  axi_reader_ARPROT_sig <= "000";

  axi_reader_RDATA_sig <= axi_reader_RDATA;
  axi_reader_RRESP_sig <= axi_reader_RRESP;
  axi_reader_RLAST_sig <= axi_reader_RLAST;
  axi_reader_RVALID_sig <= axi_reader_RVALID;
  axi_reader_RREADY <= axi_reader_RREADY_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_reader_RREADY_sig <= '0';
      else
        if read_seq = read_seq_IDLE then
          axi_reader_RREADY_sig <= '1';
        end if;
      end if;
    end if;
  end process;

  axi_writer_AWADDR <= axi_writer_AWADDR_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_AWADDR_sig <= (others => '0');
      else
        if write_seq = write_seq_IDLE then
          axi_writer_AWADDR_sig <= data_address_sig;
        end if;
      end if;
    end if;
  end process;

  axi_writer_AWLEN <= axi_writer_AWLEN_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_AWLEN_sig <= (others => '0');
      else
        if write_seq = write_seq_IDLE then
          axi_writer_AWLEN_sig <= X"00";
        end if;
      end if;
    end if;
  end process;

  axi_writer_AWVALID <= axi_writer_AWVALID_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_AWVALID_sig <= '0';
      else
        if write_seq = write_seq_IDLE then
          axi_writer_AWVALID_sig <= data_we_sig;
        elsif write_seq = write_seq_s0 then
          axi_writer_AWVALID_sig <= tmp_0003;
        end if;
      end if;
    end if;
  end process;

  axi_writer_AWSIZE <= axi_writer_AWSIZE_sig;
  axi_writer_AWSIZE_sig <= "010";

  axi_writer_AWBURST <= axi_writer_AWBURST_sig;
  axi_writer_AWBURST_sig <= "01";

  axi_writer_AWCACHE <= axi_writer_AWCACHE_sig;
  axi_writer_AWCACHE_sig <= X"3";

  axi_writer_AWPROT <= axi_writer_AWPROT_sig;
  axi_writer_AWPROT_sig <= "000";

  axi_writer_AWREADY_sig <= axi_writer_AWREADY;
  axi_writer_WDATA <= axi_writer_WDATA_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_WDATA_sig <= (others => '0');
      else
        if write_seq = write_seq_IDLE then
          axi_writer_WDATA_sig <= data_din_sig;
        end if;
      end if;
    end if;
  end process;

  axi_writer_WLAST <= axi_writer_WLAST_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_WLAST_sig <= '0';
      else
        if write_seq = write_seq_s0 then
          axi_writer_WLAST_sig <= axi_writer_AWREADY_sig;
        elsif write_seq = write_seq_s1 then
          axi_writer_WLAST_sig <= tmp_0004;
        end if;
      end if;
    end if;
  end process;

  axi_writer_WVALID <= axi_writer_WVALID_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_WVALID_sig <= '0';
      else
        if write_seq = write_seq_s0 then
          axi_writer_WVALID_sig <= axi_writer_AWREADY_sig;
        elsif write_seq = write_seq_s1 then
          axi_writer_WVALID_sig <= tmp_0005;
        end if;
      end if;
    end if;
  end process;

  axi_writer_WREADY_sig <= axi_writer_WREADY;
  axi_writer_WSTRB <= axi_writer_WSTRB_sig;
  axi_writer_WSTRB_sig <= X"f";

  axi_writer_BRESP_sig <= axi_writer_BRESP;
  axi_writer_BVALID_sig <= axi_writer_BVALID;
  axi_writer_BREADY <= axi_writer_BREADY_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_BREADY_sig <= '0';
      else
        if write_seq = write_seq_IDLE then
          axi_writer_BREADY_sig <= '1';
        end if;
      end if;
    end if;
  end process;


  -- expressions
  tmp_0001 <= write_state_busy or read_state_busy;
  tmp_0002 <= tmp_0001 or forbid_sig;
  tmp_0003 <= not axi_writer_AWREADY_sig;
  tmp_0004 <= not axi_writer_WREADY_sig;
  tmp_0005 <= not axi_writer_WREADY_sig;
  tmp_0006 <= not axi_writer_WREADY_sig;
  tmp_0007 <= not axi_reader_ARREADY_sig;
  tmp_0008 <= not axi_reader_RVALID_sig;

  -- sequencers
  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_seq <= write_seq_IDLE;
        write_seq_delay <= (others => '0');
      else
        case (write_seq) is
          when write_seq_IDLE => 
            if data_we_sig = '1' then
              write_seq <= write_seq_s0;
            end if;
          when write_seq_s0 => 
            if axi_writer_AWREADY_sig = '1' then
              write_seq <= write_seq_s1;
            end if;
          when write_seq_s1 => 
            if axi_writer_WREADY_sig = '1' then
              write_seq <= write_seq_IDLE;
            end if;
          when others => null;
        end case;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_seq <= read_seq_IDLE;
        read_seq_delay <= (others => '0');
      else
        case (read_seq) is
          when read_seq_IDLE => 
            if data_oe_sig = '1' then
              read_seq <= read_seq_s0;
            end if;
          when read_seq_s0 => 
            if axi_reader_ARREADY_sig = '1' then
              read_seq <= read_seq_s1;
            end if;
          when read_seq_s1 => 
            if axi_reader_RVALID_sig = '1' then
              read_seq <= read_seq_IDLE;
            end if;
          when others => null;
        end case;
      end if;
    end if;
  end process;


  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_state_busy <= '0';
      else
        if read_seq = read_seq_IDLE then
          read_state_busy <= data_oe_sig;
        elsif read_seq = read_seq_s1 then
          read_state_busy <= tmp_0008;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_state_busy <= '0';
      else
        if write_seq = write_seq_IDLE then
          write_state_busy <= data_we_sig;
        elsif write_seq = write_seq_s1 then
          write_state_busy <= tmp_0006;
        end if;
      end if;
    end if;
  end process;



end RTL;
