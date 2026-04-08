# quartic-rtl2gds
RTL to GDSII implementation of **Y = 4ˣ** on SAED 32nm RVT standard cells using Synopsys VLSI toolchain.

## 1. Overview

- **Function:** Y = 4^X, where X is a 2-bit unsigned integer (outputs: 1, 4, 16, 64)
- **Implementation:** Two-stage pipeline — input register followed by a barrel shift to compute 4^X
- **PDK:** SAED 32nm RVT (`saed32rvt_tt0p78vn40c`)
- **Target clock:** 500 MHz (2 ns period)
- **Flow:** VCS/Verdi → Design Compiler → IC Compiler II → PrimeTime

## 2. Results

| Metric | Value |
|---|---|
| Clock Frequency | 500 MHz |
| Setup Slack (WNS, post-route) | 1.62 ns |
| Cell Area | 50.32 μm² |
| Total Area (with interconnect) | 52.94 μm² |
| Total Power (ICC2, post-route) | 0.139 mW |
| Dynamic Power (DC synthesis) | 11.54 μW |
| Routed Wire Length | 98 μm |
| DRC Violations | 0 |
| STA Violations (both corners) | 0 |

## 3. RTL

```verilog
// pow4.v — Y = 4^X, X is 2-bit unsigned
module pow4 (
    input  wire       clk,
    input  wire [1:0] X,
    output reg  [6:0] Y
);
    reg [1:0] X_reg;
    always @(posedge clk) X_reg <= X;
    always @(posedge clk) Y <= 7'd1 << ({1'b0, X_reg} << 1);
endmodule
```

### Simulation
All 4 test cases pass (`fail_cnt = 0`).

<img width="2005" height="955" alt="waveform" src="https://github.com/user-attachments/assets/b78a57f8-fad1-43ae-82cd-9c79c92aa0ed" />

*GTKWave: X = 00, 01, 10, 11 → Y = 01, 04, 10, 40 (hex)*

## 4. Logic Synthesis
**Tool:** Synopsys Design Compiler  
**Library:** `saed32rvt_tt0p78vn40c.db`  
**Constraints:** 2 ns clock period, 0.1 ns setup / 0.05 ns hold uncertainty, 0.2 ns I/O delays  
**Note:** `AND` cells set to `dont_use` to steer synthesis toward NOR/NAND/INV primitives.

<img width="2674" height="1070" alt="DC" src="https://github.com/user-attachments/assets/324fc042-3ad7-415c-87c3-9d3e1ef5cdf9" />

## 5. Physical Design
**Tool:** IC Compiler II

### Floorplan
L-shaped die (`side_length {8 8 4 4 8 8}`), 0.5 μm core offset. X/Y ports constrained to side 6, clock to side 2.

<img width="500" height="500" alt="Floorplan" src="https://github.com/user-attachments/assets/b48aa4c5-3329-465e-84e6-4ea8894778ad" />

| Parameter | Value |
|---|---|
| Setup WNS | 1.62 ns |
| Routing Violations | None |
| Cell Area | 50.32 μm² |

### Power Planning
PG ring on M7/M8 (0.4 μm width, 0.3 μm spacing). Mesh on M6/M7/M8 at 5 μm pitch with interleaving spacing. Standard-cell rails on M1 (0.06 μm width).

<img width="500" height="500" alt="Powerplan" src="https://github.com/user-attachments/assets/177b7469-7b1e-46c2-9bff-8333bc25ee3e" />

### Placement
AND cells retained as `dont_use` consistent with synthesis. Zero legality violations post-placement.

<img width="500" height="500" alt="Placement" src="https://github.com/user-attachments/assets/1974b4f6-9652-435f-aded-cc3217492b94" />

| Parameter | Value |
|---|---|
| Setup WNS | 1.62 ns |
| Hold WNS | 0.06 ns |
| Legality Violations | 0 |
| Connectivity | Fully connected |

### Clock Tree Synthesis
6 clock sinks. No repeaters inserted. Global skew: 0.00 ns, max latency: 0.00 ns.

<img width="500" height="500" alt="CTS" src="https://github.com/user-attachments/assets/748463cb-12da-4efe-8225-1ab834a982bc" />

### Routing
No open nets. No DRC violations. Total routed wire length: 98 μm.

<img width="500" height="500" alt="Routing" src="https://github.com/user-attachments/assets/8887f069-d71d-4967-9fe6-76f977e565be" />

## 6. Static Timing Analysis
**Tool:** Synopsys PrimeTime  
Parasitics back-annotated from SPEF at 125°C (late and early corners).

| Corner | Library | Setup | Hold |
|---|---|---|---|
| Late (Cmax / SS) | `saed32rvt_ss0p7vn40c.db` | 0 violations | 0 violations |
| Early (Cmin / FF) | `saed32rvt_ff1p16v125c.db` | 0 violations | 0 violations |

<img width="2880" height="1800" alt="PT_schematic" src="https://github.com/user-attachments/assets/0b785a37-e3c5-4262-a6d2-965fe3ccde0e" />

***

Check out the report [here](https://drive.google.com/file/d/1gZKMOM7ABVKWsQFsiBXRFsng481yPKYs/).
