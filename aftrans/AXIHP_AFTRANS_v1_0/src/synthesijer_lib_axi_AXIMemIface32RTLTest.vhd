library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity synthesijer_lib_axi_AXIMemIface32RTLTest is
  port (
    clk : in std_logic;
    reset : in std_logic;
    class_obj_0000_forbid_exp : in std_logic;
    class_obj_0000_axi_reader_ARADDR_exp : out std_logic_vector(32-1 downto 0);
    class_obj_0000_axi_reader_ARLEN_exp : out std_logic_vector(8-1 downto 0);
    class_obj_0000_axi_reader_ARVALID_exp : out std_logic;
    class_obj_0000_axi_reader_ARREADY_exp : in std_logic;
    class_obj_0000_axi_reader_ARSIZE_exp : out std_logic_vector(3-1 downto 0);
    class_obj_0000_axi_reader_ARBURST_exp : out std_logic_vector(2-1 downto 0);
    class_obj_0000_axi_reader_ARCACHE_exp : out std_logic_vector(4-1 downto 0);
    class_obj_0000_axi_reader_ARPROT_exp : out std_logic_vector(3-1 downto 0);
    class_obj_0000_axi_reader_RDATA_exp : in std_logic_vector(32-1 downto 0);
    class_obj_0000_axi_reader_RRESP_exp : in std_logic_vector(2-1 downto 0);
    class_obj_0000_axi_reader_RLAST_exp : in std_logic;
    class_obj_0000_axi_reader_RVALID_exp : in std_logic;
    class_obj_0000_axi_reader_RREADY_exp : out std_logic;
    class_obj_0000_axi_writer_AWADDR_exp : out std_logic_vector(32-1 downto 0);
    class_obj_0000_axi_writer_AWLEN_exp : out std_logic_vector(8-1 downto 0);
    class_obj_0000_axi_writer_AWVALID_exp : out std_logic;
    class_obj_0000_axi_writer_AWSIZE_exp : out std_logic_vector(3-1 downto 0);
    class_obj_0000_axi_writer_AWBURST_exp : out std_logic_vector(2-1 downto 0);
    class_obj_0000_axi_writer_AWCACHE_exp : out std_logic_vector(4-1 downto 0);
    class_obj_0000_axi_writer_AWPROT_exp : out std_logic_vector(3-1 downto 0);
    class_obj_0000_axi_writer_AWREADY_exp : in std_logic;
    class_obj_0000_axi_writer_WDATA_exp : out std_logic_vector(32-1 downto 0);
    class_obj_0000_axi_writer_WLAST_exp : out std_logic;
    class_obj_0000_axi_writer_WVALID_exp : out std_logic;
    class_obj_0000_axi_writer_WREADY_exp : in std_logic;
    class_obj_0000_axi_writer_WSTRB_exp : out std_logic_vector(4-1 downto 0);
    class_obj_0000_axi_writer_BRESP_exp : in std_logic_vector(2-1 downto 0);
    class_obj_0000_axi_writer_BVALID_exp : in std_logic;
    class_obj_0000_axi_writer_BREADY_exp : out std_logic;
    flush_addr : in signed(32-1 downto 0);
    flush_burst : in signed(32-1 downto 0);
    fetch_addr : in signed(32-1 downto 0);
    fetch_burst : in signed(32-1 downto 0);
    read_offset : in signed(32-1 downto 0);
    write_offset : in signed(32-1 downto 0);
    write_data : in signed(32-1 downto 0);
    flush_busy : out std_logic;
    flush_req : in std_logic;
    fetch_busy : out std_logic;
    fetch_req : in std_logic;
    read_return : out signed(32-1 downto 0);
    read_busy : out std_logic;
    read_req : in std_logic;
    write_busy : out std_logic;
    write_req : in std_logic
  );
end synthesijer_lib_axi_AXIMemIface32RTLTest;

