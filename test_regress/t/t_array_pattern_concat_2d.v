// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain.
// SPDX-FileCopyrightText: 2026 Nordic Semiconductor
// SPDX-License-Identifier: CC0-1.0

module sub #(
    parameter int N_OUT = 2,
    parameter int N_MODES = 2,
    parameter int P[N_OUT][N_MODES] = '{'{0, 0}, '{0, 0}}
);
  initial begin
    for (int o = 0; o < N_OUT; ++o) begin
      for (int m = 0; m < N_MODES; ++m) begin
        if (P[o][m] != 4 * o + m + 1) begin
          $write("%%Error: P[%0d][%0d]=%0d\n", o, m, P[o][m]);
          $stop;
        end
      end
    end
  end
endmodule

module t;
  // Array-valued members of a pattern for an array of arrays are whole
  // elements; they must not be flattened into the outer dimension
  localparam int N_OUT = 3;
  localparam int N_MODES = 4;
  localparam int A[N_MODES] = '{1, 2, 3, 4};
  localparam int B[N_MODES] = '{5, 6, 7, 8};
  localparam int C[N_MODES] = '{9, 10, 11, 12};
  localparam int M[N_OUT][N_MODES] = '{A, B, C};

  sub #(
      .N_OUT(N_OUT),
      .N_MODES(N_MODES),
      .P('{A, B, C})
  ) u_sub ();

  initial begin
    for (int o = 0; o < N_OUT; ++o) begin
      for (int m = 0; m < N_MODES; ++m) begin
        if (M[o][m] != 4 * o + m + 1) begin
          $write("%%Error: M[%0d][%0d]=%0d\n", o, m, M[o][m]);
          $stop;
        end
      end
    end
    $write("*-* All Finished *-*\n");
    $finish;
  end
endmodule
