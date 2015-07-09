library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AffineTransform is
  port (
    clk : in std_logic;
    reset : in std_logic;
    width_in : in signed(32-1 downto 0);
    width_we : in std_logic;
    width_out : out signed(32-1 downto 0);
    height_in : in signed(32-1 downto 0);
    height_we : in std_logic;
    height_out : out signed(32-1 downto 0);
    inData_address : in signed(32-1 downto 0);
    inData_we : in std_logic;
    inData_oe : in std_logic;
    inData_din : in signed(32-1 downto 0);
    inData_dout : out signed(32-1 downto 0);
    inData_length : out signed(32-1 downto 0);
    outData_address : in signed(32-1 downto 0);
    outData_we : in std_logic;
    outData_oe : in std_logic;
    outData_din : in signed(32-1 downto 0);
    outData_dout : out signed(32-1 downto 0);
    outData_length : out signed(32-1 downto 0);
    cmpData_address : in signed(32-1 downto 0);
    cmpData_we : in std_logic;
    cmpData_oe : in std_logic;
    cmpData_din : in signed(32-1 downto 0);
    cmpData_dout : out signed(32-1 downto 0);
    cmpData_length : out signed(32-1 downto 0);
    mat00_in : in signed(16-1 downto 0);
    mat00_we : in std_logic;
    mat00_out : out signed(16-1 downto 0);
    mat01_in : in signed(16-1 downto 0);
    mat01_we : in std_logic;
    mat01_out : out signed(16-1 downto 0);
    mat02_in : in signed(16-1 downto 0);
    mat02_we : in std_logic;
    mat02_out : out signed(16-1 downto 0);
    mat10_in : in signed(16-1 downto 0);
    mat10_we : in std_logic;
    mat10_out : out signed(16-1 downto 0);
    mat11_in : in signed(16-1 downto 0);
    mat11_we : in std_logic;
    mat11_out : out signed(16-1 downto 0);
    mat12_in : in signed(16-1 downto 0);
    mat12_we : in std_logic;
    mat12_out : out signed(16-1 downto 0);
    modeInterpolation_in : in std_logic;
    modeInterpolation_we : in std_logic;
    modeInterpolation_out : out std_logic;
    modeCompare_in : in std_logic;
    modeCompare_we : in std_logic;
    modeCompare_out : out std_logic;
    diffCompare_in : in signed(32-1 downto 0);
    diffCompare_we : in std_logic;
    diffCompare_out : out signed(32-1 downto 0);
    clear_busy : out std_logic;
    clear_req : in std_logic;
    proc_busy : out std_logic;
    proc_req : in std_logic
  );
end AffineTransform;

