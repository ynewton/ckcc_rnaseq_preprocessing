#!/usr/bin/env cwl-runner

class: CommandLineTool
id: "ckcc_rnaseq_preprocessing tool"
label: "ckcc_rnaseq_preprocessing tool"
cwlVersion: cwl:draft-3
description: |
    A Docker container for the create map tool. See https://github.com/ucscHexmap/hexagram/tree/dev/.calc/docker/create_map for more information.
    ```
    Usage:
    # fetch CWL
    TODO
    $> dockstore tool cwl --entry quay.io/hexmap_ucsc/ckcc_rnaseq_preprocessing:1.0 > Dockstore.cwl
    # make a runtime JSON template and edit it (or use the content of sample_configs.json in this git repo)
    $> dockstore tool convert cwl2json --cwl Dockstore.cwl > Dockstore.json
    # run it locally with the Dockstore CLI
    $> dockstore tool launch --entry quay.io/hexmap_ucsc/ckcc_rnaseq_preprocessing:1.0 --json Dockstore.json
    ```

dct:creator:
  "@id": "http://orcid.org/0000-0002-6874-4335/"
  foaf:name: Yulia Newton
  foaf:mbox: "mailto:yulia.newton@gmail.com"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/hexmap_ucsc/ckcc_rnaseq_preprocessing:1.0"

hints:
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 4092
    outdirMin: 512000
    description: "the process requires at least 4G of RAM"

inputs:
  - id: "#input"
    type: File
    description: "input file to preprocess"
    inputBinding:
      position: 1

outputs:
  - id: "#output"
    type: File
    outputBinding:
      glob: output.tsv
    description: "An output matrix"

baseCommand: ["bash", "/usr/local/bin/ckcss_preprocessing.1.0.sh"]
