library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity axi_memiface_32 is
  port (
    clk : in std_logic;
    reset : in std_logic;
    data_address : in std_logic_vector(32-1 downto 0);
    data_din : in std_logic_vector(32-1 downto 0);
    data_dout : out std_logic_vector(32-1 downto 0);
    data_we : in std_logic;
    data_oe : in std_logic;
    data_length : out std_logic_vector(32-1 downto 0);
    busy : out std_logic;
    write_kick : in std_logic;
    read_kick : in std_logic;
    burst_size : in std_logic_vector(32-1 downto 0);
    axi_addr : in std_logic_vector(32-1 downto 0);
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
end axi_memiface_32;

architecture RTL of axi_memiface_32 is

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
  signal data_address_sig : std_logic_vector(32-1 downto 0);
  signal data_din_sig : std_logic_vector(32-1 downto 0);
  signal data_dout_sig : std_logic_vector(32-1 downto 0);
  signal data_we_sig : std_logic;
  signal data_oe_sig : std_logic;
  signal data_length_sig : std_logic_vector(32-1 downto 0);
  signal busy_sig : std_logic;
  signal write_kick_sig : std_logic;
  signal read_kick_sig : std_logic;
  signal burst_size_sig : std_logic_vector(32-1 downto 0);
  signal axi_addr_sig : std_logic_vector(32-1 downto 0);
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

  signal BUF_clk : std_logic;
  signal BUF_reset : std_logic;
  signal BUF_length : signed(32-1 downto 0);
  signal BUF_address : signed(32-1 downto 0);
  signal BUF_din : signed(32-1 downto 0);
  signal BUF_dout : signed(32-1 downto 0);
  signal BUF_we : std_logic;
  signal BUF_oe : std_logic;
  signal BUF_address_b : signed(32-1 downto 0) := (others => '0');
  signal BUF_din_b : signed(32-1 downto 0) := (others => '0');
  signal BUF_dout_b : signed(32-1 downto 0);
  signal BUF_we_b : std_logic := '0';
  signal BUF_oe_b : std_logic := '0';
  signal read_state_busy : std_logic := '0';
  signal write_state_busy : std_logic := '0';
  signal tmp_0001 : std_logic;
  signal tmp_0002 : std_logic;
  signal hdl_write_kick_d : std_logic := '0';
  signal tmp_0003 : std_logic;
  signal tmp_0004 : std_logic;
  signal hdl_read_kick_d : std_logic := '0';
  signal tmp_0005 : std_logic;
  signal tmp_0006 : std_logic;
  signal tmp_0007 : std_logic;
  signal tmp_0008 : std_logic;
  type Type_axi is (
    axi_IDLE,
    axi_write_s0,
    axi_write_s1,
    axi_write_s2,
    axi_write_s3,
    axi_write_s4,
    axi_read_s0,
    axi_read_s1  
  );
  signal axi : Type_axi := axi_IDLE;
  signal axi_delay : signed(32-1 downto 0) := (others => '0');
  signal write_count : signed(32-1 downto 0) := (others => '0');
  signal tmp_0009 : signed(32-1 downto 0);
  signal local_rdata_buf0 : signed(32-1 downto 0) := (others => '0');
  signal local_rdata_buf1 : signed(32-1 downto 0) := (others => '0');
  signal tmp_0010 : signed(32-1 downto 0);
  signal buf1_null_flag : std_logic := '0';
  signal tmp_0011 : std_logic_vector(32-1 downto 0);
  signal tmp_0012 : std_logic_vector(8-1 downto 0);
  signal tmp_0013 : std_logic;
  signal tmp_0014 : signed(32-1 downto 0);
  signal tmp_0015 : std_logic;
  signal tmp_0016 : std_logic;
  signal tmp_0017 : std_logic;
  signal tmp_0018 : std_logic;
  signal tmp_0019 : std_logic;
  signal tmp_0020 : std_logic;
  signal tmp_0021 : std_logic;
  signal tmp_0022 : std_logic;
  signal tmp_0023 : std_logic;
  signal tmp_0024 : std_logic;
  signal tmp_0025 : std_logic;
  signal tmp_0026 : std_logic;
  signal tmp_0027 : std_logic;
  signal tmp_0028 : signed(32-1 downto 0);
  signal tmp_0029 : signed(32-1 downto 0);
  signal tmp_0030 : std_logic;
  signal tmp_0031 : signed(32-1 downto 0);
  signal tmp_0032 : std_logic;
  signal tmp_0033 : signed(32-1 downto 0);
  signal tmp_0034 : std_logic;
  signal tmp_0035 : std_logic;
  signal tmp_0036 : signed(32-1 downto 0);
  signal tmp_0037 : std_logic;
  signal tmp_0038 : std_logic;
  signal read_count : signed(32-1 downto 0) := (others => '0');
  signal addr_next : signed(32-1 downto 0) := (others => '0');
  signal tmp_0039 : std_logic_vector(32-1 downto 0);
  signal tmp_0040 : std_logic_vector(8-1 downto 0);
  signal tmp_0041 : std_logic;
  signal tmp_0042 : std_logic;
  signal tmp_0043 : signed(32-1 downto 0);
  signal tmp_0044 : signed(32-1 downto 0);
  signal tmp_0045 : signed(32-1 downto 0);
  signal tmp_0046 : signed(32-1 downto 0);
  signal tmp_0047 : std_logic;

begin

  clk_sig <= clk;
  reset_sig <= reset;
  data_address_sig <= data_address;
  data_din_sig <= data_din;
  data_dout <= data_dout_sig;
  data_dout_sig <= std_logic_vector(BUF_dout);

  data_we_sig <= data_we;
  data_oe_sig <= data_oe;
  data_length <= data_length_sig;
  data_length_sig <= std_logic_vector(BUF_length);

  busy <= busy_sig;
  busy_sig <= tmp_0002;

  write_kick_sig <= write_kick;
  read_kick_sig <= read_kick;
  burst_size_sig <= burst_size;
  axi_addr_sig <= axi_addr;
  forbid_sig <= forbid;
  axi_reader_ARADDR <= axi_reader_ARADDR_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi_reader_ARADDR_sig <= (others => '0');
      else
        if axi = axi_IDLE then
          axi_reader_ARADDR_sig <= axi_addr_sig;
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
        if axi = axi_IDLE then
          axi_reader_ARLEN_sig <= tmp_0040;
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
        if axi = axi_IDLE then
          axi_reader_ARVALID_sig <= tmp_0008;
        elsif axi = axi_read_s0 then
          axi_reader_ARVALID_sig <= tmp_0041;
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
        if axi = axi_IDLE then
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
        if axi = axi_IDLE then
          axi_writer_AWADDR_sig <= axi_addr_sig;
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
        if axi = axi_IDLE then
          axi_writer_AWLEN_sig <= tmp_0012;
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
        if axi = axi_IDLE then
          axi_writer_AWVALID_sig <= tmp_0004;
        elsif axi = axi_write_s0 then
          axi_writer_AWVALID_sig <= tmp_0013;
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
        if axi = axi_write_s2 then
          axi_writer_WDATA_sig <= std_logic_vector(local_rdata_buf0);
        elsif axi = axi_write_s3 then
          axi_writer_WDATA_sig <= std_logic_vector(tmp_0028);
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
        if axi = axi_IDLE then
          axi_writer_WLAST_sig <= '0';
        elsif axi = axi_write_s2 then
          axi_writer_WLAST_sig <= tmp_0016;
        elsif axi = axi_write_s3 then
          axi_writer_WLAST_sig <= tmp_0022;
        elsif axi = axi_write_s4 then
          axi_writer_WLAST_sig <= '0';
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
        if axi = axi_IDLE then
          axi_writer_WVALID_sig <= '0';
        elsif axi = axi_write_s2 then
          axi_writer_WVALID_sig <= '1';
        elsif axi = axi_write_s3 then
          axi_writer_WVALID_sig <= tmp_0027;
        elsif axi = axi_write_s4 then
          axi_writer_WVALID_sig <= '0';
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
        if axi = axi_IDLE then
          axi_writer_BREADY_sig <= '1';
        end if;
      end if;
    end if;
  end process;


  -- expressions
  tmp_0001 <= write_state_busy or read_state_busy;
  tmp_0002 <= tmp_0001 or forbid_sig;
  tmp_0003 <= not hdl_write_kick_d;
  tmp_0004 <= write_kick_sig and tmp_0003;
  tmp_0005 <= not tmp_0004;
  tmp_0006 <= not hdl_read_kick_d;
  tmp_0007 <= read_kick_sig and tmp_0006;
  tmp_0008 <= tmp_0005 and tmp_0007;
  tmp_0009 <= BUF_address_b + 1;
  tmp_0010 <= write_count - 1;
  tmp_0011 <= std_logic_vector(signed(burst_size_sig) - 1);
  tmp_0012 <= tmp_0011(32 - 24 - 1 downto 0);
  tmp_0013 <= not axi_writer_AWREADY_sig;
  tmp_0014 <= tmp_0009 when axi_writer_AWREADY_sig = '1' else BUF_address_b;
  tmp_0015 <= '1' when write_count = 1 else '0';
  tmp_0016 <= '1' when tmp_0015 = '1' else '0';
  tmp_0017 <= '1' when write_count = 1 else '0';
  tmp_0018 <= '0' when axi_writer_WREADY_sig = '1' else '1';
  tmp_0019 <= '1' when write_count = 2 else '0';
  tmp_0020 <= '1' when axi_writer_WREADY_sig = '1' else '0';
  tmp_0021 <= tmp_0020 when tmp_0019 = '1' else '0';
  tmp_0022 <= tmp_0018 when tmp_0017 = '1' else tmp_0021;
  tmp_0023 <= '1' when write_count > 1 else '0';
  tmp_0024 <= '1' when write_count = 1 else '0';
  tmp_0025 <= tmp_0024 and axi_writer_WREADY_sig;
  tmp_0026 <= '0' when tmp_0025 = '1' else '1';
  tmp_0027 <= '1' when tmp_0023 = '1' else tmp_0026;
  tmp_0028 <= local_rdata_buf0 when axi_writer_WREADY_sig = '1' else signed(axi_writer_WDATA_sig);
  tmp_0029 <= local_rdata_buf1 when axi_writer_WREADY_sig = '1' else local_rdata_buf0;
  tmp_0030 <= axi_writer_WREADY_sig or buf1_null_flag;
  tmp_0031 <= BUF_dout_b when tmp_0030 = '1' else local_rdata_buf1;
  tmp_0032 <= axi_writer_WREADY_sig or buf1_null_flag;
  tmp_0033 <= tmp_0009 when tmp_0032 = '1' else BUF_address_b;
  tmp_0034 <= '1' when write_count > 0 else '0';
  tmp_0035 <= axi_writer_WREADY_sig and tmp_0034;
  tmp_0036 <= tmp_0010 when tmp_0035 = '1' else write_count;
  tmp_0037 <= '1' when write_count = 1 else '0';
  tmp_0038 <= tmp_0037 and axi_writer_WREADY_sig;
  tmp_0039 <= std_logic_vector(signed(burst_size_sig) - 1);
  tmp_0040 <= tmp_0039(32 - 24 - 1 downto 0);
  tmp_0041 <= not axi_reader_ARREADY_sig;
  tmp_0042 <= '1' when read_count = 1 else '0';
  tmp_0043 <= read_count - 1;
  tmp_0044 <= addr_next + 1;
  tmp_0045 <= tmp_0043 when axi_reader_RVALID_sig = '1' else read_count;
  tmp_0046 <= tmp_0044 when axi_reader_RVALID_sig = '1' else addr_next;
  tmp_0047 <= axi_reader_RVALID_sig and tmp_0042;

  -- sequencers
  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        axi <= axi_IDLE;
        axi_delay <= (others => '0');
      else
        case (axi) is
          when axi_IDLE => 
            if tmp_0004 = '1' then
              axi <= axi_write_s0;
            elsif tmp_0008 = '1' then
              axi <= axi_read_s0;
            end if;
          when axi_write_s0 => 
            if axi_writer_AWREADY_sig = '1' then
              axi <= axi_write_s1;
            end if;
          when axi_write_s1 => 
            axi <= axi_write_s2;
          when axi_write_s2 => 
            axi <= axi_write_s3;
          when axi_write_s3 => 
            if tmp_0038 = '1' then
              axi <= axi_write_s4;
            end if;
          when axi_write_s4 => 
            if axi_writer_BVALID_sig = '1' then
              axi <= axi_IDLE;
            end if;
          when axi_read_s0 => 
            if axi_reader_ARREADY_sig = '1' then
              axi <= axi_read_s1;
            end if;
          when axi_read_s1 => 
            if tmp_0047 = '1' then
              axi <= axi_IDLE;
            end if;
          when others => null;
        end case;
        hdl_write_kick_d <= write_kick_sig;
        hdl_read_kick_d <= read_kick_sig;
      end if;
    end if;
  end process;


  BUF_clk <= clk_sig;

  BUF_reset <= reset_sig;

  BUF_address <= signed(data_address_sig);

  BUF_din <= signed(data_din_sig);

  BUF_we <= data_we_sig;

  BUF_oe <= data_oe_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        BUF_address_b <= (others => '0');
      else
        if axi = axi_write_s0 then
          BUF_address_b <= tmp_0014;
        elsif axi = axi_write_s1 then
          BUF_address_b <= tmp_0009;
        elsif axi = axi_write_s2 then
          BUF_address_b <= tmp_0009;
        elsif axi = axi_write_s3 then
          BUF_address_b <= tmp_0033;
        elsif axi = axi_IDLE then
          BUF_address_b <= (others => '0');
        elsif axi = axi_read_s1 then
          BUF_address_b <= addr_next;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        BUF_din_b <= (others => '0');
      else
        if axi = axi_read_s1 then
          BUF_din_b <= signed(axi_reader_RDATA_sig);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        BUF_we_b <= '0';
      else
        if axi = axi_read_s1 then
          BUF_we_b <= axi_reader_RVALID_sig;
        else
          BUF_we_b <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        BUF_oe_b <= '0';
      else
        if axi = axi_IDLE then
          BUF_oe_b <= tmp_0004;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_state_busy <= '0';
      else
        if axi = axi_IDLE then
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
        if axi = axi_IDLE then
          write_state_busy <= tmp_0004;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_count <= (others => '0');
      else
        if axi = axi_IDLE then
          write_count <= signed(burst_size_sig);
        elsif axi = axi_write_s3 then
          write_count <= tmp_0036;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        local_rdata_buf0 <= (others => '0');
      else
        if axi = axi_write_s1 then
          local_rdata_buf0 <= BUF_dout_b;
        elsif axi = axi_write_s2 then
          local_rdata_buf0 <= BUF_dout_b;
        elsif axi = axi_write_s3 then
          local_rdata_buf0 <= tmp_0029;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        local_rdata_buf1 <= (others => '0');
      else
        if axi = axi_write_s3 then
          local_rdata_buf1 <= tmp_0031;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        buf1_null_flag <= '0';
      else
        if axi = axi_write_s3 then
          buf1_null_flag <= '0';
        else
          buf1_null_flag <= '1';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_count <= (others => '0');
      else
        if axi = axi_IDLE then
          read_count <= signed(burst_size_sig);
        elsif axi = axi_read_s1 then
          read_count <= tmp_0045;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        addr_next <= (others => '0');
      else
        if axi = axi_IDLE then
          addr_next <= (others => '0');
        elsif axi = axi_read_s1 then
          addr_next <= tmp_0046;
        end if;
      end if;
    end if;
  end process;


  inst_BUF : dualportram
  generic map(
    WIDTH => 32,
    DEPTH => 10,
    WORDS => 1024
  )
  port map(
    clk => BUF_clk,
    reset => BUF_reset,
    length => BUF_length,
    address => BUF_address,
    din => BUF_din,
    dout => BUF_dout,
    we => BUF_we,
    oe => BUF_oe,
    address_b => BUF_address_b,
    din_b => BUF_din_b,
    dout_b => BUF_dout_b,
    we_b => BUF_we_b,
    oe_b => BUF_oe_b
  );


end RTL;