architecture RTL of AffineTransform is

  attribute mark_debug : string;
  attribute keep : string;

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
  component synthesijer_mul32
    port (
      clk : in std_logic;
      reset : in std_logic;
      a : in signed(32-1 downto 0);
      b : in signed(32-1 downto 0);
      nd : in std_logic;
      result : out signed(32-1 downto 0);
      valid : out std_logic
    );
  end component synthesijer_mul32;

  signal clk_sig : std_logic;
  signal reset_sig : std_logic;
  signal width_in_sig : signed(32-1 downto 0);
  signal width_we_sig : std_logic;
  signal width_out_sig : signed(32-1 downto 0);
  signal height_in_sig : signed(32-1 downto 0);
  signal height_we_sig : std_logic;
  signal height_out_sig : signed(32-1 downto 0);
  signal inData_address_sig : signed(32-1 downto 0);
  signal inData_we_sig : std_logic;
  signal inData_oe_sig : std_logic;
  signal inData_din_sig : signed(32-1 downto 0);
  signal inData_dout_sig : signed(32-1 downto 0);
  signal inData_length_sig : signed(32-1 downto 0);
  signal outData_address_sig : signed(32-1 downto 0);
  signal outData_we_sig : std_logic;
  signal outData_oe_sig : std_logic;
  signal outData_din_sig : signed(32-1 downto 0);
  signal outData_dout_sig : signed(32-1 downto 0);
  signal outData_length_sig : signed(32-1 downto 0);
  signal cmpData_address_sig : signed(32-1 downto 0);
  signal cmpData_we_sig : std_logic;
  signal cmpData_oe_sig : std_logic;
  signal cmpData_din_sig : signed(32-1 downto 0);
  signal cmpData_dout_sig : signed(32-1 downto 0);
  signal cmpData_length_sig : signed(32-1 downto 0);
  signal mat00_in_sig : signed(16-1 downto 0);
  signal mat00_we_sig : std_logic;
  signal mat00_out_sig : signed(16-1 downto 0);
  signal mat01_in_sig : signed(16-1 downto 0);
  signal mat01_we_sig : std_logic;
  signal mat01_out_sig : signed(16-1 downto 0);
  signal mat02_in_sig : signed(16-1 downto 0);
  signal mat02_we_sig : std_logic;
  signal mat02_out_sig : signed(16-1 downto 0);
  signal mat10_in_sig : signed(16-1 downto 0);
  signal mat10_we_sig : std_logic;
  signal mat10_out_sig : signed(16-1 downto 0);
  signal mat11_in_sig : signed(16-1 downto 0);
  signal mat11_we_sig : std_logic;
  signal mat11_out_sig : signed(16-1 downto 0);
  signal mat12_in_sig : signed(16-1 downto 0);
  signal mat12_we_sig : std_logic;
  signal mat12_out_sig : signed(16-1 downto 0);
  signal modeInterpolation_in_sig : std_logic;
  signal modeInterpolation_we_sig : std_logic;
  signal modeInterpolation_out_sig : std_logic;
  signal modeCompare_in_sig : std_logic;
  signal modeCompare_we_sig : std_logic;
  signal modeCompare_out_sig : std_logic;
  signal diffCompare_in_sig : signed(32-1 downto 0);
  signal diffCompare_we_sig : std_logic;
  signal diffCompare_out_sig : signed(32-1 downto 0);
  signal clear_busy_sig : std_logic := '1';
  signal clear_req_sig : std_logic;
  signal proc_busy_sig : std_logic := '1';
  signal proc_req_sig : std_logic;

  signal class_width_0000 : signed(32-1 downto 0) := X"00000100";
  signal class_width_0000_mux : signed(32-1 downto 0);
  signal tmp_0001 : signed(32-1 downto 0);
  signal class_height_0001 : signed(32-1 downto 0) := X"00000080";
  signal class_height_0001_mux : signed(32-1 downto 0);
  signal tmp_0002 : signed(32-1 downto 0);
  signal class_inData_0002_clk : std_logic;
  signal class_inData_0002_reset : std_logic;
  signal class_inData_0002_length : signed(32-1 downto 0);
  signal class_inData_0002_address : signed(32-1 downto 0);
  signal class_inData_0002_din : signed(32-1 downto 0);
  signal class_inData_0002_dout : signed(32-1 downto 0);
  signal class_inData_0002_we : std_logic;
  signal class_inData_0002_oe : std_logic;
  signal class_inData_0002_address_b : signed(32-1 downto 0) := (others => '0');
  signal class_inData_0002_din_b : signed(32-1 downto 0) := (others => '0');
  signal class_inData_0002_dout_b : signed(32-1 downto 0);
  signal class_inData_0002_we_b : std_logic := '0';
  signal class_inData_0002_oe_b : std_logic := '0';
  signal class_outData_0003_clk : std_logic;
  signal class_outData_0003_reset : std_logic;
  signal class_outData_0003_length : signed(32-1 downto 0);
  signal class_outData_0003_address : signed(32-1 downto 0);
  signal class_outData_0003_din : signed(32-1 downto 0);
  signal class_outData_0003_dout : signed(32-1 downto 0);
  signal class_outData_0003_we : std_logic;
  signal class_outData_0003_oe : std_logic;
  signal class_outData_0003_address_b : signed(32-1 downto 0) := (others => '0');
  signal class_outData_0003_din_b : signed(32-1 downto 0) := (others => '0');
  signal class_outData_0003_dout_b : signed(32-1 downto 0);
  signal class_outData_0003_we_b : std_logic := '0';
  signal class_outData_0003_oe_b : std_logic := '0';
  signal class_cmpData_0004_clk : std_logic;
  signal class_cmpData_0004_reset : std_logic;
  signal class_cmpData_0004_length : signed(32-1 downto 0);
  signal class_cmpData_0004_address : signed(32-1 downto 0);
  signal class_cmpData_0004_din : signed(32-1 downto 0);
  signal class_cmpData_0004_dout : signed(32-1 downto 0);
  signal class_cmpData_0004_we : std_logic;
  signal class_cmpData_0004_oe : std_logic;
  signal class_cmpData_0004_address_b : signed(32-1 downto 0) := (others => '0');
  signal class_cmpData_0004_din_b : signed(32-1 downto 0) := (others => '0');
  signal class_cmpData_0004_dout_b : signed(32-1 downto 0);
  signal class_cmpData_0004_we_b : std_logic := '0';
  signal class_cmpData_0004_oe_b : std_logic := '0';
  signal class_mat00_0005 : signed(16-1 downto 0) := X"0000";
  signal class_mat00_0005_mux : signed(16-1 downto 0);
  signal tmp_0003 : signed(16-1 downto 0);
  signal class_mat01_0006 : signed(16-1 downto 0) := X"0400";
  signal class_mat01_0006_mux : signed(16-1 downto 0);
  signal tmp_0004 : signed(16-1 downto 0);
  signal class_mat02_0007 : signed(16-1 downto 0) := X"0000";
  signal class_mat02_0007_mux : signed(16-1 downto 0);
  signal tmp_0005 : signed(16-1 downto 0);
  signal class_mat10_0008 : signed(16-1 downto 0) := X"0400";
  signal class_mat10_0008_mux : signed(16-1 downto 0);
  signal tmp_0006 : signed(16-1 downto 0);
  signal class_mat11_0009 : signed(16-1 downto 0) := X"0000";
  signal class_mat11_0009_mux : signed(16-1 downto 0);
  signal tmp_0007 : signed(16-1 downto 0);
  signal class_mat12_0010 : signed(16-1 downto 0) := X"0000";
  signal class_mat12_0010_mux : signed(16-1 downto 0);
  signal tmp_0008 : signed(16-1 downto 0);
  signal class_modeInterpolation_0011 : std_logic := '1';
  signal class_modeInterpolation_0011_mux : std_logic;
  signal tmp_0009 : std_logic;
  signal class_modeCompare_0012 : std_logic := '1';
  signal class_modeCompare_0012_mux : std_logic;
  signal tmp_0010 : std_logic;
  signal class_diffCompare_0013 : signed(32-1 downto 0) := X"00000000";
  signal class_diffCompare_0013_mux : signed(32-1 downto 0);
  signal tmp_0011 : signed(32-1 downto 0);
  signal clear_i_0014 : signed(32-1 downto 0) := X"00000000";
  signal binary_expr_00015 : std_logic := '0';
  signal unary_expr_00016 : signed(32-1 downto 0) := (others => '0');
  signal clear_j_0017 : signed(32-1 downto 0) := X"00000000";
  signal binary_expr_00018 : std_logic := '0';
  signal unary_expr_00019 : signed(32-1 downto 0) := (others => '0');
  signal clear_indexPixel_0020 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00021 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00022 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00023 : signed(32-1 downto 0) := (others => '0');
  signal proc_i_0024 : signed(32-1 downto 0) := X"00000000";
  signal binary_expr_00025 : std_logic := '0';
  signal unary_expr_00026 : signed(32-1 downto 0) := (others => '0');
  signal proc_j_0027 : signed(32-1 downto 0) := X"00000000";
  signal binary_expr_00028 : std_logic := '0';
  signal unary_expr_00029 : signed(32-1 downto 0) := (others => '0');
  signal proc_indexPixel_0030 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00031 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00032 : signed(32-1 downto 0) := (others => '0');
  signal proc_warpedXorg_0033 : signed(32-1 downto 0) := (others => '0');
  signal cast_expr_00034 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00035 : signed(32-1 downto 0) := (others => '0');
  signal cast_expr_00036 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00037 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00038 : signed(32-1 downto 0) := (others => '0');
  signal cast_expr_00039 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00040 : signed(32-1 downto 0) := (others => '0');
  signal proc_warpedYorg_0041 : signed(32-1 downto 0) := (others => '0');
  signal cast_expr_00042 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00043 : signed(32-1 downto 0) := (others => '0');
  signal cast_expr_00044 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00045 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00046 : signed(32-1 downto 0) := (others => '0');
  signal cast_expr_00047 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00048 : signed(32-1 downto 0) := (others => '0');
  signal proc_warpedX_0049 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00050 : signed(32-1 downto 0) := (others => '0');
  signal proc_warpedY_0051 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00052 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00053 : std_logic := '0';
  signal binary_expr_00054 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00055 : std_logic := '0';
  signal binary_expr_00056 : std_logic := '0';
  signal binary_expr_00057 : std_logic := '0';
  signal binary_expr_00058 : std_logic := '0';
  signal binary_expr_00059 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00060 : std_logic := '0';
  signal binary_expr_00061 : std_logic := '0';
  signal proc_indexWarpedPixel_0062 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00063 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00064 : signed(32-1 downto 0) := (others => '0');
  signal proc_pixel_0065 : signed(32-1 downto 0) := X"00000000";
  signal proc_warpedXfrac_0066 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00067 : signed(32-1 downto 0) := (others => '0');
  signal proc_warpedYfrac_0068 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00069 : signed(32-1 downto 0) := (others => '0');
  signal proc_pixel00_0070 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00071 : signed(32-1 downto 0) := (others => '0');
  signal proc_pixel01_0072 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00073 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00074 : signed(32-1 downto 0) := (others => '0');
  signal proc_pixel10_0075 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00076 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00077 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00078 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00079 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00080 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00081 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00082 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00083 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00084 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00085 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00086 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00087 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00088 : signed(32-1 downto 0) := (others => '0');
  signal proc_diff_0089 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00090 : signed(32-1 downto 0) := (others => '0');
  signal cast_expr_00091 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00092 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00093 : std_logic := '0';
  signal binary_expr_00094 : signed(32-1 downto 0) := (others => '0');
  signal binary_expr_00095 : signed(32-1 downto 0) := (others => '0');
  signal array_access_00096 : signed(32-1 downto 0) := (others => '0');
  signal clear_req_flag : std_logic;
  signal clear_req_local : std_logic := '0';
  signal tmp_0012 : std_logic;
  signal proc_req_flag : std_logic;
  signal proc_req_local : std_logic := '0';
  signal tmp_0013 : std_logic;
  type Type_clear_method is (
    clear_method_IDLE,
    clear_method_S_0000,
    clear_method_S_0001,
    clear_method_S_0002,
    clear_method_S_0003,
    clear_method_S_0004,
    clear_method_S_0005,
    clear_method_S_0006,
    clear_method_S_0007,
    clear_method_S_0008,
    clear_method_S_0009,
    clear_method_S_0010,
    clear_method_S_0011,
    clear_method_S_0012,
    clear_method_S_0013,
    clear_method_S_0014,
    clear_method_S_0015,
    clear_method_S_0016,
    clear_method_S_0017,
    clear_method_S_0018,
    clear_method_S_0019,
    clear_method_S_0021,
    clear_method_S_0022,
    clear_method_S_0023  
  );
  signal clear_method : Type_clear_method := clear_method_IDLE;
  signal clear_method_delay : signed(32-1 downto 0) := (others => '0');
  signal clear_req_flag_d : std_logic := '0';
  signal clear_req_flag_edge : std_logic;
  signal tmp_0014 : std_logic;
  signal tmp_0015 : std_logic;
  signal tmp_0016 : std_logic;
  signal tmp_0017 : std_logic;
  signal tmp_0018 : std_logic;
  signal tmp_0019 : std_logic;
  signal tmp_0020 : std_logic;
  signal tmp_0021 : std_logic;
  signal u_synthesijer_mul32_clear_clk : std_logic;
  signal u_synthesijer_mul32_clear_reset : std_logic;
  signal u_synthesijer_mul32_clear_a : signed(32-1 downto 0) := (others => '0');
  signal u_synthesijer_mul32_clear_b : signed(32-1 downto 0) := (others => '0');
  signal u_synthesijer_mul32_clear_nd : std_logic := '0';
  signal u_synthesijer_mul32_clear_result : signed(32-1 downto 0);
  signal u_synthesijer_mul32_clear_valid : std_logic;
  signal tmp_0022 : std_logic;
  signal tmp_0023 : std_logic;
  signal tmp_0024 : std_logic;
  signal tmp_0025 : std_logic;
  signal tmp_0026 : std_logic;
  signal tmp_0027 : signed(32-1 downto 0);
  signal tmp_0028 : std_logic;
  signal tmp_0029 : signed(32-1 downto 0);
  signal tmp_0030 : signed(32-1 downto 0);
  type Type_proc_method is (
    proc_method_IDLE,
    proc_method_S_0000,
    proc_method_S_0001,
    proc_method_S_0002,
    proc_method_S_0004,
    proc_method_S_0005,
    proc_method_S_0006,
    proc_method_S_0007,
    proc_method_S_0008,
    proc_method_S_0009,
    proc_method_S_0010,
    proc_method_S_0011,
    proc_method_S_0012,
    proc_method_S_0013,
    proc_method_S_0014,
    proc_method_S_0015,
    proc_method_S_0016,
    proc_method_S_0017,
    proc_method_S_0018,
    proc_method_S_0019,
    proc_method_S_0021,
    proc_method_S_0022,
    proc_method_S_0023,
    proc_method_S_0024,
    proc_method_S_0026,
    proc_method_S_0027,
    proc_method_S_0029,
    proc_method_S_0030,
    proc_method_S_0031,
    proc_method_S_0032,
    proc_method_S_0034,
    proc_method_S_0035,
    proc_method_S_0038,
    proc_method_S_0039,
    proc_method_S_0044,
    proc_method_S_0045,
    proc_method_S_0048,
    proc_method_S_0049,
    proc_method_S_0050,
    proc_method_S_0051,
    proc_method_S_0052,
    proc_method_S_0053,
    proc_method_S_0054,
    proc_method_S_0055,
    proc_method_S_0057,
    proc_method_S_0058,
    proc_method_S_0059,
    proc_method_S_0060,
    proc_method_S_0063,
    proc_method_S_0064,
    proc_method_S_0066,
    proc_method_S_0067,
    proc_method_S_0069,
    proc_method_S_0070,
    proc_method_S_0072,
    proc_method_S_0073,
    proc_method_S_0074,
    proc_method_S_0076,
    proc_method_S_0077,
    proc_method_S_0078,
    proc_method_S_0079,
    proc_method_S_0080,
    proc_method_S_0081,
    proc_method_S_0082,
    proc_method_S_0083,
    proc_method_S_0084,
    proc_method_S_0085,
    proc_method_S_0086,
    proc_method_S_0087,
    proc_method_S_0088,
    proc_method_S_0089,
    proc_method_S_0090,
    proc_method_S_0091,
    proc_method_S_0092,
    proc_method_S_0093,
    proc_method_S_0094,
    proc_method_S_0095,
    proc_method_S_0096,
    proc_method_S_0097,
    proc_method_S_0098,
    proc_method_S_0099,
    proc_method_S_0100,
    proc_method_S_0101,
    proc_method_S_0102,
    proc_method_S_0104,
    proc_method_S_0105,
    proc_method_S_0106,
    proc_method_S_0107  
  );
  signal proc_method : Type_proc_method := proc_method_IDLE;
  signal proc_method_delay : signed(32-1 downto 0) := (others => '0');
  signal proc_req_flag_d : std_logic := '0';
  signal proc_req_flag_edge : std_logic;
  signal tmp_0031 : std_logic;
  signal tmp_0032 : std_logic;
  signal tmp_0033 : std_logic;
  signal tmp_0034 : std_logic;
  signal tmp_0035 : std_logic;
  signal tmp_0036 : std_logic;
  signal tmp_0037 : std_logic;
  signal tmp_0038 : std_logic;
  signal u_synthesijer_mul32_proc_clk : std_logic;
  signal u_synthesijer_mul32_proc_reset : std_logic;
  signal u_synthesijer_mul32_proc_a : signed(32-1 downto 0) := (others => '0');
  signal u_synthesijer_mul32_proc_b : signed(32-1 downto 0) := (others => '0');
  signal u_synthesijer_mul32_proc_nd : std_logic := '0';
  signal u_synthesijer_mul32_proc_result : signed(32-1 downto 0);
  signal u_synthesijer_mul32_proc_valid : std_logic;
  signal tmp_0039 : std_logic;
  signal tmp_0040 : std_logic;
  signal tmp_0041 : std_logic;
  signal tmp_0042 : std_logic;
  signal tmp_0043 : std_logic;
  signal tmp_0044 : std_logic;
  signal tmp_0045 : std_logic;
  signal tmp_0046 : std_logic;
  signal tmp_0047 : std_logic;
  signal tmp_0048 : std_logic;
  signal tmp_0049 : std_logic;
  signal tmp_0050 : std_logic;
  signal tmp_0051 : std_logic;
  signal tmp_0052 : signed(32-1 downto 0);
  signal tmp_0053 : std_logic;
  signal tmp_0054 : signed(32-1 downto 0);
  signal tmp_0055 : signed(32-1 downto 0);
  signal tmp_0056 : signed(32-1 downto 0);
  signal tmp_0057 : signed(32-1 downto 0);
  signal tmp_0058 : signed(32-1 downto 0);
  signal tmp_0059 : signed(32-1 downto 0);
  signal tmp_0060 : signed(32-1 downto 0);
  signal tmp_0061 : signed(32-1 downto 0);
  signal tmp_0062 : signed(32-1 downto 0);
  signal tmp_0063 : signed(32-1 downto 0);
  signal tmp_0064 : signed(32-1 downto 0);
  signal tmp_0065 : signed(32-1 downto 0);
  signal tmp_0066 : signed(32-1 downto 0);
  signal tmp_0067 : signed(32-1 downto 0);
  signal tmp_0068 : signed(32-1 downto 0);
  signal tmp_0069 : std_logic;
  signal tmp_0070 : std_logic;
  signal tmp_0071 : signed(32-1 downto 0);
  signal tmp_0072 : std_logic;
  signal tmp_0073 : std_logic;
  signal tmp_0074 : std_logic;
  signal tmp_0075 : std_logic;
  signal tmp_0076 : std_logic;
  signal tmp_0077 : signed(32-1 downto 0);
  signal tmp_0078 : signed(32-1 downto 0);
  signal tmp_0079 : signed(32-1 downto 0);
  signal tmp_0080 : signed(32-1 downto 0);
  signal tmp_0081 : signed(32-1 downto 0);
  signal tmp_0082 : signed(32-1 downto 0);
  signal tmp_0083 : signed(32-1 downto 0);
  signal tmp_0084 : signed(32-1 downto 0);
  signal tmp_0085 : signed(32-1 downto 0);
  signal tmp_0086 : signed(32-1 downto 0);
  signal tmp_0087 : signed(32-1 downto 0);
  signal tmp_0088 : signed(32-1 downto 0);
  signal tmp_0089 : std_logic;
  signal tmp_0090 : signed(32-1 downto 0);
  signal tmp_0091 : signed(32-1 downto 0);