architecture RTL of synthesijer_lib_axi_AXIMemIface32RTLTest is

  attribute mark_debug : string;
  attribute keep : string;

  component axi_memiface_32
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
  end component axi_memiface_32;

  signal clk_sig : std_logic;
  signal reset_sig : std_logic;
  signal class_obj_0000_forbid_exp_sig : std_logic;
  signal class_obj_0000_axi_reader_ARADDR_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_axi_reader_ARLEN_exp_sig : std_logic_vector(8-1 downto 0);
  signal class_obj_0000_axi_reader_ARVALID_exp_sig : std_logic;
  signal class_obj_0000_axi_reader_ARREADY_exp_sig : std_logic;
  signal class_obj_0000_axi_reader_ARSIZE_exp_sig : std_logic_vector(3-1 downto 0);
  signal class_obj_0000_axi_reader_ARBURST_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_obj_0000_axi_reader_ARCACHE_exp_sig : std_logic_vector(4-1 downto 0);
  signal class_obj_0000_axi_reader_ARPROT_exp_sig : std_logic_vector(3-1 downto 0);
  signal class_obj_0000_axi_reader_RDATA_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_axi_reader_RRESP_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_obj_0000_axi_reader_RLAST_exp_sig : std_logic;
  signal class_obj_0000_axi_reader_RVALID_exp_sig : std_logic;
  signal class_obj_0000_axi_reader_RREADY_exp_sig : std_logic;
  signal class_obj_0000_axi_writer_AWADDR_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_axi_writer_AWLEN_exp_sig : std_logic_vector(8-1 downto 0);
  signal class_obj_0000_axi_writer_AWVALID_exp_sig : std_logic;
  signal class_obj_0000_axi_writer_AWSIZE_exp_sig : std_logic_vector(3-1 downto 0);
  signal class_obj_0000_axi_writer_AWBURST_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_obj_0000_axi_writer_AWCACHE_exp_sig : std_logic_vector(4-1 downto 0);
  signal class_obj_0000_axi_writer_AWPROT_exp_sig : std_logic_vector(3-1 downto 0);
  signal class_obj_0000_axi_writer_AWREADY_exp_sig : std_logic;
  signal class_obj_0000_axi_writer_WDATA_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_axi_writer_WLAST_exp_sig : std_logic;
  signal class_obj_0000_axi_writer_WVALID_exp_sig : std_logic;
  signal class_obj_0000_axi_writer_WREADY_exp_sig : std_logic;
  signal class_obj_0000_axi_writer_WSTRB_exp_sig : std_logic_vector(4-1 downto 0);
  signal class_obj_0000_axi_writer_BRESP_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_obj_0000_axi_writer_BVALID_exp_sig : std_logic;
  signal class_obj_0000_axi_writer_BREADY_exp_sig : std_logic;
  signal flush_addr_sig : signed(32-1 downto 0);
  signal flush_burst_sig : signed(32-1 downto 0);
  signal fetch_addr_sig : signed(32-1 downto 0);
  signal fetch_burst_sig : signed(32-1 downto 0);
  signal read_offset_sig : signed(32-1 downto 0);
  signal write_offset_sig : signed(32-1 downto 0);
  signal write_data_sig : signed(32-1 downto 0);
  signal flush_busy_sig : std_logic := '1';
  signal flush_req_sig : std_logic;
  signal fetch_busy_sig : std_logic := '1';
  signal fetch_req_sig : std_logic;
  signal read_return_sig : signed(32-1 downto 0) := (others => '0');
  signal read_busy_sig : std_logic := '1';
  signal read_req_sig : std_logic;
  signal write_busy_sig : std_logic := '1';
  signal write_req_sig : std_logic;

  signal class_obj_0000_clk : std_logic;
  signal class_obj_0000_reset : std_logic;
  signal class_obj_0000_data_address : std_logic_vector(32-1 downto 0) := (others => '0');
  signal class_obj_0000_data_din : std_logic_vector(32-1 downto 0) := (others => '0');
  signal class_obj_0000_data_dout : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_data_we : std_logic := '0';
  signal class_obj_0000_data_oe : std_logic := '0';
  signal class_obj_0000_data_length : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_busy : std_logic;
  signal class_obj_0000_write_kick : std_logic := '0';
  signal class_obj_0000_read_kick : std_logic := '0';
  signal class_obj_0000_burst_size : std_logic_vector(32-1 downto 0) := (others => '0');
  signal class_obj_0000_axi_addr : std_logic_vector(32-1 downto 0) := (others => '0');
  signal class_obj_0000_forbid : std_logic;
  signal class_obj_0000_axi_reader_ARADDR : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_axi_reader_ARLEN : std_logic_vector(8-1 downto 0);
  signal class_obj_0000_axi_reader_ARVALID : std_logic;
  signal class_obj_0000_axi_reader_ARREADY : std_logic;
  signal class_obj_0000_axi_reader_ARSIZE : std_logic_vector(3-1 downto 0);
  signal class_obj_0000_axi_reader_ARBURST : std_logic_vector(2-1 downto 0);
  signal class_obj_0000_axi_reader_ARCACHE : std_logic_vector(4-1 downto 0);
  signal class_obj_0000_axi_reader_ARPROT : std_logic_vector(3-1 downto 0);
  signal class_obj_0000_axi_reader_RDATA : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_axi_reader_RRESP : std_logic_vector(2-1 downto 0);
  signal class_obj_0000_axi_reader_RLAST : std_logic;
  signal class_obj_0000_axi_reader_RVALID : std_logic;
  signal class_obj_0000_axi_reader_RREADY : std_logic;
  signal class_obj_0000_axi_writer_AWADDR : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_axi_writer_AWLEN : std_logic_vector(8-1 downto 0);
  signal class_obj_0000_axi_writer_AWVALID : std_logic;
  signal class_obj_0000_axi_writer_AWSIZE : std_logic_vector(3-1 downto 0);
  signal class_obj_0000_axi_writer_AWBURST : std_logic_vector(2-1 downto 0);
  signal class_obj_0000_axi_writer_AWCACHE : std_logic_vector(4-1 downto 0);
  signal class_obj_0000_axi_writer_AWPROT : std_logic_vector(3-1 downto 0);
  signal class_obj_0000_axi_writer_AWREADY : std_logic;
  signal class_obj_0000_axi_writer_WDATA : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_axi_writer_WLAST : std_logic;
  signal class_obj_0000_axi_writer_WVALID : std_logic;
  signal class_obj_0000_axi_writer_WREADY : std_logic;
  signal class_obj_0000_axi_writer_WSTRB : std_logic_vector(4-1 downto 0);
  signal class_obj_0000_axi_writer_BRESP : std_logic_vector(2-1 downto 0);
  signal class_obj_0000_axi_writer_BVALID : std_logic;
  signal class_obj_0000_axi_writer_BREADY : std_logic;
  signal flush_addr_0002 : signed(32-1 downto 0) := (others => '0');
  signal flush_addr_local : signed(32-1 downto 0) := (others => '0');
  signal flush_burst_0003 : signed(32-1 downto 0) := (others => '0');
  signal flush_burst_local : signed(32-1 downto 0) := (others => '0');
  signal field_access_00004 : std_logic := '0';
  signal binary_expr_00005 : std_logic := '0';
  signal field_access_00006 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00007 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00008 : std_logic := '0';
  signal field_access_00009 : std_logic := '0';
  signal fetch_addr_0010 : signed(32-1 downto 0) := (others => '0');
  signal fetch_addr_local : signed(32-1 downto 0) := (others => '0');
  signal fetch_burst_0011 : signed(32-1 downto 0) := (others => '0');
  signal fetch_burst_local : signed(32-1 downto 0) := (others => '0');
  signal field_access_00012 : std_logic := '0';
  signal binary_expr_00013 : std_logic := '0';
  signal field_access_00014 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00015 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00016 : std_logic := '0';
  signal field_access_00017 : std_logic := '0';
  signal field_access_00018 : std_logic := '0';
  signal binary_expr_00019 : std_logic := '0';
  signal read_offset_0020 : signed(32-1 downto 0) := (others => '0');
  signal read_offset_local : signed(32-1 downto 0) := (others => '0');
  signal field_access_00021 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00022 : signed(32-1 downto 0) := (others => '0');
  signal write_offset_0023 : signed(32-1 downto 0) := (others => '0');
  signal write_offset_local : signed(32-1 downto 0) := (others => '0');
  signal write_data_0024 : signed(32-1 downto 0) := (others => '0');
  signal write_data_local : signed(32-1 downto 0) := (others => '0');
  signal field_access_00025 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00026 : signed(32-1 downto 0) := (others => '0');
  signal flush_req_flag : std_logic;
  signal flush_req_local : std_logic := '0';
  signal tmp_0001 : std_logic;
  signal fetch_req_flag : std_logic;
  signal fetch_req_local : std_logic := '0';
  signal tmp_0002 : std_logic;
  signal read_req_flag : std_logic;
  signal read_req_local : std_logic := '0';
  signal tmp_0003 : std_logic;
  signal write_req_flag : std_logic;
  signal write_req_local : std_logic := '0';
  signal tmp_0004 : std_logic;
  type Type_flush_method is (
    flush_method_IDLE,
    flush_method_S_0000,
    flush_method_S_0001,
    flush_method_S_0002,
    flush_method_S_0003,
    flush_method_S_0004,
    flush_method_S_0005,
    flush_method_S_0006,
    flush_method_S_0007,
    flush_method_S_0008,
    flush_method_S_0009,
    flush_method_S_0010,
    flush_method_S_0011,
    flush_method_S_0012,
    flush_method_S_0013,
    flush_method_S_0014,
    flush_method_S_0015  
  );
  signal flush_method : Type_flush_method := flush_method_IDLE;
  signal flush_method_delay : signed(32-1 downto 0) := (others => '0');
  signal flush_req_flag_d : std_logic := '0';
  signal flush_req_flag_edge : std_logic;
  signal tmp_0005 : std_logic;
  signal tmp_0006 : std_logic;
  signal tmp_0007 : std_logic;
  signal tmp_0008 : std_logic;
  signal tmp_0009 : std_logic;
  signal tmp_0010 : std_logic;
  signal tmp_0011 : std_logic;
  signal tmp_0012 : std_logic;
  signal tmp_0013 : std_logic;
  signal tmp_0014 : std_logic;
  signal tmp_0015 : signed(32-1 downto 0);
  signal tmp_0016 : signed(32-1 downto 0);
  signal tmp_0017 : std_logic;
  type Type_fetch_method is (
    fetch_method_IDLE,
    fetch_method_S_0000,
    fetch_method_S_0001,
    fetch_method_S_0002,
    fetch_method_S_0003,
    fetch_method_S_0004,
    fetch_method_S_0005,
    fetch_method_S_0006,
    fetch_method_S_0007,
    fetch_method_S_0008,
    fetch_method_S_0009,
    fetch_method_S_0010,
    fetch_method_S_0011,
    fetch_method_S_0012,
    fetch_method_S_0013,
    fetch_method_S_0014,
    fetch_method_S_0015,
    fetch_method_S_0016,
    fetch_method_S_0017,
    fetch_method_S_0018,
    fetch_method_S_0019,
    fetch_method_S_0020  
  );
  signal fetch_method : Type_fetch_method := fetch_method_IDLE;
  signal fetch_method_delay : signed(32-1 downto 0) := (others => '0');
  signal fetch_req_flag_d : std_logic := '0';
  signal fetch_req_flag_edge : std_logic;
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
  signal tmp_0028 : std_logic;
  signal tmp_0029 : std_logic;
  signal tmp_0030 : signed(32-1 downto 0);
  signal tmp_0031 : signed(32-1 downto 0);
  signal tmp_0032 : std_logic;
  signal tmp_0033 : std_logic;
  type Type_read_method is (
    read_method_IDLE,
    read_method_S_0000,
    read_method_S_0001,
    read_method_S_0002,
    read_method_S_0003,
    read_method_S_0004,
    read_method_S_0005  
  );
  signal read_method : Type_read_method := read_method_IDLE;
  signal read_method_delay : signed(32-1 downto 0) := (others => '0');
  signal read_req_flag_d : std_logic := '0';
  signal read_req_flag_edge : std_logic;
  signal tmp_0034 : std_logic;
  signal tmp_0035 : std_logic;
  signal tmp_0036 : std_logic;
  signal tmp_0037 : std_logic;
  signal tmp_0038 : std_logic;
  signal tmp_0039 : std_logic;
  signal tmp_0040 : std_logic;
  signal tmp_0041 : std_logic;
  signal tmp_0042 : signed(32-1 downto 0);
  type Type_write_method is (
    write_method_IDLE,
    write_method_S_0000,
    write_method_S_0001,
    write_method_S_0002,
    write_method_S_0003,
    write_method_S_0005  
  );
  signal write_method : Type_write_method := write_method_IDLE;
  signal write_method_delay : signed(32-1 downto 0) := (others => '0');
  signal write_req_flag_d : std_logic := '0';
  signal write_req_flag_edge : std_logic;
  signal tmp_0043 : std_logic;
  signal tmp_0044 : std_logic;
  signal tmp_0045 : std_logic;
  signal tmp_0046 : std_logic;
  signal tmp_0047 : std_logic;
  signal tmp_0048 : std_logic;
  signal tmp_0049 : std_logic;
  signal tmp_0050 : std_logic;
  signal tmp_0051 : signed(32-1 downto 0);
  signal tmp_0052 : signed(32-1 downto 0);

