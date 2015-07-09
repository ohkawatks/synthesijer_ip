library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity axi_lite_slave_32 is
  port (
    clk : in std_logic;
    reset : in std_logic;
    data_length : out std_logic_vector(32-1 downto 0);
    data_address : in std_logic_vector(32-1 downto 0);
    data_din : in std_logic_vector(32-1 downto 0);
    data_dout : out std_logic_vector(32-1 downto 0);
    data_we : in std_logic;
    data_oe : in std_logic;
    axi_reader_ARADDR : in std_logic_vector(32-1 downto 0);
    axi_reader_ARVALID : in std_logic;
    axi_reader_ARREADY : out std_logic;
    axi_reader_RDATA : out std_logic_vector(32-1 downto 0);
    axi_reader_RRESP : out std_logic_vector(2-1 downto 0);
    axi_reader_RVALID : out std_logic;
    axi_reader_RREADY : in std_logic;
    axi_writer_AWADDR : in std_logic_vector(32-1 downto 0);
    axi_writer_AWVALID : in std_logic;
    axi_writer_AWREADY : out std_logic;
    axi_writer_WDATA : in std_logic_vector(32-1 downto 0);
    axi_writer_WVALID : in std_logic;
    axi_writer_WREADY : out std_logic;
    axi_writer_WSTRB : in std_logic_vector(4-1 downto 0);
    axi_writer_BRESP : out std_logic_vector(2-1 downto 0);
    axi_writer_BVALID : out std_logic;
    axi_writer_BREADY : in std_logic
  );
end axi_lite_slave_32;

architecture RTL of axi_lite_slave_32 is

  component dualportram
    generic (
      WIDTH : integer := 32;
      DEPTH : integer := 10;
      WORDS : integer := 1024
    );
    port (
      clk : in std_logic;
      reset : in std_logic;
      length : out signed(31 downto 0);
      address : in signed(31 downto 0);
      din : in signed(WIDTH-1 downto 0);
      dout : out signed(WIDTH-1 downto 0);
      we : in std_logic;
      oe : in std_logic;
      address_b : in signed(31 downto 0);
      din_b : in signed(WIDTH-1 downto 0);
      dout_b : out signed(WIDTH-1 downto 0);
      we_b : in std_logic;
      oe_b : in std_logic
    );
  end component dualportram;

  signal clk_sig : std_logic;
  signal reset_sig : std_logic;
  signal data_length_sig : std_logic_vector(32-1 downto 0);
  signal data_address_sig : std_logic_vector(32-1 downto 0);
  signal data_din_sig : std_logic_vector(32-1 downto 0);
  signal data_dout_sig : std_logic_vector(32-1 downto 0);
  signal data_we_sig : std_logic;
  signal data_oe_sig : std_logic;
  signal axi_reader_ARADDR_sig : std_logic_vector(32-1 downto 0);
  signal axi_reader_ARVALID_sig : std_logic;
  signal axi_reader_ARREADY_sig : std_logic := '0';
  signal axi_reader_RDATA_sig : std_logic_vector(32-1 downto 0) := (others => '0');
  signal axi_reader_RRESP_sig : std_logic_vector(2-1 downto 0) := (others => '0');
  signal axi_reader_RVALID_sig : std_logic := '0';
  signal axi_reader_RREADY_sig : std_logic;
  signal axi_writer_AWADDR_sig : std_logic_vector(32-1 downto 0);
  signal axi_writer_AWVALID_sig : std_logic;
  signal axi_writer_AWREADY_sig : std_logic := '0';
  signal axi_writer_WDATA_sig : std_logic_vector(32-1 downto 0);
  signal axi_writer_WVALID_sig : std_logic;
  signal axi_writer_WREADY_sig : std_logic := '0';
  signal axi_writer_WSTRB_sig : std_logic_vector(4-1 downto 0);
  signal axi_writer_BRESP_sig : std_logic_vector(2-1 downto 0) := (others => '0');
  signal axi_writer_BVALID_sig : std_logic := '0';
  signal axi_writer_BREADY_sig : std_logic;

  signal data_address_b : signed(32-1 downto 0) := (others => '0');
  signal data_din_b : signed(32-1 downto 0) := (others => '0');
  signal data_dout_b : signed(32-1 downto 0);
  signal data_we_b : std_logic := '0';
  signal data_oe_b : std_logic := '0';
  signal U_clk : std_logic;
  signal U_reset : std_logic;
  signal U_length : signed(32-1 downto 0);
  signal U_address : signed(32-1 downto 0);
  signal U_din : signed(32-1 downto 0);
  signal U_dout : signed(32-1 downto 0);
  signal U_we : std_logic;
  signal U_oe : std_logic;
  signal U_address_b : signed(32-1 downto 0);
  signal U_din_b : signed(32-1 downto 0);
  signal U_dout_b : signed(32-1 downto 0);
  signal U_we_b : std_logic;
  signal U_oe_b : std_logic;
  type Type_write_seq is (
    write_seq_IDLE,
    write_seq_s0,
    write_seq_s1,
    write_seq_s2  
  );
  signal write_seq : Type_write_seq := write_seq_IDLE;
  signal write_seq_delay : signed(32-1 downto 0) := (others => '0');
  signal tmp_0001 : std_logic_vector(32-1 downto 0);
  signal tmp_0002 : std_logic;
  signal tmp_0003 : std_logic;
  signal tmp_0004 : std_logic_vector(32-1 downto 0);

