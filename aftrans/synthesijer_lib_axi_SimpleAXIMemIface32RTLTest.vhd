library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity synthesijer_lib_axi_SimpleAXIMemIface32RTLTest is
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
    write_data_addr : in signed(32-1 downto 0);
    write_data_data : in signed(32-1 downto 0);
    read_data_addr : in signed(32-1 downto 0);
    write_data_busy : out std_logic;
    write_data_req : in std_logic;
    read_data_return : out signed(32-1 downto 0);
    read_data_busy : out std_logic;
    read_data_req : in std_logic;
    test_busy : out std_logic;
    test_req : in std_logic
  );
end synthesijer_lib_axi_SimpleAXIMemIface32RTLTest;

architecture RTL of synthesijer_lib_axi_SimpleAXIMemIface32RTLTest is

  attribute mark_debug : string;
  attribute keep : string;

  component simple_axi_memiface_32
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
  end component simple_axi_memiface_32;

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
  signal write_data_addr_sig : signed(32-1 downto 0);
  signal write_data_data_sig : signed(32-1 downto 0);
  signal read_data_addr_sig : signed(32-1 downto 0);
  signal write_data_busy_sig : std_logic := '1';
  signal write_data_req_sig : std_logic;
  signal read_data_return_sig : signed(32-1 downto 0) := (others => '0');
  signal read_data_busy_sig : std_logic := '1';
  signal read_data_req_sig : std_logic;
  signal test_busy_sig : std_logic := '1';
  signal test_req_sig : std_logic;

  signal class_obj_0000_clk : std_logic;
  signal class_obj_0000_reset : std_logic;
  signal class_obj_0000_data_address : std_logic_vector(32-1 downto 0) := (others => '0');
  signal class_obj_0000_data_din : std_logic_vector(32-1 downto 0) := (others => '0');
  signal class_obj_0000_data_dout : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_read_result : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_data_we : std_logic := '0';
  signal class_obj_0000_data_oe : std_logic := '0';
  signal class_obj_0000_data_length : std_logic_vector(32-1 downto 0);
  signal class_obj_0000_busy : std_logic;
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
  signal write_data_addr_0002 : signed(32-1 downto 0) := (others => '0');
  signal write_data_addr_local : signed(32-1 downto 0) := (others => '0');
  signal write_data_data_0003 : signed(32-1 downto 0) := (others => '0');
  signal write_data_data_local : signed(32-1 downto 0) := (others => '0');
  signal field_access_00004 : std_logic := '0';
  signal binary_expr_00005 : std_logic := '0';
  signal field_access_00006 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00007 : signed(32-1 downto 0) := (others => '0');
  signal read_data_addr_0008 : signed(32-1 downto 0) := (others => '0');
  signal read_data_addr_local : signed(32-1 downto 0) := (others => '0');
  signal field_access_00009 : std_logic := '0';
  signal binary_expr_00010 : std_logic := '0';
  signal read_data_v_0011 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00012 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00013 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00014 : std_logic := '0';
  signal binary_expr_00015 : std_logic := '0';
  signal field_access_00016 : signed(32-1 downto 0) := (others => '0');
  signal test_offset_0017 : signed(32-1 downto 0) := X"3f000000";
  signal test_j_0018 : signed(32-1 downto 0) := X"00000078";
  signal binary_expr_00019 : std_logic := '0';
  signal unary_expr_00020 : signed(32-1 downto 0) := (others => '0');
  signal test_y_0021 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00022 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00023 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00024 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00025 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00026 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00027 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00028 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00029 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00030 : signed(32-1 downto 0) := (others => '0');
  signal test_i_0031 : signed(32-1 downto 0) := X"00000000";
  signal binary_expr_00032 : std_logic := '0';
  signal unary_expr_00033 : signed(32-1 downto 0) := (others => '0');
  signal test_pt_0034 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00035 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00036 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00037 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00039 : signed(32-1 downto 0) := (others => '0');
  signal write_data_req_flag : std_logic;
  signal write_data_req_local : std_logic := '0';
  signal tmp_0001 : std_logic;
  signal read_data_req_flag : std_logic;
  signal read_data_req_local : std_logic := '0';
  signal tmp_0002 : std_logic;
  signal test_req_flag : std_logic;
  signal test_req_local : std_logic := '0';
  signal tmp_0003 : std_logic;
  type Type_write_data_method is (
    write_data_method_IDLE,
    write_data_method_S_0000,
    write_data_method_S_0001,
    write_data_method_S_0002,
    write_data_method_S_0003,
    write_data_method_S_0004,
    write_data_method_S_0005,
    write_data_method_S_0006,
    write_data_method_S_0007,
    write_data_method_S_0008,
    write_data_method_S_0010  
  );
  signal write_data_method : Type_write_data_method := write_data_method_IDLE;
  signal write_data_method_delay : signed(32-1 downto 0) := (others => '0');
  signal write_data_req_flag_d : std_logic := '0';
  signal write_data_req_flag_edge : std_logic;
  signal tmp_0004 : std_logic;
  signal tmp_0005 : std_logic;
  signal tmp_0006 : std_logic;
  signal tmp_0007 : std_logic;
  signal tmp_0008 : std_logic;
  signal tmp_0009 : std_logic;
  signal tmp_0010 : std_logic;
  signal tmp_0011 : std_logic;
  signal tmp_0012 : std_logic;
  signal tmp_0013 : std_logic;
  signal tmp_0014 : signed(32-1 downto 0);
  signal tmp_0015 : signed(32-1 downto 0);
  signal tmp_0016 : std_logic;
  type Type_read_data_method is (
    read_data_method_IDLE,
    read_data_method_S_0000,
    read_data_method_S_0001,
    read_data_method_S_0002,
    read_data_method_S_0003,
    read_data_method_S_0004,
    read_data_method_S_0005,
    read_data_method_S_0006,
    read_data_method_S_0007,
    read_data_method_S_0008,
    read_data_method_S_0009,
    read_data_method_S_0010,
    read_data_method_S_0011,
    read_data_method_S_0012,
    read_data_method_S_0013,
    read_data_method_S_0014,
    read_data_method_S_0015,
    read_data_method_S_0016,
    read_data_method_S_0017  
  );
  signal read_data_method : Type_read_data_method := read_data_method_IDLE;
  signal read_data_method_delay : signed(32-1 downto 0) := (others => '0');
  signal read_data_req_flag_d : std_logic := '0';
  signal read_data_req_flag_edge : std_logic;
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
  signal tmp_0028 : std_logic;
  signal tmp_0029 : signed(32-1 downto 0);
  signal tmp_0030 : std_logic;
  signal tmp_0031 : std_logic;
  type Type_test_method is (
    test_method_IDLE,
    test_method_S_0000,
    test_method_S_0001,
    test_method_S_0002,
    test_method_S_0004,
    test_method_S_0005,
    test_method_S_0006,
    test_method_S_0007,
    test_method_S_0008,
    test_method_S_0009,
    test_method_S_0010,
    test_method_S_0012,
    test_method_S_0014,
    test_method_S_0016,
    test_method_S_0017,
    test_method_S_0018,
    test_method_S_0019,
    test_method_S_0020,
    test_method_S_0022,
    test_method_S_0023,
    test_method_S_0024,
    test_method_S_0025,
    test_method_S_0026,
    test_method_S_0027,
    test_method_S_0028,
    test_method_S_0029,
    test_method_S_0030,
    test_method_S_0031,
    test_method_S_0032,
    test_method_S_0033,
    test_method_S_0034,
    test_method_S_0035,
    test_method_S_0036,
    test_method_S_0033_body,
    test_method_S_0033_wait  
  );
  signal test_method : Type_test_method := test_method_IDLE;
  signal test_method_delay : signed(32-1 downto 0) := (others => '0');
  signal test_req_flag_d : std_logic := '0';
  signal test_req_flag_edge : std_logic;
  signal tmp_0032 : std_logic;
  signal tmp_0033 : std_logic;
  signal tmp_0034 : std_logic;
  signal tmp_0035 : std_logic;
  signal tmp_0036 : std_logic;
  signal tmp_0037 : std_logic;
  signal tmp_0038 : std_logic;
  signal tmp_0039 : std_logic;
  signal write_data_call_flag_0033 : std_logic;
  signal tmp_0040 : std_logic;
  signal tmp_0041 : std_logic;
  signal tmp_0042 : std_logic;
  signal tmp_0043 : std_logic;
  signal tmp_0044 : std_logic;
  signal tmp_0045 : std_logic;
  signal tmp_0046 : std_logic;
  signal tmp_0047 : std_logic;
  signal tmp_0048 : std_logic;
  signal tmp_0049 : signed(32-1 downto 0);
  signal tmp_0050 : signed(32-1 downto 0);
  signal tmp_0051 : signed(32-1 downto 0);
  signal tmp_0052 : signed(32-1 downto 0);
  signal tmp_0053 : signed(32-1 downto 0);
  signal tmp_0054 : signed(32-1 downto 0);
  signal tmp_0055 : signed(32-1 downto 0);
  signal tmp_0056 : signed(32-1 downto 0);
  signal tmp_0057 : signed(32-1 downto 0);
  signal tmp_0058 : signed(32-1 downto 0);
  signal tmp_0059 : std_logic;
  signal tmp_0060 : signed(32-1 downto 0);
  signal tmp_0061 : signed(32-1 downto 0);
  signal tmp_0062 : signed(32-1 downto 0);
  signal tmp_0063 : signed(32-1 downto 0);
  signal tmp_0064 : signed(32-1 downto 0);

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

  write_data_addr_sig <= write_data_addr;
  write_data_data_sig <= write_data_data;
  read_data_addr_sig <= read_data_addr;
  write_data_busy <= write_data_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_data_busy_sig <= '1';
      else
        if write_data_method = write_data_method_S_0000 then
          write_data_busy_sig <= '0';
        elsif write_data_method = write_data_method_S_0001 then
          write_data_busy_sig <= tmp_0007;
        end if;
      end if;
    end if;
  end process;

  write_data_req_sig <= write_data_req;
  read_data_return <= read_data_return_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_data_return_sig <= (others => '0');
      else
        if read_data_method = read_data_method_S_0016 then
          read_data_return_sig <= field_access_00016;
        end if;
      end if;
    end if;
  end process;

  read_data_busy <= read_data_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_data_busy_sig <= '1';
      else
        if read_data_method = read_data_method_S_0000 then
          read_data_busy_sig <= '0';
        elsif read_data_method = read_data_method_S_0001 then
          read_data_busy_sig <= tmp_0020;
        end if;
      end if;
    end if;
  end process;

  read_data_req_sig <= read_data_req;
  test_busy <= test_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        test_busy_sig <= '1';
      else
        if test_method = test_method_S_0000 then
          test_busy_sig <= '0';
        elsif test_method = test_method_S_0001 then
          test_busy_sig <= tmp_0035;
        end if;
      end if;
    end if;
  end process;

  test_req_sig <= test_req;

  -- expressions
  tmp_0001 <= write_data_req_local or write_data_req_sig;
  tmp_0002 <= read_data_req_local or read_data_req_sig;
  tmp_0003 <= test_req_local or test_req_sig;
  tmp_0004 <= not write_data_req_flag_d;
  tmp_0005 <= write_data_req_flag and tmp_0004;
  tmp_0006 <= write_data_req_flag or write_data_req_flag_d;
  tmp_0007 <= write_data_req_flag or write_data_req_flag_d;
  tmp_0008 <= '1' when binary_expr_00005 = '1' else '0';
  tmp_0009 <= '1' when binary_expr_00005 = '0' else '0';
  tmp_0010 <= '1' when write_data_method /= write_data_method_S_0000 else '0';
  tmp_0011 <= '1' when write_data_method /= write_data_method_S_0001 else '0';
  tmp_0012 <= tmp_0011 and write_data_req_flag_edge;
  tmp_0013 <= tmp_0010 and tmp_0012;
  tmp_0014 <= write_data_addr_sig when write_data_req_sig = '1' else write_data_addr_local;
  tmp_0015 <= write_data_data_sig when write_data_req_sig = '1' else write_data_data_local;
  tmp_0016 <= '1' when field_access_00004 = '1' else '0';
  tmp_0017 <= not read_data_req_flag_d;
  tmp_0018 <= read_data_req_flag and tmp_0017;
  tmp_0019 <= read_data_req_flag or read_data_req_flag_d;
  tmp_0020 <= read_data_req_flag or read_data_req_flag_d;
  tmp_0021 <= '1' when binary_expr_00010 = '1' else '0';
  tmp_0022 <= '1' when binary_expr_00010 = '0' else '0';
  tmp_0023 <= '1' when binary_expr_00015 = '1' else '0';
  tmp_0024 <= '1' when binary_expr_00015 = '0' else '0';
  tmp_0025 <= '1' when read_data_method /= read_data_method_S_0000 else '0';
  tmp_0026 <= '1' when read_data_method /= read_data_method_S_0001 else '0';
  tmp_0027 <= tmp_0026 and read_data_req_flag_edge;
  tmp_0028 <= tmp_0025 and tmp_0027;
  tmp_0029 <= read_data_addr_sig when read_data_req_sig = '1' else read_data_addr_local;
  tmp_0030 <= '1' when field_access_00009 = '1' else '0';
  tmp_0031 <= '1' when field_access_00014 = '1' else '0';
  tmp_0032 <= not test_req_flag_d;
  tmp_0033 <= test_req_flag and tmp_0032;
  tmp_0034 <= test_req_flag or test_req_flag_d;
  tmp_0035 <= test_req_flag or test_req_flag_d;
  tmp_0036 <= '1' when binary_expr_00019 = '1' else '0';
  tmp_0037 <= '1' when binary_expr_00019 = '0' else '0';
  tmp_0038 <= '1' when binary_expr_00032 = '1' else '0';
  tmp_0039 <= '1' when binary_expr_00032 = '0' else '0';
  tmp_0040 <= '1' when write_data_busy_sig = '0' else '0';
  tmp_0041 <= '1' when write_data_req_local = '0' else '0';
  tmp_0042 <= tmp_0040 and tmp_0041;
  tmp_0043 <= '1' when tmp_0042 = '1' else '0';
  tmp_0044 <= '1' when test_method /= test_method_S_0000 else '0';
  tmp_0045 <= '1' when test_method /= test_method_S_0001 else '0';
  tmp_0046 <= tmp_0045 and test_req_flag_edge;
  tmp_0047 <= tmp_0044 and tmp_0046;
  tmp_0048 <= '1' when test_j_0018 < X"00000096" else '0';
  tmp_0049 <= test_j_0018 + X"00000001";
  tmp_0050 <= test_j_0018(21 downto 0) & (10-1 downto 0 => '0');
  tmp_0051 <= test_j_0018(22 downto 0) & (9-1 downto 0 => '0');
  tmp_0052 <= test_j_0018(23 downto 0) & (8-1 downto 0 => '0');
  tmp_0053 <= test_j_0018(24 downto 0) & (7-1 downto 0 => '0');
  tmp_0054 <= binary_expr_00022 + binary_expr_00023;
  tmp_0055 <= binary_expr_00024 + binary_expr_00025;
  tmp_0056 <= binary_expr_00026 + binary_expr_00027;
  tmp_0057 <= test_y_0021(30 downto 0) & (1-1 downto 0 => '0');
  tmp_0058 <= binary_expr_00029 + test_y_0021;
  tmp_0059 <= '1' when test_i_0031 < X"0000001e" else '0';
  tmp_0060 <= test_i_0031 + X"00000001";
  tmp_0061 <= test_i_0031(29 downto 0) & (2-1 downto 0 => '0');
  tmp_0062 <= X"00000078" + binary_expr_00035;
  tmp_0063 <= binary_expr_00036 + test_y_0021;
  tmp_0064 <= test_pt_0034 + test_offset_0017;

  -- sequencers
  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_data_method <= write_data_method_IDLE;
        write_data_method_delay <= (others => '0');
      else
        case (write_data_method) is
          when write_data_method_IDLE => 
            write_data_method <= write_data_method_S_0000;
          when write_data_method_S_0000 => 
            write_data_method <= write_data_method_S_0001;
          when write_data_method_S_0001 => 
            if tmp_0006 = '1' then
              write_data_method <= write_data_method_S_0002;
            end if;
          when write_data_method_S_0002 => 
            write_data_method <= write_data_method_S_0003;
          when write_data_method_S_0003 => 
            write_data_method <= write_data_method_S_0004;
          when write_data_method_S_0004 => 
            if tmp_0008 = '1' then
              write_data_method <= write_data_method_S_0006;
            elsif tmp_0009 = '1' then
              write_data_method <= write_data_method_S_0005;
            end if;
          when write_data_method_S_0005 => 
            write_data_method <= write_data_method_S_0007;
          when write_data_method_S_0006 => 
            write_data_method <= write_data_method_S_0002;
          when write_data_method_S_0007 => 
            write_data_method <= write_data_method_S_0008;
          when write_data_method_S_0008 => 
            write_data_method <= write_data_method_S_0010;
          when write_data_method_S_0010 => 
            write_data_method <= write_data_method_S_0000;
          when others => null;
        end case;
        write_data_req_flag_d <= write_data_req_flag;
        if (tmp_0010 and tmp_0012) = '1' then
          write_data_method <= write_data_method_S_0001;
        end if;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_data_method <= read_data_method_IDLE;
        read_data_method_delay <= (others => '0');
      else
        case (read_data_method) is
          when read_data_method_IDLE => 
            read_data_method <= read_data_method_S_0000;
          when read_data_method_S_0000 => 
            read_data_method <= read_data_method_S_0001;
          when read_data_method_S_0001 => 
            if tmp_0019 = '1' then
              read_data_method <= read_data_method_S_0002;
            end if;
          when read_data_method_S_0002 => 
            read_data_method <= read_data_method_S_0003;
          when read_data_method_S_0003 => 
            read_data_method <= read_data_method_S_0004;
          when read_data_method_S_0004 => 
            if tmp_0021 = '1' then
              read_data_method <= read_data_method_S_0006;
            elsif tmp_0022 = '1' then
              read_data_method <= read_data_method_S_0005;
            end if;
          when read_data_method_S_0005 => 
            read_data_method <= read_data_method_S_0007;
          when read_data_method_S_0006 => 
            read_data_method <= read_data_method_S_0002;
          when read_data_method_S_0007 => 
            read_data_method <= read_data_method_S_0008;
          when read_data_method_S_0008 => 
            if read_data_method_delay >= 2 then
              read_data_method_delay <= (others => '0');
              read_data_method <= read_data_method_S_0009;
            else
              read_data_method_delay <= read_data_method_delay + 1;
            end if;
          when read_data_method_S_0009 => 
            read_data_method <= read_data_method_S_0010;
          when read_data_method_S_0010 => 
            read_data_method <= read_data_method_S_0011;
          when read_data_method_S_0011 => 
            read_data_method <= read_data_method_S_0012;
          when read_data_method_S_0012 => 
            if tmp_0023 = '1' then
              read_data_method <= read_data_method_S_0014;
            elsif tmp_0024 = '1' then
              read_data_method <= read_data_method_S_0013;
            end if;
          when read_data_method_S_0013 => 
            read_data_method <= read_data_method_S_0015;
          when read_data_method_S_0014 => 
            read_data_method <= read_data_method_S_0010;
          when read_data_method_S_0015 => 
            read_data_method <= read_data_method_S_0016;
          when read_data_method_S_0016 => 
            read_data_method <= read_data_method_S_0000;
          when read_data_method_S_0017 => 
            read_data_method <= read_data_method_S_0000;
          when others => null;
        end case;
        read_data_req_flag_d <= read_data_req_flag;
        if (tmp_0025 and tmp_0027) = '1' then
          read_data_method <= read_data_method_S_0001;
        end if;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        test_method <= test_method_IDLE;
        test_method_delay <= (others => '0');
      else
        case (test_method) is
          when test_method_IDLE => 
            test_method <= test_method_S_0000;
          when test_method_S_0000 => 
            test_method <= test_method_S_0001;
          when test_method_S_0001 => 
            if tmp_0034 = '1' then
              test_method <= test_method_S_0002;
            end if;
          when test_method_S_0002 => 
            test_method <= test_method_S_0004;
          when test_method_S_0004 => 
            test_method <= test_method_S_0005;
          when test_method_S_0005 => 
            if tmp_0036 = '1' then
              test_method <= test_method_S_0010;
            elsif tmp_0037 = '1' then
              test_method <= test_method_S_0006;
            end if;
          when test_method_S_0006 => 
            test_method <= test_method_S_0036;
          when test_method_S_0007 => 
            test_method <= test_method_S_0008;
          when test_method_S_0008 => 
            test_method <= test_method_S_0009;
          when test_method_S_0009 => 
            test_method <= test_method_S_0004;
          when test_method_S_0010 => 
            test_method <= test_method_S_0012;
          when test_method_S_0012 => 
            test_method <= test_method_S_0014;
          when test_method_S_0014 => 
            test_method <= test_method_S_0016;
          when test_method_S_0016 => 
            test_method <= test_method_S_0017;
          when test_method_S_0017 => 
            test_method <= test_method_S_0018;
          when test_method_S_0018 => 
            test_method <= test_method_S_0019;
          when test_method_S_0019 => 
            test_method <= test_method_S_0020;
          when test_method_S_0020 => 
            test_method <= test_method_S_0022;
          when test_method_S_0022 => 
            test_method <= test_method_S_0023;
          when test_method_S_0023 => 
            if tmp_0038 = '1' then
              test_method <= test_method_S_0028;
            elsif tmp_0039 = '1' then
              test_method <= test_method_S_0024;
            end if;
          when test_method_S_0024 => 
            test_method <= test_method_S_0035;
          when test_method_S_0025 => 
            test_method <= test_method_S_0026;
          when test_method_S_0026 => 
            test_method <= test_method_S_0027;
          when test_method_S_0027 => 
            test_method <= test_method_S_0022;
          when test_method_S_0028 => 
            test_method <= test_method_S_0029;
          when test_method_S_0029 => 
            test_method <= test_method_S_0030;
          when test_method_S_0030 => 
            test_method <= test_method_S_0031;
          when test_method_S_0031 => 
            test_method <= test_method_S_0032;
          when test_method_S_0032 => 
            test_method <= test_method_S_0033;
          when test_method_S_0033 => 
            test_method <= test_method_S_0033_body;
          when test_method_S_0034 => 
            test_method <= test_method_S_0025;
          when test_method_S_0035 => 
            test_method <= test_method_S_0007;
          when test_method_S_0036 => 
            test_method <= test_method_S_0000;
          when test_method_S_0033_body => 
            test_method <= test_method_S_0033_wait;
          when test_method_S_0033_wait => 
            if write_data_call_flag_0033 = '1' then
              test_method <= test_method_S_0034;
            end if;
          when others => null;
        end case;
        test_req_flag_d <= test_req_flag;
        if (tmp_0044 and tmp_0046) = '1' then
          test_method <= test_method_S_0001;
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
        if write_data_method = write_data_method_S_0008 then
          class_obj_0000_data_address <= std_logic_vector(write_data_addr_0002);
        elsif read_data_method = read_data_method_S_0008 and read_data_method_delay = 0 then
          class_obj_0000_data_address <= std_logic_vector(read_data_addr_0008);
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
        if write_data_method = write_data_method_S_0008 then
          class_obj_0000_data_din <= std_logic_vector(write_data_data_0003);
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
        if write_data_method = write_data_method_S_0008 then
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
        if read_data_method = read_data_method_S_0008 and read_data_method_delay = 0 then
          class_obj_0000_data_oe <= '1';
        else
          class_obj_0000_data_oe <= '0';
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
        write_data_addr_0002 <= (others => '0');
      else
        if write_data_method = write_data_method_S_0001 then
          write_data_addr_0002 <= tmp_0014;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_data_addr_local <= (others => '0');
      else
        if test_method = test_method_S_0033_body and test_method_delay = 0 then
          write_data_addr_local <= binary_expr_00039;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_data_data_0003 <= (others => '0');
      else
        if write_data_method = write_data_method_S_0001 then
          write_data_data_0003 <= tmp_0015;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_data_data_local <= (others => '0');
      else
        if test_method = test_method_S_0033_body and test_method_delay = 0 then
          write_data_data_local <= X"ffffffff";
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
        if write_data_method = write_data_method_S_0002 then
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
        if write_data_method = write_data_method_S_0003 then
          binary_expr_00005 <= tmp_0016;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_data_addr_0008 <= (others => '0');
      else
        if read_data_method = read_data_method_S_0001 then
          read_data_addr_0008 <= tmp_0029;
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
        if read_data_method = read_data_method_S_0002 then
          field_access_00009 <= class_obj_0000_busy;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00010 <= '0';
      else
        if read_data_method = read_data_method_S_0003 then
          binary_expr_00010 <= tmp_0030;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        read_data_v_0011 <= (others => '0');
      else
        if read_data_method = read_data_method_S_0009 then
          read_data_v_0011 <= array_access_00013;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00013 <= (others => '0');
      else
        if read_data_method = read_data_method_S_0008 and read_data_method_delay = 2 then
          array_access_00013 <= signed(class_obj_0000_data_dout);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00014 <= '0';
      else
        if read_data_method = read_data_method_S_0010 then
          field_access_00014 <= class_obj_0000_busy;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00015 <= '0';
      else
        if read_data_method = read_data_method_S_0011 then
          binary_expr_00015 <= tmp_0031;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        field_access_00016 <= (others => '0');
      else
        if read_data_method = read_data_method_S_0015 then
          field_access_00016 <= signed(class_obj_0000_read_result);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        test_offset_0017 <= X"3f000000";
      else
        if test_method = test_method_S_0002 then
          test_offset_0017 <= X"3f000000";
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        test_j_0018 <= X"00000078";
      else
        if test_method = test_method_S_0002 then
          test_j_0018 <= X"00000078";
        elsif test_method = test_method_S_0008 then
          test_j_0018 <= unary_expr_00020;
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
        if test_method = test_method_S_0004 then
          binary_expr_00019 <= tmp_0048;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        unary_expr_00020 <= (others => '0');
      else
        if test_method = test_method_S_0007 then
          unary_expr_00020 <= tmp_0049;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        test_y_0021 <= (others => '0');
      else
        if test_method = test_method_S_0017 then
          test_y_0021 <= binary_expr_00028;
        elsif test_method = test_method_S_0020 then
          test_y_0021 <= binary_expr_00030;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00022 <= (others => '0');
      else
        if test_method = test_method_S_0010 then
          binary_expr_00022 <= tmp_0050;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00023 <= (others => '0');
      else
        if test_method = test_method_S_0010 then
          binary_expr_00023 <= tmp_0051;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00024 <= (others => '0');
      else
        if test_method = test_method_S_0012 then
          binary_expr_00024 <= tmp_0054;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00025 <= (others => '0');
      else
        if test_method = test_method_S_0010 then
          binary_expr_00025 <= tmp_0052;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00026 <= (others => '0');
      else
        if test_method = test_method_S_0014 then
          binary_expr_00026 <= tmp_0055;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00027 <= (others => '0');
      else
        if test_method = test_method_S_0010 then
          binary_expr_00027 <= tmp_0053;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00028 <= (others => '0');
      else
        if test_method = test_method_S_0016 then
          binary_expr_00028 <= tmp_0056;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00029 <= (others => '0');
      else
        if test_method = test_method_S_0018 then
          binary_expr_00029 <= tmp_0057;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00030 <= (others => '0');
      else
        if test_method = test_method_S_0019 then
          binary_expr_00030 <= tmp_0058;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        test_i_0031 <= X"00000000";
      else
        if test_method = test_method_S_0010 then
          test_i_0031 <= X"00000000";
        elsif test_method = test_method_S_0026 then
          test_i_0031 <= unary_expr_00033;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00032 <= '0';
      else
        if test_method = test_method_S_0022 then
          binary_expr_00032 <= tmp_0059;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        unary_expr_00033 <= (others => '0');
      else
        if test_method = test_method_S_0025 then
          unary_expr_00033 <= tmp_0060;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        test_pt_0034 <= (others => '0');
      else
        if test_method = test_method_S_0031 then
          test_pt_0034 <= binary_expr_00037;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00035 <= (others => '0');
      else
        if test_method = test_method_S_0028 then
          binary_expr_00035 <= tmp_0061;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00036 <= (others => '0');
      else
        if test_method = test_method_S_0029 then
          binary_expr_00036 <= tmp_0062;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00037 <= (others => '0');
      else
        if test_method = test_method_S_0030 then
          binary_expr_00037 <= tmp_0063;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00039 <= (others => '0');
      else
        if test_method = test_method_S_0032 then
          binary_expr_00039 <= tmp_0064;
        end if;
      end if;
    end if;
  end process;

  write_data_req_flag <= tmp_0001;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        write_data_req_local <= '0';
      else
        if test_method = test_method_S_0033_body then
          write_data_req_local <= '1';
        else
          write_data_req_local <= '0';
        end if;
      end if;
    end if;
  end process;

  read_data_req_flag <= tmp_0002;

  test_req_flag <= tmp_0003;

  write_data_req_flag_edge <= tmp_0005;

  read_data_req_flag_edge <= tmp_0018;

  test_req_flag_edge <= tmp_0033;

  write_data_call_flag_0033 <= tmp_0043;


  inst_class_obj_0000 : simple_axi_memiface_32
  port map(
    clk => class_obj_0000_clk,
    reset => class_obj_0000_reset,
    data_address => class_obj_0000_data_address,
    data_din => class_obj_0000_data_din,
    data_dout => class_obj_0000_data_dout,
    read_result => class_obj_0000_read_result,
    data_we => class_obj_0000_data_we,
    data_oe => class_obj_0000_data_oe,
    data_length => class_obj_0000_data_length,
    busy => class_obj_0000_busy,
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