begin

  clk_sig <= clk;
  reset_sig <= reset;
  width_in_sig <= width_in;
  width_we_sig <= width_we;
  width_out <= width_out_sig;
  width_out_sig <= class_width_0000;

  height_in_sig <= height_in;
  height_we_sig <= height_we;
  height_out <= height_out_sig;
  height_out_sig <= class_height_0001;

  inData_address_sig <= inData_address;
  inData_we_sig <= inData_we;
  inData_oe_sig <= inData_oe;
  inData_din_sig <= inData_din;
  inData_dout <= inData_dout_sig;
  inData_dout_sig <= class_inData_0002_dout;

  inData_length <= inData_length_sig;
  inData_length_sig <= class_inData_0002_length;

  outData_address_sig <= outData_address;
  outData_we_sig <= outData_we;
  outData_oe_sig <= outData_oe;
  outData_din_sig <= outData_din;
  outData_dout <= outData_dout_sig;
  outData_dout_sig <= class_outData_0003_dout;

  outData_length <= outData_length_sig;
  outData_length_sig <= class_outData_0003_length;

  cmpData_address_sig <= cmpData_address;
  cmpData_we_sig <= cmpData_we;
  cmpData_oe_sig <= cmpData_oe;
  cmpData_din_sig <= cmpData_din;
  cmpData_dout <= cmpData_dout_sig;
  cmpData_dout_sig <= class_cmpData_0004_dout;

  cmpData_length <= cmpData_length_sig;
  cmpData_length_sig <= class_cmpData_0004_length;

  mat00_in_sig <= mat00_in;
  mat00_we_sig <= mat00_we;
  mat00_out <= mat00_out_sig;
  mat00_out_sig <= class_mat00_0005;

  mat01_in_sig <= mat01_in;
  mat01_we_sig <= mat01_we;
  mat01_out <= mat01_out_sig;
  mat01_out_sig <= class_mat01_0006;

  mat02_in_sig <= mat02_in;
  mat02_we_sig <= mat02_we;
  mat02_out <= mat02_out_sig;
  mat02_out_sig <= class_mat02_0007;

  mat10_in_sig <= mat10_in;
  mat10_we_sig <= mat10_we;
  mat10_out <= mat10_out_sig;
  mat10_out_sig <= class_mat10_0008;

  mat11_in_sig <= mat11_in;
  mat11_we_sig <= mat11_we;
  mat11_out <= mat11_out_sig;
  mat11_out_sig <= class_mat11_0009;

  mat12_in_sig <= mat12_in;
  mat12_we_sig <= mat12_we;
  mat12_out <= mat12_out_sig;
  mat12_out_sig <= class_mat12_0010;

  modeInterpolation_in_sig <= modeInterpolation_in;
  modeInterpolation_we_sig <= modeInterpolation_we;
  modeInterpolation_out <= modeInterpolation_out_sig;
  modeInterpolation_out_sig <= class_modeInterpolation_0011;

  modeCompare_in_sig <= modeCompare_in;
  modeCompare_we_sig <= modeCompare_we;
  modeCompare_out <= modeCompare_out_sig;
  modeCompare_out_sig <= class_modeCompare_0012;

  diffCompare_in_sig <= diffCompare_in;
  diffCompare_we_sig <= diffCompare_we;
  diffCompare_out <= diffCompare_out_sig;
  diffCompare_out_sig <= class_diffCompare_0013;

  clear_busy <= clear_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        clear_busy_sig <= '1';
      else
        if clear_method = clear_method_S_0000 then
          clear_busy_sig <= '0';
        elsif clear_method = clear_method_S_0001 then
          clear_busy_sig <= tmp_0017;
        end if;
      end if;
    end if;
  end process;

  clear_req_sig <= clear_req;
  proc_busy <= proc_busy_sig;
  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_busy_sig <= '1';
      else
        if proc_method = proc_method_S_0000 then
          proc_busy_sig <= '0';
        elsif proc_method = proc_method_S_0001 then
          proc_busy_sig <= tmp_0034;
        end if;
      end if;
    end if;
  end process;

  proc_req_sig <= proc_req;

  -- expressions
  tmp_0001 <= width_in_sig when width_we_sig = '1' else class_width_0000;
  tmp_0002 <= height_in_sig when height_we_sig = '1' else class_height_0001;
  tmp_0003 <= mat00_in_sig when mat00_we_sig = '1' else class_mat00_0005;
  tmp_0004 <= mat01_in_sig when mat01_we_sig = '1' else class_mat01_0006;
  tmp_0005 <= mat02_in_sig when mat02_we_sig = '1' else class_mat02_0007;
  tmp_0006 <= mat10_in_sig when mat10_we_sig = '1' else class_mat10_0008;
  tmp_0007 <= mat11_in_sig when mat11_we_sig = '1' else class_mat11_0009;
  tmp_0008 <= mat12_in_sig when mat12_we_sig = '1' else class_mat12_0010;
  tmp_0009 <= modeInterpolation_in_sig when modeInterpolation_we_sig = '1' else class_modeInterpolation_0011;
  tmp_0010 <= modeCompare_in_sig when modeCompare_we_sig = '1' else class_modeCompare_0012;
  tmp_0011 <= diffCompare_in_sig when diffCompare_we_sig = '1' else class_diffCompare_0013;
  tmp_0012 <= clear_req_local or clear_req_sig;
  tmp_0013 <= proc_req_local or proc_req_sig;
  tmp_0014 <= not clear_req_flag_d;
  tmp_0015 <= clear_req_flag and tmp_0014;
  tmp_0016 <= clear_req_flag or clear_req_flag_d;
  tmp_0017 <= clear_req_flag or clear_req_flag_d;
  tmp_0018 <= '1' when binary_expr_00015 = '1' else '0';
  tmp_0019 <= '1' when binary_expr_00015 = '0' else '0';
  tmp_0020 <= '1' when binary_expr_00018 = '1' else '0';
  tmp_0021 <= '1' when binary_expr_00018 = '0' else '0';
  tmp_0022 <= '1' when clear_method /= clear_method_S_0000 else '0';
  tmp_0023 <= '1' when clear_method /= clear_method_S_0001 else '0';
  tmp_0024 <= tmp_0023 and clear_req_flag_edge;
  tmp_0025 <= tmp_0022 and tmp_0024;
  tmp_0026 <= '1' when clear_i_0014 < class_height_0001 else '0';
  tmp_0027 <= clear_i_0014 + X"00000001";
  tmp_0028 <= '1' when clear_j_0017 < class_width_0000 else '0';
  tmp_0029 <= clear_j_0017 + X"00000001";
  tmp_0030 <= binary_expr_00021 + clear_j_0017;
  tmp_0031 <= not proc_req_flag_d;
  tmp_0032 <= proc_req_flag and tmp_0031;
  tmp_0033 <= proc_req_flag or proc_req_flag_d;
  tmp_0034 <= proc_req_flag or proc_req_flag_d;
  tmp_0035 <= '1' when binary_expr_00025 = '1' else '0';
  tmp_0036 <= '1' when binary_expr_00025 = '0' else '0';
  tmp_0037 <= '1' when binary_expr_00028 = '1' else '0';
  tmp_0038 <= '1' when binary_expr_00028 = '0' else '0';
  tmp_0039 <= '1' when binary_expr_00061 = '1' else '0';
  tmp_0040 <= '1' when binary_expr_00061 = '0' else '0';
  tmp_0041 <= '1' when class_modeInterpolation_0011 = '1' else '0';
  tmp_0042 <= '1' when class_modeInterpolation_0011 = '0' else '0';
  tmp_0043 <= '1' when class_modeCompare_0012 = '1' else '0';
  tmp_0044 <= '1' when class_modeCompare_0012 = '0' else '0';
  tmp_0045 <= '1' when binary_expr_00093 = '1' else '0';
  tmp_0046 <= '1' when binary_expr_00093 = '0' else '0';
  tmp_0047 <= '1' when proc_method /= proc_method_S_0000 else '0';
  tmp_0048 <= '1' when proc_method /= proc_method_S_0001 else '0';
  tmp_0049 <= tmp_0048 and proc_req_flag_edge;
  tmp_0050 <= tmp_0047 and tmp_0049;
  tmp_0051 <= '1' when proc_i_0024 < class_height_0001 else '0';
  tmp_0052 <= proc_i_0024 + X"00000001";
  tmp_0053 <= '1' when proc_j_0027 < class_width_0000 else '0';
  tmp_0054 <= proc_j_0027 + X"00000001";
  tmp_0055 <= binary_expr_00031 + proc_j_0027;
  tmp_0056 <= (32-1 downto 16 => class_mat00_0005(15)) & class_mat00_0005;
  tmp_0057 <= (32-1 downto 16 => class_mat01_0006(15)) & class_mat01_0006;
  tmp_0058 <= binary_expr_00035 + binary_expr_00037;
  tmp_0059 <= (32-1 downto 16 => class_mat02_0007(15)) & class_mat02_0007;
  tmp_0060 <= (32-1 downto 16 => class_mat10_0008(15)) & class_mat10_0008;
  tmp_0061 <= binary_expr_00038 + cast_expr_00039;
  tmp_0062 <= (32-1 downto 16 => class_mat11_0009(15)) & class_mat11_0009;
  tmp_0063 <= binary_expr_00043 + binary_expr_00045;
  tmp_0064 <= (32-1 downto 16 => class_mat12_0010(15)) & class_mat12_0010;
  tmp_0065 <= (32-1 downto 22 => proc_warpedXorg_0033(31)) & proc_warpedXorg_0033(31 downto 10);
  tmp_0066 <= class_width_0000 - X"00000001";
  tmp_0067 <= class_height_0001 - X"00000001";
  tmp_0068 <= binary_expr_00046 + cast_expr_00047;
  tmp_0069 <= '1' when proc_warpedX_0049 < X"00000000" else '0';
  tmp_0070 <= '1' when proc_warpedX_0049 >= binary_expr_00054 else '0';
  tmp_0071 <= (32-1 downto 22 => proc_warpedYorg_0041(31)) & proc_warpedYorg_0041(31 downto 10);
  tmp_0072 <= binary_expr_00053 or binary_expr_00055;
  tmp_0073 <= '1' when proc_warpedY_0051 < X"00000000" else '0';
  tmp_0074 <= '1' when proc_warpedY_0051 >= binary_expr_00059 else '0';
  tmp_0075 <= binary_expr_00056 or binary_expr_00057;
  tmp_0076 <= binary_expr_00058 or binary_expr_00060;
  tmp_0077 <= binary_expr_00063 + proc_warpedX_0049;
  tmp_0078 <= proc_warpedXorg_0033 and X"000003ff";
  tmp_0079 <= proc_warpedYorg_0041 and X"000003ff";
  tmp_0080 <= proc_indexWarpedPixel_0062 + X"00000001";
  tmp_0081 <= proc_indexWarpedPixel_0062 + class_width_0000;
  tmp_0082 <= X"00000400" - proc_warpedXfrac_0066;
  tmp_0083 <= binary_expr_00079 + binary_expr_00080;
  tmp_0084 <= X"00000400" - proc_warpedYfrac_0068;
  tmp_0085 <= binary_expr_00081 + binary_expr_00083;
  tmp_0086 <= binary_expr_00084 + binary_expr_00085;
  tmp_0087 <= (32-1 downto 21 => binary_expr_00086(31)) & binary_expr_00086(31 downto 11);
  tmp_0088 <= cast_expr_00091 - proc_pixel_0065;
  tmp_0089 <= '1' when proc_diff_0089 > X"00000000" else '0';
  tmp_0090 <= class_diffCompare_0013 + proc_diff_0089;
  tmp_0091 <= class_diffCompare_0013 - proc_diff_0089;

  -- sequencers
  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        clear_method <= clear_method_IDLE;
        clear_method_delay <= (others => '0');
      else
        case (clear_method) is
          when clear_method_IDLE => 
            clear_method <= clear_method_S_0000;
          when clear_method_S_0000 => 
            clear_method <= clear_method_S_0001;
          when clear_method_S_0001 => 
            if tmp_0016 = '1' then
              clear_method <= clear_method_S_0002;
            end if;
          when clear_method_S_0002 => 
            clear_method <= clear_method_S_0003;
          when clear_method_S_0003 => 
            clear_method <= clear_method_S_0004;
          when clear_method_S_0004 => 
            if tmp_0018 = '1' then
              clear_method <= clear_method_S_0009;
            elsif tmp_0019 = '1' then
              clear_method <= clear_method_S_0005;
            end if;
          when clear_method_S_0005 => 
            clear_method <= clear_method_S_0023;
          when clear_method_S_0006 => 
            clear_method <= clear_method_S_0007;
          when clear_method_S_0007 => 
            clear_method <= clear_method_S_0008;
          when clear_method_S_0008 => 
            clear_method <= clear_method_S_0003;
          when clear_method_S_0009 => 
            clear_method <= clear_method_S_0010;
          when clear_method_S_0010 => 
            clear_method <= clear_method_S_0011;
          when clear_method_S_0011 => 
            if tmp_0020 = '1' then
              clear_method <= clear_method_S_0016;
            elsif tmp_0021 = '1' then
              clear_method <= clear_method_S_0012;
            end if;
          when clear_method_S_0012 => 
            clear_method <= clear_method_S_0022;
          when clear_method_S_0013 => 
            clear_method <= clear_method_S_0014;
          when clear_method_S_0014 => 
            clear_method <= clear_method_S_0015;
          when clear_method_S_0015 => 
            clear_method <= clear_method_S_0010;
          when clear_method_S_0016 => 
            if clear_method_delay >= 1 and u_synthesijer_mul32_clear_valid = '1' then
              clear_method_delay <= (others => '0');
              clear_method <= clear_method_S_0017;
            else
              clear_method_delay <= clear_method_delay + 1;
            end if;
          when clear_method_S_0017 => 
            clear_method <= clear_method_S_0018;
          when clear_method_S_0018 => 
            clear_method <= clear_method_S_0019;
          when clear_method_S_0019 => 
            clear_method <= clear_method_S_0021;
          when clear_method_S_0021 => 
            clear_method <= clear_method_S_0013;
          when clear_method_S_0022 => 
            clear_method <= clear_method_S_0006;
          when clear_method_S_0023 => 
            clear_method <= clear_method_S_0000;
          when others => null;
        end case;
        clear_req_flag_d <= clear_req_flag;
        if (tmp_0022 and tmp_0024) = '1' then
          clear_method <= clear_method_S_0001;
        end if;
      end if;
    end if;
  end process;

  process (clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_method <= proc_method_IDLE;
        proc_method_delay <= (others => '0');
      else
        case (proc_method) is
          when proc_method_IDLE => 
            proc_method <= proc_method_S_0000;
          when proc_method_S_0000 => 
            proc_method <= proc_method_S_0001;
          when proc_method_S_0001 => 
            if tmp_0033 = '1' then
              proc_method <= proc_method_S_0002;
            end if;
          when proc_method_S_0002 => 
            proc_method <= proc_method_S_0004;
          when proc_method_S_0004 => 
            proc_method <= proc_method_S_0005;
          when proc_method_S_0005 => 
            if tmp_0035 = '1' then
              proc_method <= proc_method_S_0010;
            elsif tmp_0036 = '1' then
              proc_method <= proc_method_S_0006;
            end if;
          when proc_method_S_0006 => 
            proc_method <= proc_method_S_0107;
          when proc_method_S_0007 => 
            proc_method <= proc_method_S_0008;
          when proc_method_S_0008 => 
            proc_method <= proc_method_S_0009;
          when proc_method_S_0009 => 
            proc_method <= proc_method_S_0004;
          when proc_method_S_0010 => 
            proc_method <= proc_method_S_0011;
          when proc_method_S_0011 => 
            proc_method <= proc_method_S_0012;
          when proc_method_S_0012 => 
            if tmp_0037 = '1' then
              proc_method <= proc_method_S_0017;
            elsif tmp_0038 = '1' then
              proc_method <= proc_method_S_0013;
            end if;
          when proc_method_S_0013 => 
            proc_method <= proc_method_S_0106;
          when proc_method_S_0014 => 
            proc_method <= proc_method_S_0015;
          when proc_method_S_0015 => 
            proc_method <= proc_method_S_0016;
          when proc_method_S_0016 => 
            proc_method <= proc_method_S_0011;
          when proc_method_S_0017 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0018;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0018 => 
            proc_method <= proc_method_S_0019;
          when proc_method_S_0019 => 
            proc_method <= proc_method_S_0021;
          when proc_method_S_0021 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0022;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0022 => 
            proc_method <= proc_method_S_0023;
          when proc_method_S_0023 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0024;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0024 => 
            proc_method <= proc_method_S_0026;
          when proc_method_S_0026 => 
            proc_method <= proc_method_S_0027;
          when proc_method_S_0027 => 
            proc_method <= proc_method_S_0029;
          when proc_method_S_0029 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0030;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0030 => 
            proc_method <= proc_method_S_0031;
          when proc_method_S_0031 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0032;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0032 => 
            proc_method <= proc_method_S_0034;
          when proc_method_S_0034 => 
            proc_method <= proc_method_S_0035;
          when proc_method_S_0035 => 
            proc_method <= proc_method_S_0038;
          when proc_method_S_0038 => 
            proc_method <= proc_method_S_0039;
          when proc_method_S_0039 => 
            proc_method <= proc_method_S_0044;
          when proc_method_S_0044 => 
            proc_method <= proc_method_S_0045;
          when proc_method_S_0045 => 
            proc_method <= proc_method_S_0048;
          when proc_method_S_0048 => 
            proc_method <= proc_method_S_0049;
          when proc_method_S_0049 => 
            if tmp_0039 = '1' then
              proc_method <= proc_method_S_0051;
            elsif tmp_0040 = '1' then
              proc_method <= proc_method_S_0050;
            end if;
          when proc_method_S_0050 => 
            proc_method <= proc_method_S_0053;
          when proc_method_S_0051 => 
            proc_method <= proc_method_S_0013;
          when proc_method_S_0052 => 
            proc_method <= proc_method_S_0050;
          when proc_method_S_0053 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0054;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0054 => 
            proc_method <= proc_method_S_0055;
          when proc_method_S_0055 => 
            proc_method <= proc_method_S_0057;
          when proc_method_S_0057 => 
            if tmp_0041 = '1' then
              proc_method <= proc_method_S_0059;
            elsif tmp_0042 = '1' then
              proc_method <= proc_method_S_0083;
            end if;
          when proc_method_S_0058 => 
            proc_method <= proc_method_S_0086;
          when proc_method_S_0059 => 
            proc_method <= proc_method_S_0060;
          when proc_method_S_0060 => 
            proc_method <= proc_method_S_0063;
          when proc_method_S_0063 => 
            if proc_method_delay >= 2 then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0064;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0064 => 
            proc_method <= proc_method_S_0066;
          when proc_method_S_0066 => 
            if proc_method_delay >= 2 then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0067;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0067 => 
            proc_method <= proc_method_S_0069;
          when proc_method_S_0069 => 
            if proc_method_delay >= 2 then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0070;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0070 => 
            proc_method <= proc_method_S_0072;
          when proc_method_S_0072 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0073;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0073 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0074;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0074 => 
            proc_method <= proc_method_S_0076;
          when proc_method_S_0076 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0077;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0077 => 
            proc_method <= proc_method_S_0078;
          when proc_method_S_0078 => 
            if proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0079;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0079 => 
            proc_method <= proc_method_S_0080;
          when proc_method_S_0080 => 
            proc_method <= proc_method_S_0081;
          when proc_method_S_0081 => 
            proc_method <= proc_method_S_0082;
          when proc_method_S_0082 => 
            proc_method <= proc_method_S_0058;
          when proc_method_S_0083 => 
            if proc_method_delay >= 2 then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0084;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0084 => 
            proc_method <= proc_method_S_0085;
          when proc_method_S_0085 => 
            proc_method <= proc_method_S_0058;
          when proc_method_S_0086 => 
            if tmp_0043 = '1' then
              proc_method <= proc_method_S_0088;
            elsif tmp_0044 = '1' then
              proc_method <= proc_method_S_0102;
            end if;
          when proc_method_S_0087 => 
            proc_method <= proc_method_S_0105;
          when proc_method_S_0088 => 
            if proc_method_delay >= 2 then
              proc_method_delay <= (others => '0');
              proc_method <= proc_method_S_0089;
            else
              proc_method_delay <= proc_method_delay + 1;
            end if;
          when proc_method_S_0089 => 
            proc_method <= proc_method_S_0090;
          when proc_method_S_0090 => 
            proc_method <= proc_method_S_0091;
          when proc_method_S_0091 => 
            proc_method <= proc_method_S_0092;
          when proc_method_S_0092 => 
            proc_method <= proc_method_S_0093;
          when proc_method_S_0093 => 
            if tmp_0045 = '1' then
              proc_method <= proc_method_S_0095;
            elsif tmp_0046 = '1' then
              proc_method <= proc_method_S_0098;
            end if;
          when proc_method_S_0094 => 
            proc_method <= proc_method_S_0101;
          when proc_method_S_0095 => 
            proc_method <= proc_method_S_0096;
          when proc_method_S_0096 => 
            proc_method <= proc_method_S_0097;
          when proc_method_S_0097 => 
            proc_method <= proc_method_S_0094;
          when proc_method_S_0098 => 
            proc_method <= proc_method_S_0099;
          when proc_method_S_0099 => 
            proc_method <= proc_method_S_0100;
          when proc_method_S_0100 => 
            proc_method <= proc_method_S_0094;
          when proc_method_S_0101 => 
            proc_method <= proc_method_S_0087;
          when proc_method_S_0102 => 
            proc_method <= proc_method_S_0104;
          when proc_method_S_0104 => 
            proc_method <= proc_method_S_0087;
          when proc_method_S_0105 => 
            proc_method <= proc_method_S_0014;
          when proc_method_S_0106 => 
            proc_method <= proc_method_S_0007;
          when proc_method_S_0107 => 
            proc_method <= proc_method_S_0000;
          when others => null;
        end case;
        proc_req_flag_d <= proc_req_flag;
        if (tmp_0047 and tmp_0049) = '1' then
          proc_method <= proc_method_S_0001;
        end if;
      end if;
    end if;
  end process;


  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_width_0000 <= X"00000100";
      else
        class_width_0000 <= class_width_0000_mux;
      end if;
    end if;
  end process;

  class_width_0000_mux <= tmp_0001;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_height_0001 <= X"00000080";
      else
        class_height_0001 <= class_height_0001_mux;
      end if;
    end if;
  end process;

  class_height_0001_mux <= tmp_0002;

  class_inData_0002_clk <= clk_sig;

  class_inData_0002_reset <= reset_sig;

  class_inData_0002_address <= inData_address_sig;

  class_inData_0002_din <= inData_din_sig;

  class_inData_0002_we <= inData_we_sig;

  class_inData_0002_oe <= inData_oe_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_inData_0002_address_b <= (others => '0');
      else
        if proc_method = proc_method_S_0063 and proc_method_delay = 0 then
          class_inData_0002_address_b <= proc_indexWarpedPixel_0062;
        elsif proc_method = proc_method_S_0066 and proc_method_delay = 0 then
          class_inData_0002_address_b <= binary_expr_00073;
        elsif proc_method = proc_method_S_0069 and proc_method_delay = 0 then
          class_inData_0002_address_b <= binary_expr_00076;
        elsif proc_method = proc_method_S_0083 and proc_method_delay = 0 then
          class_inData_0002_address_b <= proc_indexWarpedPixel_0062;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_inData_0002_oe_b <= '0';
      else
        if proc_method = proc_method_S_0063 and proc_method_delay = 0 then
          class_inData_0002_oe_b <= '1';
        elsif proc_method = proc_method_S_0066 and proc_method_delay = 0 then
          class_inData_0002_oe_b <= '1';
        elsif proc_method = proc_method_S_0069 and proc_method_delay = 0 then
          class_inData_0002_oe_b <= '1';
        elsif proc_method = proc_method_S_0083 and proc_method_delay = 0 then
          class_inData_0002_oe_b <= '1';
        else
          class_inData_0002_oe_b <= '0';
        end if;
      end if;
    end if;
  end process;

  class_outData_0003_clk <= clk_sig;

  class_outData_0003_reset <= reset_sig;

  class_outData_0003_address <= outData_address_sig;

  class_outData_0003_din <= outData_din_sig;

  class_outData_0003_we <= outData_we_sig;

  class_outData_0003_oe <= outData_oe_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_outData_0003_address_b <= (others => '0');
      else
        if clear_method = clear_method_S_0019 then
          class_outData_0003_address_b <= clear_indexPixel_0020;
        elsif proc_method = proc_method_S_0102 then
          class_outData_0003_address_b <= proc_indexPixel_0030;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_outData_0003_din_b <= (others => '0');
      else
        if clear_method = clear_method_S_0019 then
          class_outData_0003_din_b <= X"00000000";
        elsif proc_method = proc_method_S_0102 then
          class_outData_0003_din_b <= proc_pixel_0065;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_outData_0003_we_b <= '0';
      else
        if clear_method = clear_method_S_0019 then
          class_outData_0003_we_b <= '1';
        elsif proc_method = proc_method_S_0102 then
          class_outData_0003_we_b <= '1';
        else
          class_outData_0003_we_b <= '0';
        end if;
      end if;
    end if;
  end process;

  class_cmpData_0004_clk <= clk_sig;

  class_cmpData_0004_reset <= reset_sig;

  class_cmpData_0004_address <= cmpData_address_sig;

  class_cmpData_0004_din <= cmpData_din_sig;

  class_cmpData_0004_we <= cmpData_we_sig;

  class_cmpData_0004_oe <= cmpData_oe_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_cmpData_0004_address_b <= (others => '0');
      else
        if proc_method = proc_method_S_0088 and proc_method_delay = 0 then
          class_cmpData_0004_address_b <= proc_indexPixel_0030;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_cmpData_0004_oe_b <= '0';
      else
        if proc_method = proc_method_S_0088 and proc_method_delay = 0 then
          class_cmpData_0004_oe_b <= '1';
        else
          class_cmpData_0004_oe_b <= '0';
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_mat00_0005 <= X"0000";
      else
        class_mat00_0005 <= class_mat00_0005_mux;
      end if;
    end if;
  end process;

  class_mat00_0005_mux <= tmp_0003;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_mat01_0006 <= X"0400";
      else
        class_mat01_0006 <= class_mat01_0006_mux;
      end if;
    end if;
  end process;

  class_mat01_0006_mux <= tmp_0004;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_mat02_0007 <= X"0000";
      else
        class_mat02_0007 <= class_mat02_0007_mux;
      end if;
    end if;
  end process;

  class_mat02_0007_mux <= tmp_0005;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_mat10_0008 <= X"0400";
      else
        class_mat10_0008 <= class_mat10_0008_mux;
      end if;
    end if;
  end process;

  class_mat10_0008_mux <= tmp_0006;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_mat11_0009 <= X"0000";
      else
        class_mat11_0009 <= class_mat11_0009_mux;
      end if;
    end if;
  end process;

  class_mat11_0009_mux <= tmp_0007;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_mat12_0010 <= X"0000";
      else
        class_mat12_0010 <= class_mat12_0010_mux;
      end if;
    end if;
  end process;

  class_mat12_0010_mux <= tmp_0008;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_modeInterpolation_0011 <= '1';
      else
        class_modeInterpolation_0011 <= class_modeInterpolation_0011_mux;
      end if;
    end if;
  end process;

  class_modeInterpolation_0011_mux <= tmp_0009;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_modeCompare_0012 <= '1';
      else
        class_modeCompare_0012 <= class_modeCompare_0012_mux;
      end if;
    end if;
  end process;

  class_modeCompare_0012_mux <= tmp_0010;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        class_diffCompare_0013 <= X"00000000";
      else
        if proc_method = proc_method_S_0002 then
          class_diffCompare_0013 <= X"00000000";
        elsif proc_method = proc_method_S_0096 then
          class_diffCompare_0013 <= binary_expr_00094;
        elsif proc_method = proc_method_S_0099 then
          class_diffCompare_0013 <= binary_expr_00095;
        else
          class_diffCompare_0013 <= class_diffCompare_0013_mux;
        end if;
      end if;
    end if;
  end process;

  class_diffCompare_0013_mux <= tmp_0011;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        clear_i_0014 <= X"00000000";
      else
        if clear_method = clear_method_S_0002 then
          clear_i_0014 <= X"00000000";
        elsif clear_method = clear_method_S_0007 then
          clear_i_0014 <= unary_expr_00016;
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
        if clear_method = clear_method_S_0003 then
          binary_expr_00015 <= tmp_0026;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        unary_expr_00016 <= (others => '0');
      else
        if clear_method = clear_method_S_0006 then
          unary_expr_00016 <= tmp_0027;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        clear_j_0017 <= X"00000000";
      else
        if clear_method = clear_method_S_0009 then
          clear_j_0017 <= X"00000000";
        elsif clear_method = clear_method_S_0014 then
          clear_j_0017 <= unary_expr_00019;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00018 <= '0';
      else
        if clear_method = clear_method_S_0010 then
          binary_expr_00018 <= tmp_0028;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        unary_expr_00019 <= (others => '0');
      else
        if clear_method = clear_method_S_0013 then
          unary_expr_00019 <= tmp_0029;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        clear_indexPixel_0020 <= (others => '0');
      else
        if clear_method = clear_method_S_0018 then
          clear_indexPixel_0020 <= binary_expr_00022;
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
        if clear_method = clear_method_S_0016 and clear_method_delay >= 1 and u_synthesijer_mul32_clear_valid = '1' then
          binary_expr_00021 <= u_synthesijer_mul32_clear_result;
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
        if clear_method = clear_method_S_0017 then
          binary_expr_00022 <= tmp_0030;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_i_0024 <= X"00000000";
      else
        if proc_method = proc_method_S_0002 then
          proc_i_0024 <= X"00000000";
        elsif proc_method = proc_method_S_0008 then
          proc_i_0024 <= unary_expr_00026;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00025 <= '0';
      else
        if proc_method = proc_method_S_0004 then
          binary_expr_00025 <= tmp_0051;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        unary_expr_00026 <= (others => '0');
      else
        if proc_method = proc_method_S_0007 then
          unary_expr_00026 <= tmp_0052;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_j_0027 <= X"00000000";
      else
        if proc_method = proc_method_S_0010 then
          proc_j_0027 <= X"00000000";
        elsif proc_method = proc_method_S_0015 then
          proc_j_0027 <= unary_expr_00029;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00028 <= '0';
      else
        if proc_method = proc_method_S_0011 then
          binary_expr_00028 <= tmp_0053;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        unary_expr_00029 <= (others => '0');
      else
        if proc_method = proc_method_S_0014 then
          unary_expr_00029 <= tmp_0054;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_indexPixel_0030 <= (others => '0');
      else
        if proc_method = proc_method_S_0019 then
          proc_indexPixel_0030 <= binary_expr_00032;
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
        if proc_method = proc_method_S_0017 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00031 <= u_synthesijer_mul32_proc_result;
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
        if proc_method = proc_method_S_0018 then
          binary_expr_00032 <= tmp_0055;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_warpedXorg_0033 <= (others => '0');
      else
        if proc_method = proc_method_S_0027 then
          proc_warpedXorg_0033 <= binary_expr_00040;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        cast_expr_00034 <= (others => '0');
      else
        if proc_method = proc_method_S_0018 then
          cast_expr_00034 <= tmp_0056;
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
        if proc_method = proc_method_S_0021 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00035 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        cast_expr_00036 <= (others => '0');
      else
        if proc_method = proc_method_S_0022 then
          cast_expr_00036 <= tmp_0057;
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
        if proc_method = proc_method_S_0023 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00037 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00038 <= (others => '0');
      else
        if proc_method = proc_method_S_0024 then
          binary_expr_00038 <= tmp_0058;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        cast_expr_00039 <= (others => '0');
      else
        if proc_method = proc_method_S_0024 then
          cast_expr_00039 <= tmp_0059;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00040 <= (others => '0');
      else
        if proc_method = proc_method_S_0026 then
          binary_expr_00040 <= tmp_0061;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_warpedYorg_0041 <= (others => '0');
      else
        if proc_method = proc_method_S_0035 then
          proc_warpedYorg_0041 <= binary_expr_00048;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        cast_expr_00042 <= (others => '0');
      else
        if proc_method = proc_method_S_0024 then
          cast_expr_00042 <= tmp_0060;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00043 <= (others => '0');
      else
        if proc_method = proc_method_S_0029 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00043 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        cast_expr_00044 <= (others => '0');
      else
        if proc_method = proc_method_S_0030 then
          cast_expr_00044 <= tmp_0062;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00045 <= (others => '0');
      else
        if proc_method = proc_method_S_0031 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00045 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00046 <= (others => '0');
      else
        if proc_method = proc_method_S_0032 then
          binary_expr_00046 <= tmp_0063;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        cast_expr_00047 <= (others => '0');
      else
        if proc_method = proc_method_S_0032 then
          cast_expr_00047 <= tmp_0064;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00048 <= (others => '0');
      else
        if proc_method = proc_method_S_0034 then
          binary_expr_00048 <= tmp_0068;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_warpedX_0049 <= (others => '0');
      else
        if proc_method = proc_method_S_0034 then
          proc_warpedX_0049 <= binary_expr_00050;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00050 <= (others => '0');
      else
        if proc_method = proc_method_S_0032 then
          binary_expr_00050 <= tmp_0065;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_warpedY_0051 <= (others => '0');
      else
        if proc_method = proc_method_S_0039 then
          proc_warpedY_0051 <= binary_expr_00052;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00052 <= (others => '0');
      else
        if proc_method = proc_method_S_0038 then
          binary_expr_00052 <= tmp_0071;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00053 <= '0';
      else
        if proc_method = proc_method_S_0035 then
          binary_expr_00053 <= tmp_0069;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00054 <= (others => '0');
      else
        if proc_method = proc_method_S_0032 then
          binary_expr_00054 <= tmp_0066;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00055 <= '0';
      else
        if proc_method = proc_method_S_0035 then
          binary_expr_00055 <= tmp_0070;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00056 <= '0';
      else
        if proc_method = proc_method_S_0038 then
          binary_expr_00056 <= tmp_0072;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00057 <= '0';
      else
        if proc_method = proc_method_S_0044 then
          binary_expr_00057 <= tmp_0073;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00058 <= '0';
      else
        if proc_method = proc_method_S_0045 then
          binary_expr_00058 <= tmp_0075;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00059 <= (others => '0');
      else
        if proc_method = proc_method_S_0032 then
          binary_expr_00059 <= tmp_0067;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00060 <= '0';
      else
        if proc_method = proc_method_S_0044 then
          binary_expr_00060 <= tmp_0074;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00061 <= '0';
      else
        if proc_method = proc_method_S_0048 then
          binary_expr_00061 <= tmp_0076;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_indexWarpedPixel_0062 <= (others => '0');
      else
        if proc_method = proc_method_S_0055 then
          proc_indexWarpedPixel_0062 <= binary_expr_00064;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00063 <= (others => '0');
      else
        if proc_method = proc_method_S_0053 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00063 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00064 <= (others => '0');
      else
        if proc_method = proc_method_S_0054 then
          binary_expr_00064 <= tmp_0077;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_pixel_0065 <= X"00000000";
      else
        if proc_method = proc_method_S_0054 then
          proc_pixel_0065 <= X"00000000";
        elsif proc_method = proc_method_S_0081 then
          proc_pixel_0065 <= binary_expr_00087;
        elsif proc_method = proc_method_S_0084 then
          proc_pixel_0065 <= array_access_00088;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_warpedXfrac_0066 <= (others => '0');
      else
        if proc_method = proc_method_S_0060 then
          proc_warpedXfrac_0066 <= binary_expr_00067;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00067 <= (others => '0');
      else
        if proc_method = proc_method_S_0059 then
          binary_expr_00067 <= tmp_0078;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_warpedYfrac_0068 <= (others => '0');
      else
        if proc_method = proc_method_S_0060 then
          proc_warpedYfrac_0068 <= binary_expr_00069;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00069 <= (others => '0');
      else
        if proc_method = proc_method_S_0059 then
          binary_expr_00069 <= tmp_0079;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_pixel00_0070 <= (others => '0');
      else
        if proc_method = proc_method_S_0064 then
          proc_pixel00_0070 <= array_access_00071;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00071 <= (others => '0');
      else
        if proc_method = proc_method_S_0063 and proc_method_delay = 2 then
          array_access_00071 <= class_inData_0002_dout_b;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_pixel01_0072 <= (others => '0');
      else
        if proc_method = proc_method_S_0067 then
          proc_pixel01_0072 <= array_access_00074;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00073 <= (others => '0');
      else
        if proc_method = proc_method_S_0064 then
          binary_expr_00073 <= tmp_0080;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00074 <= (others => '0');
      else
        if proc_method = proc_method_S_0066 and proc_method_delay = 2 then
          array_access_00074 <= class_inData_0002_dout_b;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_pixel10_0075 <= (others => '0');
      else
        if proc_method = proc_method_S_0070 then
          proc_pixel10_0075 <= array_access_00077;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00076 <= (others => '0');
      else
        if proc_method = proc_method_S_0067 then
          binary_expr_00076 <= tmp_0081;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00077 <= (others => '0');
      else
        if proc_method = proc_method_S_0069 and proc_method_delay = 2 then
          array_access_00077 <= class_inData_0002_dout_b;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00078 <= (others => '0');
      else
        if proc_method = proc_method_S_0070 then
          binary_expr_00078 <= tmp_0082;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00079 <= (others => '0');
      else
        if proc_method = proc_method_S_0072 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00079 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00080 <= (others => '0');
      else
        if proc_method = proc_method_S_0073 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00080 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00081 <= (others => '0');
      else
        if proc_method = proc_method_S_0074 then
          binary_expr_00081 <= tmp_0083;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00082 <= (others => '0');
      else
        if proc_method = proc_method_S_0074 then
          binary_expr_00082 <= tmp_0084;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00083 <= (others => '0');
      else
        if proc_method = proc_method_S_0076 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00083 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00084 <= (others => '0');
      else
        if proc_method = proc_method_S_0077 then
          binary_expr_00084 <= tmp_0085;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00085 <= (others => '0');
      else
        if proc_method = proc_method_S_0078 and proc_method_delay >= 1 and u_synthesijer_mul32_proc_valid = '1' then
          binary_expr_00085 <= u_synthesijer_mul32_proc_result;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00086 <= (others => '0');
      else
        if proc_method = proc_method_S_0079 then
          binary_expr_00086 <= tmp_0086;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00087 <= (others => '0');
      else
        if proc_method = proc_method_S_0080 then
          binary_expr_00087 <= tmp_0087;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00088 <= (others => '0');
      else
        if proc_method = proc_method_S_0083 and proc_method_delay = 2 then
          array_access_00088 <= class_inData_0002_dout_b;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        proc_diff_0089 <= (others => '0');
      else
        if proc_method = proc_method_S_0091 then
          proc_diff_0089 <= binary_expr_00092;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        array_access_00090 <= (others => '0');
      else
        if proc_method = proc_method_S_0088 and proc_method_delay = 2 then
          array_access_00090 <= class_cmpData_0004_dout_b;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        cast_expr_00091 <= (others => '0');
      else
        if proc_method = proc_method_S_0089 then
          cast_expr_00091 <= array_access_00090;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00092 <= (others => '0');
      else
        if proc_method = proc_method_S_0090 then
          binary_expr_00092 <= tmp_0088;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00093 <= '0';
      else
        if proc_method = proc_method_S_0092 then
          binary_expr_00093 <= tmp_0089;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00094 <= (others => '0');
      else
        if proc_method = proc_method_S_0095 then
          binary_expr_00094 <= tmp_0090;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        binary_expr_00095 <= (others => '0');
      else
        if proc_method = proc_method_S_0098 then
          binary_expr_00095 <= tmp_0091;
        end if;
      end if;
    end if;
  end process;

  clear_req_flag <= tmp_0012;

  proc_req_flag <= tmp_0013;

  clear_req_flag_edge <= tmp_0015;

  u_synthesijer_mul32_clear_clk <= clk_sig;

  u_synthesijer_mul32_clear_reset <= reset_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        u_synthesijer_mul32_clear_a <= (others => '0');
      else
        if clear_method = clear_method_S_0016 and clear_method_delay = 0 then
          u_synthesijer_mul32_clear_a <= clear_i_0014;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        u_synthesijer_mul32_clear_b <= (others => '0');
      else
        if clear_method = clear_method_S_0016 and clear_method_delay = 0 then
          u_synthesijer_mul32_clear_b <= class_width_0000;
        end if;
      end if;
    end if;
  end process;

  proc_req_flag_edge <= tmp_0032;

  u_synthesijer_mul32_proc_clk <= clk_sig;

  u_synthesijer_mul32_proc_reset <= reset_sig;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        u_synthesijer_mul32_proc_a <= (others => '0');
      else
        if proc_method = proc_method_S_0017 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= proc_i_0024;
        elsif proc_method = proc_method_S_0021 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= cast_expr_00034;
        elsif proc_method = proc_method_S_0023 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= cast_expr_00036;
        elsif proc_method = proc_method_S_0029 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= cast_expr_00042;
        elsif proc_method = proc_method_S_0031 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= cast_expr_00044;
        elsif proc_method = proc_method_S_0053 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= proc_warpedY_0051;
        elsif proc_method = proc_method_S_0072 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= proc_pixel00_0070;
        elsif proc_method = proc_method_S_0073 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= proc_pixel01_0072;
        elsif proc_method = proc_method_S_0076 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= proc_pixel00_0070;
        elsif proc_method = proc_method_S_0078 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_a <= proc_pixel10_0075;
        end if;
      end if;
    end if;
  end process;

  process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        u_synthesijer_mul32_proc_b <= (others => '0');
      else
        if proc_method = proc_method_S_0017 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= class_width_0000;
        elsif proc_method = proc_method_S_0021 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= proc_i_0024;
        elsif proc_method = proc_method_S_0023 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= proc_j_0027;
        elsif proc_method = proc_method_S_0029 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= proc_i_0024;
        elsif proc_method = proc_method_S_0031 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= proc_j_0027;
        elsif proc_method = proc_method_S_0053 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= class_width_0000;
        elsif proc_method = proc_method_S_0072 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= binary_expr_00078;
        elsif proc_method = proc_method_S_0073 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= proc_warpedXfrac_0066;
        elsif proc_method = proc_method_S_0076 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= binary_expr_00082;
        elsif proc_method = proc_method_S_0078 and proc_method_delay = 0 then
          u_synthesijer_mul32_proc_b <= proc_warpedYfrac_0068;
        end if;
      end if;
    end if;
  end process;


  inst_class_inData_0002 : dualportram
  generic map(
    WIDTH => 32,
    DEPTH => 15,
    WORDS => 32768
  )
  port map(
    clk => class_inData_0002_clk,
    reset => class_inData_0002_reset,
    length => class_inData_0002_length,
    address => class_inData_0002_address,
    din => class_inData_0002_din,
    dout => class_inData_0002_dout,
    we => class_inData_0002_we,
    oe => class_inData_0002_oe,
    address_b => class_inData_0002_address_b,
    din_b => class_inData_0002_din_b,
    dout_b => class_inData_0002_dout_b,
    we_b => class_inData_0002_we_b,
    oe_b => class_inData_0002_oe_b
  );

  inst_class_outData_0003 : dualportram
  generic map(
    WIDTH => 32,
    DEPTH => 15,
    WORDS => 32768
  )
  port map(
    clk => class_outData_0003_clk,
    reset => class_outData_0003_reset,
    length => class_outData_0003_length,
    address => class_outData_0003_address,
    din => class_outData_0003_din,
    dout => class_outData_0003_dout,
    we => class_outData_0003_we,
    oe => class_outData_0003_oe,
    address_b => class_outData_0003_address_b,
    din_b => class_outData_0003_din_b,
    dout_b => class_outData_0003_dout_b,
    we_b => class_outData_0003_we_b,
    oe_b => class_outData_0003_oe_b
  );

  inst_class_cmpData_0004 : dualportram
  generic map(
    WIDTH => 32,
    DEPTH => 15,
    WORDS => 32768
  )
  port map(
    clk => class_cmpData_0004_clk,
    reset => class_cmpData_0004_reset,
    length => class_cmpData_0004_length,
    address => class_cmpData_0004_address,
    din => class_cmpData_0004_din,
    dout => class_cmpData_0004_dout,
    we => class_cmpData_0004_we,
    oe => class_cmpData_0004_oe,
    address_b => class_cmpData_0004_address_b,
    din_b => class_cmpData_0004_din_b,
    dout_b => class_cmpData_0004_dout_b,
    we_b => class_cmpData_0004_we_b,
    oe_b => class_cmpData_0004_oe_b
  );

  inst_u_synthesijer_mul32_clear : synthesijer_mul32
  port map(
    clk => u_synthesijer_mul32_clear_clk,
    reset => u_synthesijer_mul32_clear_reset,
    a => u_synthesijer_mul32_clear_a,
    b => u_synthesijer_mul32_clear_b,
    nd => u_synthesijer_mul32_clear_nd,
    result => u_synthesijer_mul32_clear_result,
    valid => u_synthesijer_mul32_clear_valid
  );

  inst_u_synthesijer_mul32_proc : synthesijer_mul32
  port map(
    clk => u_synthesijer_mul32_proc_clk,
    reset => u_synthesijer_mul32_proc_reset,
    a => u_synthesijer_mul32_proc_a,
    b => u_synthesijer_mul32_proc_b,
    nd => u_synthesijer_mul32_proc_nd,
    result => u_synthesijer_mul32_proc_result,
    valid => u_synthesijer_mul32_proc_valid
  );


end RTL;