begin

  clk_sig <= clk;
  reset_sig <= reset;
  class_obj_0000_forbid_exp_sig <= class_obj_0000_forbid_exp;
  class_obj_0000_axi_reader_ARADDR_exp <= class_obj_0000_axi_reader_ARADDR_exp_sig;
  class_obj_0000_axi_reader_ARADDR_exp_sig <= class_obj_0000_axi_reader_ARADDR;

  class_obj_0000_axi_reader_ARLEN_exp <= class_obj_0000_axi_reader_ARLEN_exp_sig;
  class_obj_0000_axi_reader_ARLEN_exp_sig <= class_obj_0000_axi_reader_ARLEN;

  class_obj_0000_axi_reader_ARVALID_exp <= class_obj_0000_axi_reader_ARVALID_exp_sig;
  class_obj_0000_axi_reader_ARVALID_exp_sig <= class_obj_0000_axi_reader_ARVALID;

  class_obj_0000_axi_reader_ARREADY_exp_sig <= class_obj_0000_axi_reader_ARREADY_exp;
  class_obj_0000_axi_reader_ARSIZE_exp <= class_obj_0000_axi_reader_ARSIZE_exp_sig;
  class_obj_0000_axi_reader_ARSIZE_exp_sig <= class_obj_0000_axi_reader_ARSIZE;

  class_obj_0000_axi_reader_ARBURST_exp <= class_obj_0000_axi_reader_ARBURST_exp_sig;
  class_obj_0000_axi_reader_ARBURST_exp_sig <= class_obj_0000_axi_reader_ARBURST;

  class_obj_0000_axi_reader_ARCACHE_exp <= class_obj_0000_axi_reader_ARCACHE_exp_sig;
  class_obj_0000_axi_reader_ARCACHE_exp_sig <= class_obj_0000_axi_reader_ARCACHE;

  class_obj_0000_axi_reader_ARPROT_exp <= class_obj_0000_axi_reader_ARPROT_exp_sig;
  class_obj_0000_axi_reader_ARPROT_exp_sig <= class_obj_0000_axi_reader_ARPROT;

  class_obj_0000_axi_reader_RDATA_exp_sig <= class_obj_0000_axi_reader_RDATA_exp;
  class_obj_0000_axi_reader_RRESP_exp_sig <= class_obj_0000_axi_reader_RRESP_exp;
  class_obj_0000_axi_reader_RLAST_exp_sig <= class_obj_0000_axi_reader_RLAST_exp;
  class_obj_0000_axi_reader_RVALID_exp_sig <= class_obj_0000_axi_reader_RVALID_exp;
  class_obj_0000_axi_reader_RREADY_exp <= class_obj_0000_axi_reader_RREADY_exp_sig;
  class_obj_0000_axi_reader_RREADY_exp_sig <= class_obj_0000_axi_reader_RREADY;

  class_obj_0000_axi_writer_AWADDR_exp <= class_obj_0000_axi_writer_AWADDR_exp_sig;
  class_obj_0000_axi_writer_AWADDR_exp_sig <= class_obj_0000_axi_writer_AWADDR;

  class_obj_0000_axi_writer_AWLEN_exp <= class_obj_0000_axi_writer_AWLEN_exp_sig;
  class_obj_0000_axi_writer_AWLEN_exp_sig <= class_obj_0000_axi_writer_AWLEN;

  class_obj_0000_axi_writer_AWVALID_exp <= class_obj_0000_axi_writer_AWVALID_exp_sig;
  class_obj_0000_axi_writer_AWVALID_exp_sig <= class_obj_0000_axi_writer_AWVALID;

  class_obj_0000_axi_writer_AWSIZE_exp <= class_obj_0000_axi_writer_AWSIZE_exp_sig;
  class_obj_0000_axi_writer_AWSIZE_exp_sig <= class_obj_0000_axi_writer_AWSIZE;

  class_obj_0000_axi_writer_AWBURST_exp <= class_obj_0000_axi_writer_AWBURST_exp_sig;
  class_obj_0000_axi_writer_AWBURST_exp_sig <= class_obj_0000_axi_writer_AWBURST;

  class_obj_0000_axi_writer_AWCACHE_exp <= class_obj_0000_axi_writer_AWCACHE_exp_sig;
  class_obj_0000_axi_writer_AWCACHE_exp_sig <= class_obj_0000_axi_writer_AWCACHE;

  class_obj_0000_axi_writer_AWPROT_exp <= class_obj_0000_axi_writer_AWPROT_exp_sig;
  class_obj_0000_axi_writer_AWPROT_exp_sig <= class_obj_0000_axi_writer_AWPROT;

  class_obj_0000_axi_writer_AWREADY_exp_sig <= class_obj_0000_axi_writer_AWREADY_exp;
  class_obj_0000_axi_writer_WDATA_exp <= class_obj_0000_axi_writer_WDATA_exp_sig;
  class_obj_0000_axi_writer_WDATA_exp_sig <= class_obj_0000_axi_writer_WDATA;

  class_obj_0000_axi_writer_WLAST_exp <= class_obj_0000_axi_writer_WLAST_exp_sig;
  class_obj_0000_axi_writer_WLAST_exp_sig <= class_obj_0000_axi_writer_WLAST;

  class_obj_0000_axi_writer_WVALID_exp <= class_obj_0000_axi_writer_WVALID_exp_sig;
  class_obj_0000_axi_writer_WVALID_exp_sig <= class_obj_0000_axi_writer_WVALID;

  class_obj_0000_axi_writer_WREADY_exp_sig <= class_obj_0000_axi_writer_WREADY_exp;
  class_obj_0000_axi_writer_WSTRB_exp <= class_obj_0000_axi_writer_WSTRB_exp_sig;
  class_obj_0000_axi_writer_WSTRB_exp_sig <= class_obj_0000_axi_writer_WSTRB;

  class_obj_0000_axi_writer_BRESP_exp_sig <= class_obj_0000_axi_writer_BRESP_exp;
  class_obj_0000_axi_writer_BVALID_exp_sig <= class_obj_0000_axi_writer_BVALID_exp;
  class_obj_0000_axi_writer_BREADY_exp <= class_obj_0000_axi_writer_BREADY_exp_sig;
  class_obj_0000_axi_writer_BREADY_exp_sig <= class_obj_0000_axi_writer_BREADY;

  flush_addr_sig <= flush_addr;
  flush_burst_sig <= flush_burst;
  fetch_addr_sig <= fetch_addr;
  fetch_burst_sig <= fetch_burst;
  read_offset_sig <= read_offset;
  write_offset_sig <= write_offset;
  write_data_sig <= write_data;
  flush_busy <= flush_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        flush_busy_sig <= '1';
      else
        if flush_method = flush_method_S_0000 then
          flush_busy_sig <= '0';
        elsif flush_method = flush_method_S_0001 then
          flush_busy_sig <= tmp_0008;
        end if;
      end if;
    end if;
  end process;

  flush_req_sig <= flush_req;
  fetch_busy <= fetch_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fetch_busy_sig <= '1';
      else
        if fetch_method = fetch_method_S_0000 then
          fetch_busy_sig <= '0';
        elsif fetch_method = fetch_method_S_0001 then
          fetch_busy_sig <= tmp_0021;
        end if;
      end if;
    end if;
  end process;

  fetch_req_sig <= fetch_req;
  read_return <= read_return_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_return_sig <= (others => '0');
      else
        if read_method = read_method_S_0004 then
          read_return_sig <= array_access_00022;
        end if;
      end if;
    end if;
  end process;

  read_busy <= read_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_busy_sig <= '1';
      else
        if read_method = read_method_S_0000 then
          read_busy_sig <= '0';
        elsif read_method = read_method_S_0001 then
          read_busy_sig <= tmp_0037;
        end if;
      end if;
    end if;
  end process;

  read_req_sig <= read_req;
  write_busy <= write_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_busy_sig <= '1';
      else
        if write_method = write_method_S_0000 then
          write_busy_sig <= '0';
        elsif write_method = write_method_S_0001 then
          write_busy_sig <= tmp_0046;
        end if;
      end if;
    end if;
  end process;

  write_req_sig <= write_req;

  -- expressions
  tmp_0001 <= flush_req_local or flush_req_sig;
  tmp_0002 <= fetch_req_local or fetch_req_sig;
  tmp_0003 <= read_req_local or read_req_sig;
  tmp_0004 <= write_req_local or write_req_sig;
  tmp_0005 <= not flush_req_flag_d;
  tmp_0006 <= flush_req_flag and tmp_0005;
  tmp_0007 <= flush_req_flag or flush_req_flag_d;
  tmp_0008 <= flush_req_flag or flush_req_flag_d;
  tmp_0009 <= '1' when binary_expr_00005 = '1' else '0';
  tmp_0010 <= '1' when binary_expr_00005 = '0' else '0';
  tmp_0011 <= '1' when flush_method /= flush_method_S_0000 else '0';
  tmp_0012 <= '1' when flush_method /= flush_method_S_0001 else '0';
  tmp_0013 <= tmp_0012 and flush_req_flag_edge;
  tmp_0014 <= tmp_0011 and tmp_0013;
  tmp_0015 <= flush_addr_sig when flush_req_sig = '1' else flush_addr_local;
  tmp_0016 <= flush_burst_sig when flush_req_sig = '1' else flush_burst_local;
  tmp_0017 <= '1' when field_access_00004 = '1' else '0';
  tmp_0018 <= not fetch_req_flag_d;
  tmp_0019 <= fetch_req_flag and tmp_0018;
  tmp_0020 <= fetch_req_flag or fetch_req_flag_d;
  tmp_0021 <= fetch_req_flag or fetch_req_flag_d;
  tmp_0022 <= '1' when binary_expr_00013 = '1' else '0';
  tmp_0023 <= '1' when binary_expr_00013 = '0' else '0';
  tmp_0024 <= '1' when binary_expr_00019 = '1' else '0';
  tmp_0025 <= '1' when binary_expr_00019 = '0' else '0';
  tmp_0026 <= '1' when fetch_method /= fetch_method_S_0000 else '0';
  tmp_0027 <= '1' when fetch_method /= fetch_method_S_0001 else '0';
  tmp_0028 <= tmp_0027 and fetch_req_flag_edge;
  tmp_0029 <= tmp_0026 and tmp_0028;
  tmp_0030 <= fetch_addr_sig when fetch_req_sig = '1' else fetch_addr_local;
  tmp_0031 <= fetch_burst_sig when fetch_req_sig = '1' else fetch_burst_local;
  tmp_0032 <= '1' when field_access_00012 = '1' else '0';
  tmp_0033 <= '1' when field_access_00018 = '1' else '0';
  tmp_0034 <= not read_req_flag_d;
  tmp_0035 <= read_req_flag and tmp_0034;
  tmp_0036 <= read_req_flag or read_req_flag_d;
  tmp_0037 <= read_req_flag or read_req_flag_d;
  tmp_0038 <= '1' when read_method /= read_method_S_0000 else '0';
  tmp_0039 <= '1' when read_method /= read_method_S_0001 else '0';
  tmp_0040 <= tmp_0039 and read_req_flag_edge;
  tmp_0041 <= tmp_0038 and tmp_0040;
  tmp_0042 <= read_offset_sig when read_req_sig = '1' else read_offset_local;
  tmp_0043 <= not write_req_flag_d;
  tmp_0044 <= write_req_flag and tmp_0043;
  tmp_0045 <= write_req_flag or write_req_flag_d;
  tmp_0046 <= write_req_flag or write_req_flag_d;
  tmp_0047 <= '1' when write_method /= write_method_S_0000 else '0';
  tmp_0048 <= '1' when write_method /= write_method_S_0001 else '0';
  tmp_0049 <= tmp_0048 and write_req_flag_edge;
  tmp_0050 <= tmp_0047 and tmp_0049;
  tmp_0051 <= write_offset_sig when write_req_sig = '1' else write_offset_local;
  tmp_0052 <= write_data_sig when write_req_sig = '1' else write_data_local;

  -- sequencers
  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        flush_method <= flush_method_IDLE;
        flush_method_delay <= (others => '0');
      else
        case (flush_method) is
          when flush_method_IDLE => 
            flush_method <= flush_method_S_0000;
          when flush_method_S_0000 => 
            flush_method <= flush_method_S_0001;
          when flush_method_S_0001 => 
            if tmp_0007 = '1' then
              flush_method <= flush_method_S_0002;
            end if;
          when flush_method_S_0002 => 
            flush_method <= flush_method_S_0003;
          when flush_method_S_0003 => 
            flush_method <= flush_method_S_0004;
          when flush_method_S_0004 => 
            if tmp_0009 = '1' then
              flush_method <= flush_method_S_0006;
            elsif tmp_0010 = '1' then
              flush_method <= flush_method_S_0005;
            end if;
          when flush_method_S_0005 => 
            flush_method <= flush_method_S_0007;
          when flush_method_S_0006 => 
            flush_method <= flush_method_S_0002;
          when flush_method_S_0007 => 
            flush_method <= flush_method_S_0008;
          when flush_method_S_0008 => 
            flush_method <= flush_method_S_0009;
          when flush_method_S_0009 => 
            flush_method <= flush_method_S_0010;
          when flush_method_S_0010 => 
            flush_method <= flush_method_S_0011;
          when flush_method_S_0011 => 
            flush_method <= flush_method_S_0012;
          when flush_method_S_0012 => 
            flush_method <= flush_method_S_0013;
          when flush_method_S_0013 => 
            flush_method <= flush_method_S_0014;
          when flush_method_S_0014 => 
            flush_method <= flush_method_S_0015;
          when flush_method_S_0015 => 
            flush_method <= flush_method_S_0000;
          when others => null;
        end case;
        flush_req_flag_d <= flush_req_flag;
        if (tmp_0011 and tmp_0013) = '1' then
          flush_method <= flush_method_S_0001;
        end if;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fetch_method <= fetch_method_IDLE;
        fetch_method_delay <= (others => '0');
      else
        case (fetch_method) is
          when fetch_method_IDLE => 
            fetch_method <= fetch_method_S_0000;
          when fetch_method_S_0000 => 
            fetch_method <= fetch_method_S_0001;
          when fetch_method_S_0001 => 
            if tmp_0020 = '1' then
              fetch_method <= fetch_method_S_0002;
            end if;
          when fetch_method_S_0002 => 
            fetch_method <= fetch_method_S_0003;
          when fetch_method_S_0003 => 
            fetch_method <= fetch_method_S_0004;
          when fetch_method_S_0004 => 
            if tmp_0022 = '1' then
              fetch_method <= fetch_method_S_0006;
            elsif tmp_0023 = '1' then
              fetch_method <= fetch_method_S_0005;
            end if;
          when fetch_method_S_0005 => 
            fetch_method <= fetch_method_S_0007;
          when fetch_method_S_0006 => 
            fetch_method <= fetch_method_S_0002;
          when fetch_method_S_0007 => 
            fetch_method <= fetch_method_S_0008;
          when fetch_method_S_0008 => 
            fetch_method <= fetch_method_S_0009;
          when fetch_method_S_0009 => 
            fetch_method <= fetch_method_S_0010;
          when fetch_method_S_0010 => 
            fetch_method <= fetch_method_S_0011;
          when fetch_method_S_0011 => 
            fetch_method <= fetch_method_S_0012;
          when fetch_method_S_0012 => 
            fetch_method <= fetch_method_S_0013;
          when fetch_method_S_0013 => 
            fetch_method <= fetch_method_S_0014;
          when fetch_method_S_0014 => 
            fetch_method <= fetch_method_S_0015;
          when fetch_method_S_0015 => 
            fetch_method <= fetch_method_S_0016;
          when fetch_method_S_0016 => 
            fetch_method <= fetch_method_S_0017;
          when fetch_method_S_0017 => 
            if tmp_0024 = '1' then
              fetch_method <= fetch_method_S_0019;
            elsif tmp_0025 = '1' then
              fetch_method <= fetch_method_S_0018;
            end if;
          when fetch_method_S_0018 => 
            fetch_method <= fetch_method_S_0020;
          when fetch_method_S_0019 => 
            fetch_method <= fetch_method_S_0015;
          when fetch_method_S_0020 => 
            fetch_method <= fetch_method_S_0000;
          when others => null;
        end case;
        fetch_req_flag_d <= fetch_req_flag;
        if (tmp_0026 and tmp_0028) = '1' then
          fetch_method <= fetch_method_S_0001;
        end if;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_method <= read_method_IDLE;
        read_method_delay <= (others => '0');
      else
        case (read_method) is
          when read_method_IDLE => 
            read_method <= read_method_S_0000;
          when read_method_S_0000 => 
            read_method <= read_method_S_0001;
          when read_method_S_0001 => 
            if tmp_0036 = '1' then
              read_method <= read_method_S_0002;
            end if;
          when read_method_S_0002 => 
            read_method <= read_method_S_0003;
          when read_method_S_0003 => 
            if read_method_delay >= 2 then
              read_method_delay <= (others => '0');
              read_method <= read_method_S_0004;
            else
              read_method_delay <= read_method_delay + 1;
            end if;
          when read_method_S_0004 => 
            read_method <= read_method_S_0000;
          when read_method_S_0005 => 
            read_method <= read_method_S_0000;
          when others => null;
        end case;
        read_req_flag_d <= read_req_flag;
        if (tmp_0038 and tmp_0040) = '1' then
          read_method <= read_method_S_0001;
        end if;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_method <= write_method_IDLE;
        write_method_delay <= (others => '0');
      else
        case (write_method) is
          when write_method_IDLE => 
            write_method <= write_method_S_0000;
          when write_method_S_0000 => 
            write_method <= write_method_S_0001;
          when write_method_S_0001 => 
            if tmp_0045 = '1' then
              write_method <= write_method_S_0002;
            end if;
          when write_method_S_0002 => 
            write_method <= write_method_S_0003;
          when write_method_S_0003 => 
            write_method <= write_method_S_0005;
          when write_method_S_0005 => 
            write_method <= write_method_S_0000;
          when others => null;
        end case;
        write_req_flag_d <= write_req_flag;
        if (tmp_0047 and tmp_0049) = '1' then
          write_method <= write_method_S_0001;
        end if;
      end if;
    end if;
  end process;


  class_obj_0000_clk <= clk_sig;

  class_obj_0000_reset <= reset_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_obj_0000_data_address <= (others => '0');
      else
        if read_method = read_method_S_0003 and read_method_delay = 0 then
          class_obj_0000_data_address <= std_logic_vector(read_offset_0020);
        elsif write_method = write_method_S_0003 then
          class_obj_0000_data_address <= std_logic_vector(write_offset_0023);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_obj_0000_data_din <= (others => '0');
      else
        if write_method = write_method_S_0003 then
          class_obj_0000_data_din <= std_logic_vector(write_data_0024);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_obj_0000_data_we <= '0';
      else
        if write_method = write_method_S_0003 then
          class_obj_0000_data_we <= '1';
        else
          class_obj_0000_data_we <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_obj_0000_data_oe <= '0';
      else
        if read_method = read_method_S_0003 and read_method_delay = 0 then
          class_obj_0000_data_oe <= '1';
        else
          class_obj_0000_data_oe <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_obj_0000_write_kick <= '0';
      else
        if flush_method = flush_method_S_0012 then
          class_obj_0000_write_kick <= '1';
        elsif flush_method = flush_method_S_0014 then
          class_obj_0000_write_kick <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_obj_0000_read_kick <= '0';
      else
        if fetch_method = fetch_method_S_0012 then
          class_obj_0000_read_kick <= '1';
        elsif fetch_method = fetch_method_S_0014 then
          class_obj_0000_read_kick <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_obj_0000_burst_size <= (others => '0');
      else
        if flush_method = flush_method_S_0010 then
          class_obj_0000_burst_size <= std_logic_vector(flush_burst_0003);
        elsif fetch_method = fetch_method_S_0010 then
          class_obj_0000_burst_size <= std_logic_vector(fetch_burst_0011);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_obj_0000_axi_addr <= (others => '0');
      else
        if flush_method = flush_method_S_0008 then
          class_obj_0000_axi_addr <= std_logic_vector(flush_addr_0002);
        elsif fetch_method = fetch_method_S_0008 then
          class_obj_0000_axi_addr <= std_logic_vector(fetch_addr_0010);
        end if;
      end if;
    end if;
  end process;

  class_obj_0000_forbid <= class_obj_0000_forbid_exp_sig;

  class_obj_0000_axi_reader_ARREADY <= class_obj_0000_axi_reader_ARREADY_exp_sig;

  class_obj_0000_axi_reader_RDATA <= class_obj_0000_axi_reader_RDATA_exp_sig;

  class_obj_0000_axi_reader_RRESP <= class_obj_0000_axi_reader_RRESP_exp_sig;

  class_obj_0000_axi_reader_RLAST <= class_obj_0000_axi_reader_RLAST_exp_sig;

  class_obj_0000_axi_reader_RVALID <= class_obj_0000_axi_reader_RVALID_exp_sig;

  class_obj_0000_axi_writer_AWREADY <= class_obj_0000_axi_writer_AWREADY_exp_sig;

  class_obj_0000_axi_writer_WREADY <= class_obj_0000_axi_writer_WREADY_exp_sig;

  class_obj_0000_axi_writer_BRESP <= class_obj_0000_axi_writer_BRESP_exp_sig;

  class_obj_0000_axi_writer_BVALID <= class_obj_0000_axi_writer_BVALID_exp_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        flush_addr_0002 <= (others => '0');
      else
        if flush_method = flush_method_S_0001 then
          flush_addr_0002 <= tmp_0015;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        flush_burst_0003 <= (others => '0');
      else
        if flush_method = flush_method_S_0001 then
          flush_burst_0003 <= tmp_0016;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00004 <= '0';
      else
        if flush_method = flush_method_S_0002 then
          field_access_00004 <= class_obj_0000_busy;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00005 <= '0';
      else
        if flush_method = flush_method_S_0003 then
          binary_expr_00005 <= tmp_0017;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00006 <= (others => '0');
      else
        if flush_method = flush_method_S_0007 then
          field_access_00006 <= signed(class_obj_0000_axi_addr);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00007 <= (others => '0');
      else
        if flush_method = flush_method_S_0009 then
          field_access_00007 <= signed(class_obj_0000_burst_size);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00008 <= '0';
      else
        if flush_method = flush_method_S_0011 then
          field_access_00008 <= class_obj_0000_write_kick;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00009 <= '0';
      else
        if flush_method = flush_method_S_0013 then
          field_access_00009 <= class_obj_0000_write_kick;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fetch_addr_0010 <= (others => '0');
      else
        if fetch_method = fetch_method_S_0001 then
          fetch_addr_0010 <= tmp_0030;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        fetch_burst_0011 <= (others => '0');
      else
        if fetch_method = fetch_method_S_0001 then
          fetch_burst_0011 <= tmp_0031;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00012 <= '0';
      else
        if fetch_method = fetch_method_S_0002 then
          field_access_00012 <= class_obj_0000_busy;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00013 <= '0';
      else
        if fetch_method = fetch_method_S_0003 then
          binary_expr_00013 <= tmp_0032;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00014 <= (others => '0');
      else
        if fetch_method = fetch_method_S_0007 then
          field_access_00014 <= signed(class_obj_0000_axi_addr);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00015 <= (others => '0');
      else
        if fetch_method = fetch_method_S_0009 then
          field_access_00015 <= signed(class_obj_0000_burst_size);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00016 <= '0';
      else
        if fetch_method = fetch_method_S_0011 then
          field_access_00016 <= class_obj_0000_read_kick;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00017 <= '0';
      else
        if fetch_method = fetch_method_S_0013 then
          field_access_00017 <= class_obj_0000_read_kick;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00018 <= '0';
      else
        if fetch_method = fetch_method_S_0015 then
          field_access_00018 <= class_obj_0000_busy;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00019 <= '0';
      else
        if fetch_method = fetch_method_S_0016 then
          binary_expr_00019 <= tmp_0033;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_offset_0020 <= (others => '0');
      else
        if read_method = read_method_S_0001 then
          read_offset_0020 <= tmp_0042;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00022 <= (others => '0');
      else
        if read_method = read_method_S_0003 and read_method_delay = 2 then
          array_access_00022 <= signed(class_obj_0000_data_dout);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_offset_0023 <= (others => '0');
      else
        if write_method = write_method_S_0001 then
          write_offset_0023 <= tmp_0051;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_data_0024 <= (others => '0');
      else
        if write_method = write_method_S_0001 then
          write_data_0024 <= tmp_0052;
        end if;
      end if;
    end if;
  end process;

  flush_req_flag <= tmp_0001;

  fetch_req_flag <= tmp_0002;

  read_req_flag <= tmp_0003;

  write_req_flag <= tmp_0004;

  flush_req_flag_edge <= tmp_0006;

  fetch_req_flag_edge <= tmp_0019;

  read_req_flag_edge <= tmp_0035;

  write_req_flag_edge <= tmp_0044;


  inst_class_obj_0000 : axi_memiface_32
  port map(
    clk => class_obj_0000_clk,
    reset => class_obj_0000_reset,
    data_address => class_obj_0000_data_address,
    data_din => class_obj_0000_data_din,
    data_dout => class_obj_0000_data_dout,
    data_we => class_obj_0000_data_we,
    data_oe => class_obj_0000_data_oe,
    data_length => class_obj_0000_data_length,
    busy => class_obj_0000_busy,
    write_kick => class_obj_0000_write_kick,
    read_kick => class_obj_0000_read_kick,
    burst_size => class_obj_0000_burst_size,
    axi_addr => class_obj_0000_axi_addr,
    forbid => class_obj_0000_forbid,
    axi_reader_ARADDR => class_obj_0000_axi_reader_ARADDR,
    axi_reader_ARLEN => class_obj_0000_axi_reader_ARLEN,
    axi_reader_ARVALID => class_obj_0000_axi_reader_ARVALID,
    axi_reader_ARREADY => class_obj_0000_axi_reader_ARREADY,
    axi_reader_ARSIZE => class_obj_0000_axi_reader_ARSIZE,
    axi_reader_ARBURST => class_obj_0000_axi_reader_ARBURST,
    axi_reader_ARCACHE => class_obj_0000_axi_reader_ARCACHE,
    axi_reader_ARPROT => class_obj_0000_axi_reader_ARPROT,
    axi_reader_RDATA => class_obj_0000_axi_reader_RDATA,
    axi_reader_RRESP => class_obj_0000_axi_reader_RRESP,
    axi_reader_RLAST => class_obj_0000_axi_reader_RLAST,
    axi_reader_RVALID => class_obj_0000_axi_reader_RVALID,
    axi_reader_RREADY => class_obj_0000_axi_reader_RREADY,
    axi_writer_AWADDR => class_obj_0000_axi_writer_AWADDR,
    axi_writer_AWLEN => class_obj_0000_axi_writer_AWLEN,
    axi_writer_AWVALID => class_obj_0000_axi_writer_AWVALID,
    axi_writer_AWSIZE => class_obj_0000_axi_writer_AWSIZE,
    axi_writer_AWBURST => class_obj_0000_axi_writer_AWBURST,
    axi_writer_AWCACHE => class_obj_0000_axi_writer_AWCACHE,
    axi_writer_AWPROT => class_obj_0000_axi_writer_AWPROT,
    axi_writer_AWREADY => class_obj_0000_axi_writer_AWREADY,
    axi_writer_WDATA => class_obj_0000_axi_writer_WDATA,
    axi_writer_WLAST => class_obj_0000_axi_writer_WLAST,
    axi_writer_WVALID => class_obj_0000_axi_writer_WVALID,
    axi_writer_WREADY => class_obj_0000_axi_writer_WREADY,
    axi_writer_WSTRB => class_obj_0000_axi_writer_WSTRB,
    axi_writer_BRESP => class_obj_0000_axi_writer_BRESP,
    axi_writer_BVALID => class_obj_0000_axi_writer_BVALID,
    axi_writer_BREADY => class_obj_0000_axi_writer_BREADY
  );


end RTL;
