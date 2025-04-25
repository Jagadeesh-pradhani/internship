# DFT Internship Repository

This repository contains the design and verification flow for our DFT (Design for Test) project. The repository is structured to support multiple stages of the design flow—from RTL synthesis through timing analysis and various DFT (Design for Test) tasks.

## Repository Structure
```
DFT/ 
├── dofiles/ 
│ ├── scan_inserstion.do # DO file for scan insertion flow 
│ └── pattern.do # DO file for test pattern generation 
│
├── inputs/ 
│ ├── LEF/ # Library Exchange Format files for physical design 
│ ├── LIB/ # Standard cell libraries used in synthesis 
│ │ └── Nangate.lib # Nangate library file 
│ ├── MDT/ # MDT (Master Delay Table) files 
│ │ └── Nangate.mdt # Nangate MDT file 
│ ├── RTL/ # RTL source files for synthesis 
│ │ └── mcrb.v # Verilog RTL source 
│ └── SDC/ # Synopsys Design Constraints 
│   └── mcrb_constraints.v # Constraint file for timing analysis 
│
├── outputs/ 
│ └── mcrb_OUTPUTS/ 
│  ├── genus_outputs.v # Netlist outputs from Genus synthesis 
│  ├── tempus_outputs.v # Timing analysis results from Tempus 
│  └── tessent_outputs.v # DFT and fault simulation outputs from Tessent 
│
├── reports/ 
│ └── mcrb_REPORTS/ 
│  ├── genus_reports.v # Synthesis reports from Genus 
│  ├── tempus_reports.v # Timing reports from Tempus 
│  └── tessent_reports.v # DFT and test reports from Tessent 
│
├── run/ # Directory for run-time scripts or intermediate files 
│
├── schematics/ 
│ └── schematics.pdf # Schematic diagrams of the design 
│
├── scripts/ 
│ ├── run_genus.tcl # TCL script for invoking Genus 
│ └── run_tempus.tcl # TCL script for invoking Tempus
│ └── run_yosys.tcl # TCL for yosys 
│
├── tutorial/ # Tutorial or reference materials for the flow 
│
├── commands.sh # Shell script with common command-line instructions 
└── ReadME.md # This file
```

## Prerequisites
- Cadence Genus and Tempus installed and licensed
- Mentor graphics Tessent installed and licensed
- Valid library files (.lib, .lef, .mdt) in project directories
- UNIX/Linux environment (RHEL)

---

## Design Flow Overview

This repository implements a comprehensive flow that involves three main tools:

### Genus: Synthesis (RTL to Netlist)
- **Purpose:** Transforms RTL code (Verilog) into a gate-level netlist.
- **Input:** Verilog RTL from the `inputs/RTL` directory.
- **Output:** Synthesis outputs and reports stored in `outputs/mcrb_OUTPUTS/genus_outputs.v` and `reports/mcrb_REPORTS/genus_reports.v`.
- **Script:** The synthesis flow is executed via the TCL script `scripts/run_genus.tcl`.

### Tessent: DFT and Test Implementation
- **Purpose:** Handles various DFT tasks including scan insertion, ATPG (Automatic Test Pattern Generation), Memory BIST, boundary scan, and fault simulation.
- **Input:** Processed netlist and scan design files (supported by DO files in the `dofiles/` directory).
- **Output:** DFT test outputs and simulation results stored in `outputs/mcrb_OUTPUTS/tessent_outputs.v` and corresponding reports in `reports/mcrb_REPORTS/tessent_reports.v`.
- **Key Tasks:** 
  - Scan insertion for adding test features to the design.
  - Fault simulation to validate test coverage.

### Tempus: Timing Analysis
- **Purpose:** Performs timing analysis and static timing checks on the design.
- **Input:** Netlist and design constraints (from `inputs/SDC`).
- **Output:** Timing analysis outputs and reports in `outputs/mcrb_OUTPUTS/tempus_outputs.v` and `reports/mcrb_REPORTS/tempus_reports.v`.
- **Script:** Timing analysis is initiated through the TCL script `scripts/run_tempus.tcl`.

## Running the Flows

1. **Synthesis with Genus:**
   - Prepare your RTL sources in the `inputs/RTL` directory.
   - Run the synthesis flow using:
     ```bash
     genus -f ../scripts/run_genus_synth.tcl
     ```
   - Check outputs in `outputs/mcrb_OUTPUTS` and reports in `reports/mcrb_REPORTS/genus_reports.v`.

2. **DFT and Test with Tessent:**
   - Verify that scan insertion DO files (`dofiles/scan_inserstion.do`) and test pattern files (`dofiles/pattern.do`) are correctly set up.
   - Execute the DFT flow 
   ```bash
   tessent -shell -dofile ../dofiles/simple_insertion.do -logfile log -replace
   ```


3. **Timing Analysis with Tempus:**
   - Ensure that design constraints are updated in `inputs/SDC/mcrb_constraints.v`.
   - Run timing analysis using:
    ```bash
    tempus
    source  ../scripts/run_tempus.tcl
    ```
   - Examine timing results in `outputs/mcrb_OUTPUTS/tempus_outputs.v` and reports in `reports/mcrb_REPORTS/tempus_reports.v`.

## Additional Information

- **Tutorial:** The `tutorial/` directory contains detailed guides and reference materials to help you understand the design flow and tools.
- **Schematics:** Refer to `schematics/schematics.pdf` for design diagrams and a high-level overview of the architecture.
- **Commands:** The `commands.sh` file includes frequently used command-line operations to simplify running various parts of the flow.

# Troubleshooting Common Issues
1. File Not Found Errors:
    - Verify paths in run.tcl match your directory structure
    - Check case sensitivity of filenames

2. Missing Constraints:
    - Ensure constraints.sdc exists in RTL/
    - Validate clock definitions in SDC file

3. Library Compatibility:
    - Confirm .lib, .lef and .mdt versions match your base version
    - Check library corner (slow.lib vs fast.lib)

4. Undefined Modules:
    - Verify all submodules are included in RTL/
    - Check TOP_MODULE name matches Verilog

5. Tessent test_Nangate.mdt has some commented models, need to uncomment them.

# Support:
For issues contact: [Jagadeesh Pradhani] jagadeesh.d.pradhani@gmail.com <br>