begin

  clk_sig <= clk;
  reset_sig <= reset;
  data_length <= data_length_sig;
  data_length_sig <= std_logic_vector(U_length);

  data_address_sig <= data_address;
  data_din_sig <= data_din;
  data_dout <= data_dout_sig;
  data_dout_sig <= std_logic_vector(U_dout);

  data_we_sig <= data_we;
  data_oe_sig <= data_oe;
  axi_reader_ARADDR_sig <= axi_reader_ARADDR;
  axi_reader_ARVALID_sig <= axi_reader_ARVALID;
  axi_reader_ARREADY <= axi_reader_ARREADY_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_reader_ARREADY_sig <= '0';
      else
        if write_seq = write_seq_IDLE then
          axi_reader_ARREADY_sig <= tmp_0003;
        end if;
      end if;
    end if;
  end process;

  axi_reader_RDATA <= axi_reader_RDATA_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_reader_RDATA_sig <= (others => '0');
      else
        if write_seq = write_seq_s2 then
          axi_reader_RDATA_sig <= std_logic_vector(data_dout_b);
        end if;
      end if;
    end if;
  end process;

  axi_reader_RRESP <= axi_reader_RRESP_sig;
  axi_reader_RVALID <= axi_reader_RVALID_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_reader_RVALID_sig <= '0';
      else
        if write_seq = write_seq_s2 then
          axi_reader_RVALID_sig <= '1';
        else
          axi_reader_RVALID_sig <= '0';
        end if;
      end if;
    end if;
  end process;

  axi_reader_RREADY_sig <= axi_reader_RREADY;
  axi_writer_AWADDR_sig <= axi_writer_AWADDR;
  axi_writer_AWVALID_sig <= axi_writer_AWVALID;
  axi_writer_AWREADY <= axi_writer_AWREADY_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_AWREADY_sig <= '0';
      else
        if write_seq = write_seq_IDLE then
          axi_writer_AWREADY_sig <= axi_writer_AWVALID_sig;
        else
          axi_writer_AWREADY_sig <= '0';
        end if;
      end if;
    end if;
  end process;

  axi_writer_WDATA_sig <= axi_writer_WDATA;
  axi_writer_WVALID_sig <= axi_writer_WVALID;
  axi_writer_WREADY <= axi_writer_WREADY_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_WREADY_sig <= '0';
      else
        if write_seq = write_seq_s0 then
          axi_writer_WREADY_sig <= axi_writer_WVALID_sig;
        else
          axi_writer_WREADY_sig <= '0';
        end if;
      end if;
    end if;
  end process;

  axi_writer_WSTRB_sig <= axi_writer_WSTRB;
  axi_writer_BRESP <= axi_writer_BRESP_sig;
  axi_writer_BVALID <= axi_writer_BVALID_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_writer_BVALID_sig <= '0';
      else
        if write_seq = write_seq_IDLE then
          axi_writer_BVALID_sig <= axi_writer_BREADY_sig;
        end if;
      end if;
    end if;
  end process;

  axi_writer_BREADY_sig <= axi_writer_BREADY;

  -- expressions
  tmp_0001 <= (32-1 downto 28 => '0') & axi_writer_AWADDR_sig(29 downto 2);
  tmp_0002 <= not axi_writer_AWVALID_sig;
  tmp_0003 <= axi_reader_ARVALID_sig and tmp_0002;
  tmp_0004 <= (32-1 downto 28 => '0') & axi_reader_ARADDR_sig(29 downto 2);

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
            if axi_writer_AWVALID_sig = '1' then
              write_seq <= write_seq_s0;
            elsif tmp_0003 = '1' then
              write_seq <= write_seq_s1;
            end if;
          when write_seq_s0 => 
            if axi_writer_WVALID_sig = '1' then
              write_seq <= write_seq_IDLE;
            end if;
          when write_seq_s1 => 
            write_seq <= write_seq_s2;
          when write_seq_s2 => 
            if axi_reader_RREADY_sig = '1' then
              write_seq <= write_seq_IDLE;
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
        data_address_b <= (others => '0');
      else
        if write_seq = write_seq_IDLE and axi_writer_AWVALID_sig = '1' then
          data_address_b <= signed(tmp_0001);
        elsif write_seq = write_seq_IDLE and tmp_0003 = '1' then
          data_address_b <= signed(tmp_0004);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        data_din_b <= (others => '0');
      else
        if write_seq = write_seq_s0 and axi_writer_WVALID_sig = '1' then
          data_din_b <= signed(axi_writer_WDATA_sig);
        end if;
      end if;
    end if;
  end process;

  data_dout_b <= U_dout_b;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        data_we_b <= '0';
      else
        if write_seq = write_seq_s0 then
          data_we_b <= axi_writer_WVALID_sig;
        else
          data_we_b <= '0';
        end if;
      end if;
    end if;
  end process;

  U_clk <= clk_sig;

  U_reset <= reset_sig;

  U_address <= signed(data_address_sig);

  U_din <= signed(data_din_sig);

  U_we <= data_we_sig;

  U_oe <= data_oe_sig;

  U_address_b <= data_address_b;

  U_din_b <= data_din_b;

  U_we_b <= data_we_b;

  U_oe_b <= data_oe_b;


  inst_U : dualportram
  generic map(
    WIDTH => 32,
    DEPTH => 10,
    WORDS => 1024
  )
  port map(
    clk => U_clk,
    reset => U_reset,
    length => U_length,
    address => U_address,
    din => U_din,
    dout => U_dout,
    we => U_we,
    oe => U_oe,
    address_b => U_address_b,
    din_b => U_din_b,
    dout_b => U_dout_b,
    we_b => U_we_b,
    oe_b => U_oe_b
  );


end RTL;
