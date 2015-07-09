library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AXIHP_GRAY is
  port (
    clk : in std_logic;
    reset : in std_logic;
    class_s0_0000_axi_reader_ARADDR_exp : in std_logic_vector(32-1 downto 0);
    class_s0_0000_axi_reader_ARVALID_exp : in std_logic;
    class_s0_0000_axi_reader_ARREADY_exp : out std_logic;
    class_s0_0000_axi_reader_RDATA_exp : out std_logic_vector(32-1 downto 0);
    class_s0_0000_axi_reader_RRESP_exp : out std_logic_vector(2-1 downto 0);
    class_s0_0000_axi_reader_RVALID_exp : out std_logic;
    class_s0_0000_axi_reader_RREADY_exp : in std_logic;
    class_s0_0000_axi_writer_AWADDR_exp : in std_logic_vector(32-1 downto 0);
    class_s0_0000_axi_writer_AWVALID_exp : in std_logic;
    class_s0_0000_axi_writer_AWREADY_exp : out std_logic;
    class_s0_0000_axi_writer_WDATA_exp : in std_logic_vector(32-1 downto 0);
    class_s0_0000_axi_writer_WVALID_exp : in std_logic;
    class_s0_0000_axi_writer_WREADY_exp : out std_logic;
    class_s0_0000_axi_writer_WSTRB_exp : in std_logic_vector(4-1 downto 0);
    class_s0_0000_axi_writer_BRESP_exp : out std_logic_vector(2-1 downto 0);
    class_s0_0000_axi_writer_BVALID_exp : out std_logic;
    class_s0_0000_axi_writer_BREADY_exp : in std_logic;
    class_m0_0002_class_obj_0000_forbid_exp_exp : in std_logic;
    class_m0_0002_class_obj_0000_axi_reader_ARADDR_exp_exp : out std_logic_vector(32-1 downto 0);
    class_m0_0002_class_obj_0000_axi_reader_ARLEN_exp_exp : out std_logic_vector(8-1 downto 0);
    class_m0_0002_class_obj_0000_axi_reader_ARVALID_exp_exp : out std_logic;
    class_m0_0002_class_obj_0000_axi_reader_ARREADY_exp_exp : in std_logic;
    class_m0_0002_class_obj_0000_axi_reader_ARSIZE_exp_exp : out std_logic_vector(3-1 downto 0);
    class_m0_0002_class_obj_0000_axi_reader_ARBURST_exp_exp : out std_logic_vector(2-1 downto 0);
    class_m0_0002_class_obj_0000_axi_reader_ARCACHE_exp_exp : out std_logic_vector(4-1 downto 0);
    class_m0_0002_class_obj_0000_axi_reader_ARPROT_exp_exp : out std_logic_vector(3-1 downto 0);
    class_m0_0002_class_obj_0000_axi_reader_RDATA_exp_exp : in std_logic_vector(32-1 downto 0);
    class_m0_0002_class_obj_0000_axi_reader_RRESP_exp_exp : in std_logic_vector(2-1 downto 0);
    class_m0_0002_class_obj_0000_axi_reader_RLAST_exp_exp : in std_logic;
    class_m0_0002_class_obj_0000_axi_reader_RVALID_exp_exp : in std_logic;
    class_m0_0002_class_obj_0000_axi_reader_RREADY_exp_exp : out std_logic;
    class_m0_0002_class_obj_0000_axi_writer_AWADDR_exp_exp : out std_logic_vector(32-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_AWLEN_exp_exp : out std_logic_vector(8-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_AWVALID_exp_exp : out std_logic;
    class_m0_0002_class_obj_0000_axi_writer_AWSIZE_exp_exp : out std_logic_vector(3-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_AWBURST_exp_exp : out std_logic_vector(2-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_AWCACHE_exp_exp : out std_logic_vector(4-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_AWPROT_exp_exp : out std_logic_vector(3-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_AWREADY_exp_exp : in std_logic;
    class_m0_0002_class_obj_0000_axi_writer_WDATA_exp_exp : out std_logic_vector(32-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_WLAST_exp_exp : out std_logic;
    class_m0_0002_class_obj_0000_axi_writer_WVALID_exp_exp : out std_logic;
    class_m0_0002_class_obj_0000_axi_writer_WREADY_exp_exp : in std_logic;
    class_m0_0002_class_obj_0000_axi_writer_WSTRB_exp_exp : out std_logic_vector(4-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_BRESP_exp_exp : in std_logic_vector(2-1 downto 0);
    class_m0_0002_class_obj_0000_axi_writer_BVALID_exp_exp : in std_logic;
    class_m0_0002_class_obj_0000_axi_writer_BREADY_exp_exp : out std_logic
  );
end AXIHP_GRAY;

architecture RTL of AXIHP_GRAY is

  attribute mark_debug : string;
  attribute keep : string;

  component axi_lite_slave_32
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
  end component axi_lite_slave_32;
  component synthesijer_lib_axi_SimpleAXIMemIface32RTLTest
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
  end component synthesijer_lib_axi_SimpleAXIMemIface32RTLTest;

  signal clk_sig : std_logic;
  signal reset_sig : std_logic;
  signal class_s0_0000_axi_reader_ARADDR_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_axi_reader_ARVALID_exp_sig : std_logic;
  signal class_s0_0000_axi_reader_ARREADY_exp_sig : std_logic;
  signal class_s0_0000_axi_reader_RDATA_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_axi_reader_RRESP_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_s0_0000_axi_reader_RVALID_exp_sig : std_logic;
  signal class_s0_0000_axi_reader_RREADY_exp_sig : std_logic;
  signal class_s0_0000_axi_writer_AWADDR_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_axi_writer_AWVALID_exp_sig : std_logic;
  signal class_s0_0000_axi_writer_AWREADY_exp_sig : std_logic;
  signal class_s0_0000_axi_writer_WDATA_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_axi_writer_WVALID_exp_sig : std_logic;
  signal class_s0_0000_axi_writer_WREADY_exp_sig : std_logic;
  signal class_s0_0000_axi_writer_WSTRB_exp_sig : std_logic_vector(4-1 downto 0);
  signal class_s0_0000_axi_writer_BRESP_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_s0_0000_axi_writer_BVALID_exp_sig : std_logic;
  signal class_s0_0000_axi_writer_BREADY_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_forbid_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_ARADDR_exp_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARLEN_exp_exp_sig : std_logic_vector(8-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARVALID_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_ARREADY_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_ARSIZE_exp_exp_sig : std_logic_vector(3-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARBURST_exp_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARCACHE_exp_exp_sig : std_logic_vector(4-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARPROT_exp_exp_sig : std_logic_vector(3-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_RDATA_exp_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_RRESP_exp_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_RLAST_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_RVALID_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_RREADY_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_AWADDR_exp_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWLEN_exp_exp_sig : std_logic_vector(8-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWVALID_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_AWSIZE_exp_exp_sig : std_logic_vector(3-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWBURST_exp_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWCACHE_exp_exp_sig : std_logic_vector(4-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWPROT_exp_exp_sig : std_logic_vector(3-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWREADY_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_WDATA_exp_exp_sig : std_logic_vector(32-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_WLAST_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_WVALID_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_WREADY_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_WSTRB_exp_exp_sig : std_logic_vector(4-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_BRESP_exp_exp_sig : std_logic_vector(2-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_BVALID_exp_exp_sig : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_BREADY_exp_exp_sig : std_logic;

  signal class_s0_0000_clk : std_logic;
  signal class_s0_0000_reset : std_logic;
  signal class_s0_0000_data_length : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_data_address : std_logic_vector(32-1 downto 0) := (others => '0');
  signal class_s0_0000_data_din : std_logic_vector(32-1 downto 0) := (others => '0');
  signal class_s0_0000_data_dout : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_data_we : std_logic := '0';
  signal class_s0_0000_data_oe : std_logic := '0';
  signal class_s0_0000_axi_reader_ARADDR : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_axi_reader_ARVALID : std_logic;
  signal class_s0_0000_axi_reader_ARREADY : std_logic;
  signal class_s0_0000_axi_reader_RDATA : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_axi_reader_RRESP : std_logic_vector(2-1 downto 0);
  signal class_s0_0000_axi_reader_RVALID : std_logic;
  signal class_s0_0000_axi_reader_RREADY : std_logic;
  signal class_s0_0000_axi_writer_AWADDR : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_axi_writer_AWVALID : std_logic;
  signal class_s0_0000_axi_writer_AWREADY : std_logic;
  signal class_s0_0000_axi_writer_WDATA : std_logic_vector(32-1 downto 0);
  signal class_s0_0000_axi_writer_WVALID : std_logic;
  signal class_s0_0000_axi_writer_WREADY : std_logic;
  signal class_s0_0000_axi_writer_WSTRB : std_logic_vector(4-1 downto 0);
  signal class_s0_0000_axi_writer_BRESP : std_logic_vector(2-1 downto 0);
  signal class_s0_0000_axi_writer_BVALID : std_logic;
  signal class_s0_0000_axi_writer_BREADY : std_logic;
  signal class_m0_0002_clk : std_logic;
  signal class_m0_0002_reset : std_logic;
  signal class_m0_0002_class_obj_0000_forbid_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_ARADDR_exp : std_logic_vector(32-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARLEN_exp : std_logic_vector(8-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARVALID_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_ARREADY_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_ARSIZE_exp : std_logic_vector(3-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARBURST_exp : std_logic_vector(2-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARCACHE_exp : std_logic_vector(4-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_ARPROT_exp : std_logic_vector(3-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_RDATA_exp : std_logic_vector(32-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_RRESP_exp : std_logic_vector(2-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_reader_RLAST_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_RVALID_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_reader_RREADY_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_AWADDR_exp : std_logic_vector(32-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWLEN_exp : std_logic_vector(8-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWVALID_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_AWSIZE_exp : std_logic_vector(3-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWBURST_exp : std_logic_vector(2-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWCACHE_exp : std_logic_vector(4-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWPROT_exp : std_logic_vector(3-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_AWREADY_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_WDATA_exp : std_logic_vector(32-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_WLAST_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_WVALID_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_WREADY_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_WSTRB_exp : std_logic_vector(4-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_BRESP_exp : std_logic_vector(2-1 downto 0);
  signal class_m0_0002_class_obj_0000_axi_writer_BVALID_exp : std_logic;
  signal class_m0_0002_class_obj_0000_axi_writer_BREADY_exp : std_logic;
  signal class_m0_0002_write_data_addr : signed(32-1 downto 0) := (others => '0');
  signal class_m0_0002_write_data_data : signed(32-1 downto 0) := (others => '0');
  signal class_m0_0002_read_data_addr : signed(32-1 downto 0) := (others => '0');
  signal class_m0_0002_write_data_busy : std_logic;
  signal class_m0_0002_write_data_req : std_logic := '0';
  signal class_m0_0002_read_data_return : signed(32-1 downto 0);
  signal class_m0_0002_read_data_busy : std_logic;
  signal class_m0_0002_read_data_req : std_logic := '0';
  signal class_m0_0002_test_busy : std_logic;
  signal class_m0_0002_test_req : std_logic := '0';
  signal run_src_addr_0004 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00005 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00006 : signed(32-1 downto 0) := (others => '0');
  signal run_dest_addr_0007 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00008 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00009 : signed(32-1 downto 0) := (others => '0');
  signal run_size_0010 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00011 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00012 : signed(32-1 downto 0) := (others => '0');
  signal run_i_0013 : signed(32-1 downto 0) := X"00000000";
  signal binary_expr_00014 : std_logic := '0';
  signal unary_expr_00015 : signed(32-1 downto 0) := (others => '0');
  signal run_rgb_0016 : signed(32-1 downto 0) := (others => '0');
  signal method_result_00017 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00018 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00019 : signed(32-1 downto 0) := (others => '0');
  signal run_r_0020 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00021 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00022 : signed(32-1 downto 0) := (others => '0');
  signal run_g_0023 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00024 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00025 : signed(32-1 downto 0) := (others => '0');
  signal run_b_0026 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00027 : signed(32-1 downto 0) := (others => '0');
  signal run_gray_0028 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00029 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00030 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00031 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00032 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00034 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00035 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00036 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00037 : signed(32-1 downto 0) := (others => '0');
  signal field_access_00038 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00039 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00040 : std_logic := '0';
  signal field_access_00042 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00043 : signed(32-1 downto 0) := (others => '0');
  signal run_busy : std_logic := '0';
  signal run_req_flag : std_logic;
  signal run_req_local : std_logic := '0';
  type Type_run_method is (
    run_method_IDLE,
    run_method_S_0000,
    run_method_S_0001,
    run_method_S_0002,
    run_method_S_0003,
    run_method_S_0004,
    run_method_S_0005,
    run_method_S_0006,
    run_method_S_0007,
    run_method_S_0008,
    run_method_S_0009,
    run_method_S_0010,
    run_method_S_0012,
    run_method_S_0013,
    run_method_S_0014,
    run_method_S_0015,
    run_method_S_0016,
    run_method_S_0017,
    run_method_S_0018,
    run_method_S_0019,
    run_method_S_0020,
    run_method_S_0021,
    run_method_S_0022,
    run_method_S_0023,
    run_method_S_0024,
    run_method_S_0030,
    run_method_S_0031,
    run_method_S_0032,
    run_method_S_0033,
    run_method_S_0034,
    run_method_S_0037,
    run_method_S_0038,
    run_method_S_0039,
    run_method_S_0020_body,
    run_method_S_0020_wait,
    run_method_S_0037_body,
    run_method_S_0037_wait  
  );
  signal run_method : Type_run_method := run_method_IDLE;
  signal run_method_delay : signed(32-1 downto 0) := (others => '0');
  signal run_req_flag_d : std_logic := '0';
  signal run_req_flag_edge : std_logic;
  signal tmp_0001 : std_logic;
  signal tmp_0002 : std_logic;
  signal tmp_0003 : std_logic;
  signal tmp_0004 : std_logic;
  signal tmp_0005 : std_logic;
  signal tmp_0006 : std_logic;
  signal read_data_ext_call_flag_0020 : std_logic;
  signal tmp_0007 : std_logic;
  signal tmp_0008 : std_logic;
  signal tmp_0009 : std_logic;
  signal tmp_0010 : std_logic;
  signal write_data_ext_call_flag_0037 : std_logic;
  signal tmp_0011 : std_logic;
  signal tmp_0012 : std_logic;
  signal tmp_0013 : std_logic;
  signal tmp_0014 : std_logic;
  signal tmp_0015 : std_logic;
  signal tmp_0016 : std_logic;
  signal tmp_0017 : std_logic;
  signal tmp_0018 : std_logic;
  signal tmp_0019 : std_logic;
  signal tmp_0020 : signed(32-1 downto 0);
  signal tmp_0021 : signed(32-1 downto 0);
  signal tmp_0022 : signed(32-1 downto 0);
  signal tmp_0023 : signed(32-1 downto 0);
  signal tmp_0024 : signed(32-1 downto 0);
  signal tmp_0025 : signed(32-1 downto 0);
  signal tmp_0026 : signed(32-1 downto 0);
  signal tmp_0027 : signed(32-1 downto 0);
  signal tmp_0028 : signed(32-1 downto 0);
  signal tmp_0029 : signed(32-1 downto 0);
  signal tmp_0030 : signed(32-1 downto 0);
  signal tmp_0031 : signed(32-1 downto 0);
  signal tmp_0032 : signed(32-1 downto 0);
  signal tmp_0033 : signed(32-1 downto 0);
  type Type_main_method is (
    main_method_IDLE,
    main_method_S_0000,
    main_method_S_0001,
    main_method_S_0002,
    main_method_S_0003,
    main_method_S_0005,
    main_method_S_0006,
    main_method_S_0007,
    main_method_S_0008,
    main_method_S_0009,
    main_method_S_0010,
    main_method_S_0011,
    main_method_S_0012,
    main_method_S_0013,
    main_method_S_0015,
    main_method_S_0011_body,
    main_method_S_0011_wait  
  );
  signal main_method : Type_main_method := main_method_IDLE;
  signal main_method_delay : signed(32-1 downto 0) := (others => '0');
  signal tmp_0034 : std_logic;
  signal tmp_0035 : std_logic;
  signal run_call_flag_0011 : std_logic;
  signal tmp_0036 : std_logic;
  signal tmp_0037 : std_logic;
  signal tmp_0038 : std_logic;
  signal tmp_0039 : std_logic;
  signal tmp_0040 : std_logic;

begin

  clk_sig <= clk;
  reset_sig <= reset;
  class_s0_0000_axi_reader_ARADDR_exp_sig <= class_s0_0000_axi_reader_ARADDR_exp;
  class_s0_0000_axi_reader_ARVALID_exp_sig <= class_s0_0000_axi_reader_ARVALID_exp;
  class_s0_0000_axi_reader_ARREADY_exp <= class_s0_0000_axi_reader_ARREADY_exp_sig;
  class_s0_0000_axi_reader_ARREADY_exp_sig <= class_s0_0000_axi_reader_ARREADY;

  class_s0_0000_axi_reader_RDATA_exp <= class_s0_0000_axi_reader_RDATA_exp_sig;
  class_s0_0000_axi_reader_RDATA_exp_sig <= class_s0_0000_axi_reader_RDATA;

  class_s0_0000_axi_reader_RRESP_exp <= class_s0_0000_axi_reader_RRESP_exp_sig;
  class_s0_0000_axi_reader_RRESP_exp_sig <= class_s0_0000_axi_reader_RRESP;

  class_s0_0000_axi_reader_RVALID_exp <= class_s0_0000_axi_reader_RVALID_exp_sig;
  class_s0_0000_axi_reader_RVALID_exp_sig <= class_s0_0000_axi_reader_RVALID;

  class_s0_0000_axi_reader_RREADY_exp_sig <= class_s0_0000_axi_reader_RREADY_exp;
  class_s0_0000_axi_writer_AWADDR_exp_sig <= class_s0_0000_axi_writer_AWADDR_exp;
  class_s0_0000_axi_writer_AWVALID_exp_sig <= class_s0_0000_axi_writer_AWVALID_exp;
  class_s0_0000_axi_writer_AWREADY_exp <= class_s0_0000_axi_writer_AWREADY_exp_sig;
  class_s0_0000_axi_writer_AWREADY_exp_sig <= class_s0_0000_axi_writer_AWREADY;

  class_s0_0000_axi_writer_WDATA_exp_sig <= class_s0_0000_axi_writer_WDATA_exp;
  class_s0_0000_axi_writer_WVALID_exp_sig <= class_s0_0000_axi_writer_WVALID_exp;
  class_s0_0000_axi_writer_WREADY_exp <= class_s0_0000_axi_writer_WREADY_exp_sig;
  class_s0_0000_axi_writer_WREADY_exp_sig <= class_s0_0000_axi_writer_WREADY;

  class_s0_0000_axi_writer_WSTRB_exp_sig <= class_s0_0000_axi_writer_WSTRB_exp;
  class_s0_0000_axi_writer_BRESP_exp <= class_s0_0000_axi_writer_BRESP_exp_sig;
  class_s0_0000_axi_writer_BRESP_exp_sig <= class_s0_0000_axi_writer_BRESP;

  class_s0_0000_axi_writer_BVALID_exp <= class_s0_0000_axi_writer_BVALID_exp_sig;
  class_s0_0000_axi_writer_BVALID_exp_sig <= class_s0_0000_axi_writer_BVALID;

  class_s0_0000_axi_writer_BREADY_exp_sig <= class_s0_0000_axi_writer_BREADY_exp;
  class_m0_0002_class_obj_0000_forbid_exp_exp_sig <= class_m0_0002_class_obj_0000_forbid_exp_exp;
  class_m0_0002_class_obj_0000_axi_reader_ARADDR_exp_exp <= class_m0_0002_class_obj_0000_axi_reader_ARADDR_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_reader_ARADDR_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_ARADDR_exp;

  class_m0_0002_class_obj_0000_axi_reader_ARLEN_exp_exp <= class_m0_0002_class_obj_0000_axi_reader_ARLEN_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_reader_ARLEN_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_ARLEN_exp;

  class_m0_0002_class_obj_0000_axi_reader_ARVALID_exp_exp <= class_m0_0002_class_obj_0000_axi_reader_ARVALID_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_reader_ARVALID_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_ARVALID_exp;

  class_m0_0002_class_obj_0000_axi_reader_ARREADY_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_ARREADY_exp_exp;
  class_m0_0002_class_obj_0000_axi_reader_ARSIZE_exp_exp <= class_m0_0002_class_obj_0000_axi_reader_ARSIZE_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_reader_ARSIZE_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_ARSIZE_exp;

  class_m0_0002_class_obj_0000_axi_reader_ARBURST_exp_exp <= class_m0_0002_class_obj_0000_axi_reader_ARBURST_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_reader_ARBURST_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_ARBURST_exp;

  class_m0_0002_class_obj_0000_axi_reader_ARCACHE_exp_exp <= class_m0_0002_class_obj_0000_axi_reader_ARCACHE_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_reader_ARCACHE_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_ARCACHE_exp;

  class_m0_0002_class_obj_0000_axi_reader_ARPROT_exp_exp <= class_m0_0002_class_obj_0000_axi_reader_ARPROT_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_reader_ARPROT_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_ARPROT_exp;

  class_m0_0002_class_obj_0000_axi_reader_RDATA_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_RDATA_exp_exp;
  class_m0_0002_class_obj_0000_axi_reader_RRESP_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_RRESP_exp_exp;
  class_m0_0002_class_obj_0000_axi_reader_RLAST_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_RLAST_exp_exp;
  class_m0_0002_class_obj_0000_axi_reader_RVALID_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_RVALID_exp_exp;
  class_m0_0002_class_obj_0000_axi_reader_RREADY_exp_exp <= class_m0_0002_class_obj_0000_axi_reader_RREADY_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_reader_RREADY_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_reader_RREADY_exp;

  class_m0_0002_class_obj_0000_axi_writer_AWADDR_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_AWADDR_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_AWADDR_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_AWADDR_exp;

  class_m0_0002_class_obj_0000_axi_writer_AWLEN_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_AWLEN_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_AWLEN_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_AWLEN_exp;

  class_m0_0002_class_obj_0000_axi_writer_AWVALID_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_AWVALID_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_AWVALID_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_AWVALID_exp;

  class_m0_0002_class_obj_0000_axi_writer_AWSIZE_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_AWSIZE_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_AWSIZE_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_AWSIZE_exp;

  class_m0_0002_class_obj_0000_axi_writer_AWBURST_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_AWBURST_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_AWBURST_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_AWBURST_exp;

  class_m0_0002_class_obj_0000_axi_writer_AWCACHE_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_AWCACHE_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_AWCACHE_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_AWCACHE_exp;

  class_m0_0002_class_obj_0000_axi_writer_AWPROT_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_AWPROT_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_AWPROT_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_AWPROT_exp;

  class_m0_0002_class_obj_0000_axi_writer_AWREADY_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_AWREADY_exp_exp;
  class_m0_0002_class_obj_0000_axi_writer_WDATA_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_WDATA_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_WDATA_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_WDATA_exp;

  class_m0_0002_class_obj_0000_axi_writer_WLAST_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_WLAST_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_WLAST_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_WLAST_exp;

  class_m0_0002_class_obj_0000_axi_writer_WVALID_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_WVALID_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_WVALID_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_WVALID_exp;

  class_m0_0002_class_obj_0000_axi_writer_WREADY_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_WREADY_exp_exp;
  class_m0_0002_class_obj_0000_axi_writer_WSTRB_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_WSTRB_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_WSTRB_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_WSTRB_exp;

  class_m0_0002_class_obj_0000_axi_writer_BRESP_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_BRESP_exp_exp;
  class_m0_0002_class_obj_0000_axi_writer_BVALID_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_BVALID_exp_exp;
  class_m0_0002_class_obj_0000_axi_writer_BREADY_exp_exp <= class_m0_0002_class_obj_0000_axi_writer_BREADY_exp_exp_sig;
  class_m0_0002_class_obj_0000_axi_writer_BREADY_exp_exp_sig <= class_m0_0002_class_obj_0000_axi_writer_BREADY_exp;


  -- expressions
  tmp_0001 <= not run_req_flag_d;
  tmp_0002 <= run_req_flag and tmp_0001;
  tmp_0003 <= run_req_flag or run_req_flag_d;
  tmp_0004 <= run_req_flag or run_req_flag_d;
  tmp_0005 <= '1' when binary_expr_00014 = '1' else '0';
  tmp_0006 <= '1' when binary_expr_00014 = '0' else '0';
  tmp_0007 <= '1' when class_m0_0002_read_data_busy = '0' else '0';
  tmp_0008 <= '1' when class_m0_0002_read_data_req = '0' else '0';
  tmp_0009 <= tmp_0007 and tmp_0008;
  tmp_0010 <= '1' when tmp_0009 = '1' else '0';
  tmp_0011 <= '1' when class_m0_0002_write_data_busy = '0' else '0';
  tmp_0012 <= '1' when class_m0_0002_write_data_req = '0' else '0';
  tmp_0013 <= tmp_0011 and tmp_0012;
  tmp_0014 <= '1' when tmp_0013 = '1' else '0';
  tmp_0015 <= '1' when run_method /= run_method_S_0000 else '0';
  tmp_0016 <= '1' when run_method /= run_method_S_0001 else '0';
  tmp_0017 <= tmp_0016 and run_req_flag_edge;
  tmp_0018 <= tmp_0015 and tmp_0017;
  tmp_0019 <= '1' when run_i_0013 < run_size_0010 else '0';
  tmp_0020 <= run_i_0013 + X"00000001";
  tmp_0021 <= run_i_0013(29 downto 0) & (2-1 downto 0 => '0');
  tmp_0022 <= run_src_addr_0004 + binary_expr_00018;
  tmp_0023 <= run_i_0013(29 downto 0) & (2-1 downto 0 => '0');
  tmp_0024 <= (32-1 downto 16 => run_rgb_0016(31)) & run_rgb_0016(31 downto 16);
  tmp_0025 <= (32-1 downto 24 => run_rgb_0016(31)) & run_rgb_0016(31 downto 8);
  tmp_0026 <= run_rgb_0016 and X"000000ff";
  tmp_0027 <= run_dest_addr_0007 + binary_expr_00034;
  tmp_0028 <= binary_expr_00021 and X"000000ff";
  tmp_0029 <= binary_expr_00024 and X"000000ff";
  tmp_0030 <= run_r_0020 + run_g_0023;
  tmp_0031 <= binary_expr_00029 + run_g_0023;
  tmp_0032 <= binary_expr_00030 + run_b_0026;
  tmp_0033 <= (32-1 downto 30 => binary_expr_00031(31)) & binary_expr_00031(31 downto 2);
  tmp_0034 <= '1' when binary_expr_00040 = '1' else '0';
  tmp_0035 <= '1' when binary_expr_00040 = '0' else '0';
  tmp_0036 <= '1' when run_busy = '0' else '0';
  tmp_0037 <= '1' when run_req_local = '0' else '0';
  tmp_0038 <= tmp_0036 and tmp_0037;
  tmp_0039 <= '1' when tmp_0038 = '1' else '0';
  tmp_0040 <= '1' when array_access_00039 = X"00000000" else '0';

  -- sequencers
  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_method <= run_method_IDLE;
        run_method_delay <= (others => '0');
      else
        case (run_method) is
          when run_method_IDLE => 
            run_method <= run_method_S_0000;
          when run_method_S_0000 => 
            run_method <= run_method_S_0001;
          when run_method_S_0001 => 
            if tmp_0003 = '1' then
              run_method <= run_method_S_0002;
            end if;
          when run_method_S_0002 => 
            run_method <= run_method_S_0003;
          when run_method_S_0003 => 
            if run_method_delay >= 2 then
              run_method_delay <= (others => '0');
              run_method <= run_method_S_0004;
            else
              run_method_delay <= run_method_delay + 1;
            end if;
          when run_method_S_0004 => 
            run_method <= run_method_S_0005;
          when run_method_S_0005 => 
            run_method <= run_method_S_0006;
          when run_method_S_0006 => 
            if run_method_delay >= 2 then
              run_method_delay <= (others => '0');
              run_method <= run_method_S_0007;
            else
              run_method_delay <= run_method_delay + 1;
            end if;
          when run_method_S_0007 => 
            run_method <= run_method_S_0008;
          when run_method_S_0008 => 
            run_method <= run_method_S_0009;
          when run_method_S_0009 => 
            if run_method_delay >= 2 then
              run_method_delay <= (others => '0');
              run_method <= run_method_S_0010;
            else
              run_method_delay <= run_method_delay + 1;
            end if;
          when run_method_S_0010 => 
            run_method <= run_method_S_0012;
          when run_method_S_0012 => 
            run_method <= run_method_S_0013;
          when run_method_S_0013 => 
            if tmp_0005 = '1' then
              run_method <= run_method_S_0018;
            elsif tmp_0006 = '1' then
              run_method <= run_method_S_0014;
            end if;
          when run_method_S_0014 => 
            run_method <= run_method_S_0039;
          when run_method_S_0015 => 
            run_method <= run_method_S_0016;
          when run_method_S_0016 => 
            run_method <= run_method_S_0017;
          when run_method_S_0017 => 
            run_method <= run_method_S_0012;
          when run_method_S_0018 => 
            run_method <= run_method_S_0019;
          when run_method_S_0019 => 
            run_method <= run_method_S_0020;
          when run_method_S_0020 => 
            run_method <= run_method_S_0020_body;
          when run_method_S_0021 => 
            run_method <= run_method_S_0022;
          when run_method_S_0022 => 
            run_method <= run_method_S_0023;
          when run_method_S_0023 => 
            run_method <= run_method_S_0024;
          when run_method_S_0024 => 
            run_method <= run_method_S_0030;
          when run_method_S_0030 => 
            run_method <= run_method_S_0031;
          when run_method_S_0031 => 
            run_method <= run_method_S_0032;
          when run_method_S_0032 => 
            run_method <= run_method_S_0033;
          when run_method_S_0033 => 
            run_method <= run_method_S_0034;
          when run_method_S_0034 => 
            run_method <= run_method_S_0037;
          when run_method_S_0037 => 
            run_method <= run_method_S_0037_body;
          when run_method_S_0038 => 
            run_method <= run_method_S_0015;
          when run_method_S_0039 => 
            run_method <= run_method_S_0000;
          when run_method_S_0020_body => 
            run_method <= run_method_S_0020_wait;
          when run_method_S_0020_wait => 
            if read_data_ext_call_flag_0020 = '1' then
              run_method <= run_method_S_0021;
            end if;
          when run_method_S_0037_body => 
            run_method <= run_method_S_0037_wait;
          when run_method_S_0037_wait => 
            if write_data_ext_call_flag_0037 = '1' then
              run_method <= run_method_S_0038;
            end if;
          when others => null;
        end case;
        run_req_flag_d <= run_req_flag;
        if (tmp_0015 and tmp_0017) = '1' then
          run_method <= run_method_S_0001;
        end if;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        main_method <= main_method_IDLE;
        main_method_delay <= (others => '0');
      else
        case (main_method) is
          when main_method_IDLE => 
            main_method <= main_method_S_0000;
          when main_method_S_0000 => 
            main_method <= main_method_S_0001;
          when main_method_S_0001 => 
            main_method <= main_method_S_0002;
          when main_method_S_0002 => 
            main_method <= main_method_S_0003;
          when main_method_S_0003 => 
            main_method <= main_method_S_0005;
          when main_method_S_0005 => 
            main_method <= main_method_S_0006;
          when main_method_S_0006 => 
            if main_method_delay >= 2 then
              main_method_delay <= (others => '0');
              main_method <= main_method_S_0007;
            else
              main_method_delay <= main_method_delay + 1;
            end if;
          when main_method_S_0007 => 
            main_method <= main_method_S_0008;
          when main_method_S_0008 => 
            if tmp_0034 = '1' then
              main_method <= main_method_S_0010;
            elsif tmp_0035 = '1' then
              main_method <= main_method_S_0009;
            end if;
          when main_method_S_0009 => 
            main_method <= main_method_S_0011;
          when main_method_S_0010 => 
            main_method <= main_method_S_0005;
          when main_method_S_0011 => 
            main_method <= main_method_S_0011_body;
          when main_method_S_0012 => 
            main_method <= main_method_S_0013;
          when main_method_S_0013 => 
            main_method <= main_method_S_0015;
          when main_method_S_0015 => 
            main_method <= main_method_S_0000;
          when main_method_S_0011_body => 
            main_method <= main_method_S_0011_wait;
          when main_method_S_0011_wait => 
            if run_call_flag_0011 = '1' then
              main_method <= main_method_S_0012;
            end if;
          when others => null;
        end case;
      end if;
    end if;
  end process;


  class_s0_0000_clk <= clk_sig;

  class_s0_0000_reset <= reset_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_s0_0000_data_address <= (others => '0');
      else
        if run_method = run_method_S_0003 and run_method_delay = 0 then
          class_s0_0000_data_address <= X"00000001";
        elsif run_method = run_method_S_0006 and run_method_delay = 0 then
          class_s0_0000_data_address <= X"00000002";
        elsif run_method = run_method_S_0009 and run_method_delay = 0 then
          class_s0_0000_data_address <= X"00000003";
        elsif main_method = main_method_S_0003 then
          class_s0_0000_data_address <= X"00000000";
        elsif main_method = main_method_S_0006 and main_method_delay = 0 then
          class_s0_0000_data_address <= X"00000000";
        elsif main_method = main_method_S_0013 then
          class_s0_0000_data_address <= X"00000000";
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_s0_0000_data_din <= (others => '0');
      else
        if main_method = main_method_S_0003 then
          class_s0_0000_data_din <= X"00000000";
        elsif main_method = main_method_S_0013 then
          class_s0_0000_data_din <= X"00000000";
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_s0_0000_data_we <= '0';
      else
        if main_method = main_method_S_0003 then
          class_s0_0000_data_we <= '1';
        elsif main_method = main_method_S_0013 then
          class_s0_0000_data_we <= '1';
        else
          class_s0_0000_data_we <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_s0_0000_data_oe <= '0';
      else
        if run_method = run_method_S_0003 and run_method_delay = 0 then
          class_s0_0000_data_oe <= '1';
        elsif run_method = run_method_S_0006 and run_method_delay = 0 then
          class_s0_0000_data_oe <= '1';
        elsif run_method = run_method_S_0009 and run_method_delay = 0 then
          class_s0_0000_data_oe <= '1';
        elsif main_method = main_method_S_0006 and main_method_delay = 0 then
          class_s0_0000_data_oe <= '1';
        else
          class_s0_0000_data_oe <= '0';
        end if;
      end if;
    end if;
  end process;

  class_s0_0000_axi_reader_ARADDR <= class_s0_0000_axi_reader_ARADDR_exp_sig;

  class_s0_0000_axi_reader_ARVALID <= class_s0_0000_axi_reader_ARVALID_exp_sig;

  class_s0_0000_axi_reader_RREADY <= class_s0_0000_axi_reader_RREADY_exp_sig;

  class_s0_0000_axi_writer_AWADDR <= class_s0_0000_axi_writer_AWADDR_exp_sig;

  class_s0_0000_axi_writer_AWVALID <= class_s0_0000_axi_writer_AWVALID_exp_sig;

  class_s0_0000_axi_writer_WDATA <= class_s0_0000_axi_writer_WDATA_exp_sig;

  class_s0_0000_axi_writer_WVALID <= class_s0_0000_axi_writer_WVALID_exp_sig;

  class_s0_0000_axi_writer_WSTRB <= class_s0_0000_axi_writer_WSTRB_exp_sig;

  class_s0_0000_axi_writer_BREADY <= class_s0_0000_axi_writer_BREADY_exp_sig;

  class_m0_0002_clk <= clk_sig;

  class_m0_0002_reset <= reset_sig;

  class_m0_0002_class_obj_0000_forbid_exp <= class_m0_0002_class_obj_0000_forbid_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_reader_ARREADY_exp <= class_m0_0002_class_obj_0000_axi_reader_ARREADY_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_reader_RDATA_exp <= class_m0_0002_class_obj_0000_axi_reader_RDATA_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_reader_RRESP_exp <= class_m0_0002_class_obj_0000_axi_reader_RRESP_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_reader_RLAST_exp <= class_m0_0002_class_obj_0000_axi_reader_RLAST_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_reader_RVALID_exp <= class_m0_0002_class_obj_0000_axi_reader_RVALID_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_writer_AWREADY_exp <= class_m0_0002_class_obj_0000_axi_writer_AWREADY_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_writer_WREADY_exp <= class_m0_0002_class_obj_0000_axi_writer_WREADY_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_writer_BRESP_exp <= class_m0_0002_class_obj_0000_axi_writer_BRESP_exp_exp_sig;

  class_m0_0002_class_obj_0000_axi_writer_BVALID_exp <= class_m0_0002_class_obj_0000_axi_writer_BVALID_exp_exp_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_m0_0002_write_data_addr <= (others => '0');
      else
        if run_method = run_method_S_0037_body and run_method_delay = 0 then
          class_m0_0002_write_data_addr <= binary_expr_00035;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_m0_0002_write_data_data <= (others => '0');
      else
        if run_method = run_method_S_0037_body and run_method_delay = 0 then
          class_m0_0002_write_data_data <= run_gray_0028;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_m0_0002_read_data_addr <= (others => '0');
      else
        if run_method = run_method_S_0020_body and run_method_delay = 0 then
          class_m0_0002_read_data_addr <= binary_expr_00019;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_m0_0002_write_data_req <= '0';
      else
        if run_method = run_method_S_0037_body then
          class_m0_0002_write_data_req <= '1';
        else
          class_m0_0002_write_data_req <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_m0_0002_read_data_req <= '0';
      else
        if run_method = run_method_S_0020_body then
          class_m0_0002_read_data_req <= '1';
        else
          class_m0_0002_read_data_req <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_src_addr_0004 <= (others => '0');
      else
        if run_method = run_method_S_0004 then
          run_src_addr_0004 <= array_access_00006;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00006 <= (others => '0');
      else
        if run_method = run_method_S_0003 and run_method_delay = 2 then
          array_access_00006 <= signed(class_s0_0000_data_dout);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_dest_addr_0007 <= (others => '0');
      else
        if run_method = run_method_S_0007 then
          run_dest_addr_0007 <= array_access_00009;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00009 <= (others => '0');
      else
        if run_method = run_method_S_0006 and run_method_delay = 2 then
          array_access_00009 <= signed(class_s0_0000_data_dout);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_size_0010 <= (others => '0');
      else
        if run_method = run_method_S_0010 then
          run_size_0010 <= array_access_00012;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00012 <= (others => '0');
      else
        if run_method = run_method_S_0009 and run_method_delay = 2 then
          array_access_00012 <= signed(class_s0_0000_data_dout);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_i_0013 <= X"00000000";
      else
        if run_method = run_method_S_0010 then
          run_i_0013 <= X"00000000";
        elsif run_method = run_method_S_0016 then
          run_i_0013 <= unary_expr_00015;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00014 <= '0';
      else
        if run_method = run_method_S_0012 then
          binary_expr_00014 <= tmp_0019;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        unary_expr_00015 <= (others => '0');
      else
        if run_method = run_method_S_0015 then
          unary_expr_00015 <= tmp_0020;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_rgb_0016 <= (others => '0');
      else
        if run_method = run_method_S_0021 then
          run_rgb_0016 <= method_result_00017;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        method_result_00017 <= (others => '0');
      else
        if run_method = run_method_S_0020_wait then
          method_result_00017 <= class_m0_0002_read_data_return;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00018 <= (others => '0');
      else
        if run_method = run_method_S_0018 then
          binary_expr_00018 <= tmp_0021;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00019 <= (others => '0');
      else
        if run_method = run_method_S_0019 then
          binary_expr_00019 <= tmp_0022;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_r_0020 <= (others => '0');
      else
        if run_method = run_method_S_0024 then
          run_r_0020 <= binary_expr_00022;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00021 <= (others => '0');
      else
        if run_method = run_method_S_0022 then
          binary_expr_00021 <= tmp_0024;
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
        if run_method = run_method_S_0023 then
          binary_expr_00022 <= tmp_0028;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_g_0023 <= (others => '0');
      else
        if run_method = run_method_S_0024 then
          run_g_0023 <= binary_expr_00025;
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
        if run_method = run_method_S_0022 then
          binary_expr_00024 <= tmp_0025;
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
        if run_method = run_method_S_0023 then
          binary_expr_00025 <= tmp_0029;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_b_0026 <= (others => '0');
      else
        if run_method = run_method_S_0023 then
          run_b_0026 <= binary_expr_00027;
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
        if run_method = run_method_S_0022 then
          binary_expr_00027 <= tmp_0026;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_gray_0028 <= (others => '0');
      else
        if run_method = run_method_S_0034 then
          run_gray_0028 <= binary_expr_00032;
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
        if run_method = run_method_S_0030 then
          binary_expr_00029 <= tmp_0030;
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
        if run_method = run_method_S_0031 then
          binary_expr_00030 <= tmp_0031;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00031 <= (others => '0');
      else
        if run_method = run_method_S_0032 then
          binary_expr_00031 <= tmp_0032;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00032 <= (others => '0');
      else
        if run_method = run_method_S_0033 then
          binary_expr_00032 <= tmp_0033;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00034 <= (others => '0');
      else
        if run_method = run_method_S_0021 then
          binary_expr_00034 <= tmp_0023;
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
        if run_method = run_method_S_0022 then
          binary_expr_00035 <= tmp_0027;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00039 <= (others => '0');
      else
        if main_method = main_method_S_0006 and main_method_delay = 2 then
          array_access_00039 <= signed(class_s0_0000_data_dout);
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00040 <= '0';
      else
        if main_method = main_method_S_0007 then
          binary_expr_00040 <= tmp_0040;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_busy <= '0';
      else
        if run_method = run_method_S_0000 then
          run_busy <= '0';
        elsif run_method = run_method_S_0001 then
          run_busy <= tmp_0004;
        end if;
      end if;
    end if;
  end process;

  run_req_flag <= run_req_local;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        run_req_local <= '0';
      else
        if main_method = main_method_S_0011_body then
          run_req_local <= '1';
        else
          run_req_local <= '0';
        end if;
      end if;
    end if;
  end process;

  run_req_flag_edge <= tmp_0002;

  read_data_ext_call_flag_0020 <= tmp_0010;

  write_data_ext_call_flag_0037 <= tmp_0014;

  run_call_flag_0011 <= tmp_0039;


  inst_class_s0_0000 : axi_lite_slave_32
  port map(
    clk => class_s0_0000_clk,
    reset => class_s0_0000_reset,
    data_length => class_s0_0000_data_length,
    data_address => class_s0_0000_data_address,
    data_din => class_s0_0000_data_din,
    data_dout => class_s0_0000_data_dout,
    data_we => class_s0_0000_data_we,
    data_oe => class_s0_0000_data_oe,
    axi_reader_ARADDR => class_s0_0000_axi_reader_ARADDR,
    axi_reader_ARVALID => class_s0_0000_axi_reader_ARVALID,
    axi_reader_ARREADY => class_s0_0000_axi_reader_ARREADY,
    axi_reader_RDATA => class_s0_0000_axi_reader_RDATA,
    axi_reader_RRESP => class_s0_0000_axi_reader_RRESP,
    axi_reader_RVALID => class_s0_0000_axi_reader_RVALID,
    axi_reader_RREADY => class_s0_0000_axi_reader_RREADY,
    axi_writer_AWADDR => class_s0_0000_axi_writer_AWADDR,
    axi_writer_AWVALID => class_s0_0000_axi_writer_AWVALID,
    axi_writer_AWREADY => class_s0_0000_axi_writer_AWREADY,
    axi_writer_WDATA => class_s0_0000_axi_writer_WDATA,
    axi_writer_WVALID => class_s0_0000_axi_writer_WVALID,
    axi_writer_WREADY => class_s0_0000_axi_writer_WREADY,
    axi_writer_WSTRB => class_s0_0000_axi_writer_WSTRB,
    axi_writer_BRESP => class_s0_0000_axi_writer_BRESP,
    axi_writer_BVALID => class_s0_0000_axi_writer_BVALID,
    axi_writer_BREADY => class_s0_0000_axi_writer_BREADY
  );

  inst_class_m0_0002 : synthesijer_lib_axi_SimpleAXIMemIface32RTLTest
  port map(
    clk => class_m0_0002_clk,
    reset => class_m0_0002_reset,
    class_obj_0000_forbid_exp => class_m0_0002_class_obj_0000_forbid_exp,
    class_obj_0000_axi_reader_ARADDR_exp => class_m0_0002_class_obj_0000_axi_reader_ARADDR_exp,
    class_obj_0000_axi_reader_ARLEN_exp => class_m0_0002_class_obj_0000_axi_reader_ARLEN_exp,
    class_obj_0000_axi_reader_ARVALID_exp => class_m0_0002_class_obj_0000_axi_reader_ARVALID_exp,
    class_obj_0000_axi_reader_ARREADY_exp => class_m0_0002_class_obj_0000_axi_reader_ARREADY_exp,
    class_obj_0000_axi_reader_ARSIZE_exp => class_m0_0002_class_obj_0000_axi_reader_ARSIZE_exp,
    class_obj_0000_axi_reader_ARBURST_exp => class_m0_0002_class_obj_0000_axi_reader_ARBURST_exp,
    class_obj_0000_axi_reader_ARCACHE_exp => class_m0_0002_class_obj_0000_axi_reader_ARCACHE_exp,
    class_obj_0000_axi_reader_ARPROT_exp => class_m0_0002_class_obj_0000_axi_reader_ARPROT_exp,
    class_obj_0000_axi_reader_RDATA_exp => class_m0_0002_class_obj_0000_axi_reader_RDATA_exp,
    class_obj_0000_axi_reader_RRESP_exp => class_m0_0002_class_obj_0000_axi_reader_RRESP_exp,
    class_obj_0000_axi_reader_RLAST_exp => class_m0_0002_class_obj_0000_axi_reader_RLAST_exp,
    class_obj_0000_axi_reader_RVALID_exp => class_m0_0002_class_obj_0000_axi_reader_RVALID_exp,
    class_obj_0000_axi_reader_RREADY_exp => class_m0_0002_class_obj_0000_axi_reader_RREADY_exp,
    class_obj_0000_axi_writer_AWADDR_exp => class_m0_0002_class_obj_0000_axi_writer_AWADDR_exp,
    class_obj_0000_axi_writer_AWLEN_exp => class_m0_0002_class_obj_0000_axi_writer_AWLEN_exp,
    class_obj_0000_axi_writer_AWVALID_exp => class_m0_0002_class_obj_0000_axi_writer_AWVALID_exp,
    class_obj_0000_axi_writer_AWSIZE_exp => class_m0_0002_class_obj_0000_axi_writer_AWSIZE_exp,
    class_obj_0000_axi_writer_AWBURST_exp => class_m0_0002_class_obj_0000_axi_writer_AWBURST_exp,
    class_obj_0000_axi_writer_AWCACHE_exp => class_m0_0002_class_obj_0000_axi_writer_AWCACHE_exp,
    class_obj_0000_axi_writer_AWPROT_exp => class_m0_0002_class_obj_0000_axi_writer_AWPROT_exp,
    class_obj_0000_axi_writer_AWREADY_exp => class_m0_0002_class_obj_0000_axi_writer_AWREADY_exp,
    class_obj_0000_axi_writer_WDATA_exp => class_m0_0002_class_obj_0000_axi_writer_WDATA_exp,
    class_obj_0000_axi_writer_WLAST_exp => class_m0_0002_class_obj_0000_axi_writer_WLAST_exp,
    class_obj_0000_axi_writer_WVALID_exp => class_m0_0002_class_obj_0000_axi_writer_WVALID_exp,
    class_obj_0000_axi_writer_WREADY_exp => class_m0_0002_class_obj_0000_axi_writer_WREADY_exp,
    class_obj_0000_axi_writer_WSTRB_exp => class_m0_0002_class_obj_0000_axi_writer_WSTRB_exp,
    class_obj_0000_axi_writer_BRESP_exp => class_m0_0002_class_obj_0000_axi_writer_BRESP_exp,
    class_obj_0000_axi_writer_BVALID_exp => class_m0_0002_class_obj_0000_axi_writer_BVALID_exp,
    class_obj_0000_axi_writer_BREADY_exp => class_m0_0002_class_obj_0000_axi_writer_BREADY_exp,
    write_data_addr => class_m0_0002_write_data_addr,
    write_data_data => class_m0_0002_write_data_data,
    read_data_addr => class_m0_0002_read_data_addr,
    write_data_busy => class_m0_0002_write_data_busy,
    write_data_req => class_m0_0002_write_data_req,
    read_data_return => class_m0_0002_read_data_return,
    read_data_busy => class_m0_0002_read_data_busy,
    read_data_req => class_m0_0002_read_data_req,
    test_busy => class_m0_0002_test_busy,
    test_req => class_m0_0002_test_req
  );


end RTL;
