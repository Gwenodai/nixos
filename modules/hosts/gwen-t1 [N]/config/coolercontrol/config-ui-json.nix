{
  ...
}: {
  # --- NIXOS MODULE ---
  flake.modules.nixos.gwen-t1 = {
    config,
    lib,
    ...
  }: {
    config = lib.mkIf config.programs.coolercontrol.enable (
      let
        id = config.programs.coolercontrol.id;
      in {
        environment.etc = {
          "coolercontrol/config-ui.json" = {
            mode = "0644";
            # syntax: json
            text = ''
              {
                "devices": [
                  "${id.devices.cust_sens_dev}",
                  "${id.devices.cpu}",
                  "${id.devices.gpu}",
                  "${id.devices.it8696}",
                  "${id.devices.nvme_970evo}",
                  "${id.devices.nvme_990pro}",
                  "${id.devices.acpitz}",
                  "${id.devices.gigabyte_wmi}"
                ],
                "deviceSettings": [
                  {
                    "names": [
                      "sensor2",
                      "sensor1"
                    ],
                    "sensorAndChannelSettings": [
                      {
                        "userName": "NVME",
                        "viewType": "Dashboard",
                        "channelDashboard": {
                          "uid": "fb970dc1-d3a9-4e34-addd-6dbc4bfd6e76",
                          "name": "sensor2",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.cust_sens_dev}",
                              "channelName": "sensor2"
                            }
                          ]
                        }
                      },
                      {
                        "userName": "System",
                        "viewType": "Dashboard",
                        "channelDashboard": {
                          "uid": "66241844-e73b-400e-bc41-373dcd805d48",
                          "name": "sensor1",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.cust_sens_dev}",
                              "channelName": "sensor1"
                            }
                          ]
                        }
                      }
                    ]
                  },
                  {
                    "names": [
                      "temp1",
                      "CPU Load",
                      "power0"
                    ],
                    "sensorAndChannelSettings": [
                      {
                        "userColor": "#d10007",
                        "userName": "CPU Temp",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "80074887-b647-44e2-8f7c-6a699634287c",
                          "name": "CPU Temp",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.cpu}",
                              "channelName": "temp1"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#00ff22",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "1e780744-bdf0-4902-9b25-9c223762c2a2",
                          "name": "CPU Load",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.cpu}",
                              "channelName": "CPU Load"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#e817b0",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "562621ea-f9bb-4c49-b229-76b304664655",
                          "name": "CPU Power",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": false,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 170,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.cpu}",
                              "channelName": "power0"
                            }
                          ]
                        }
                      }
                    ]
                  },
                  {
                    "names": [
                      "temp2",
                      "GPU Load",
                      "freq1",
                      "freq2",
                      "power1_average",
                      "fan1"
                    ],
                    "sensorAndChannelSettings": [
                      {
                        "userColor": "#d15b00",
                        "userName": "GPU Temp",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "13ca570f-47e8-4e5b-a4e5-a5daafc2cb1e",
                          "name": "GPU Temp",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.gpu}",
                              "channelName": "temp2"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#a1ff85",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "8f2bf40b-d014-400b-965e-b202c370644a",
                          "name": "GPU Load",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.gpu}",
                              "channelName": "GPU Load"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#fbff00",
                        "userName": "GPU Core",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "db2ae2b5-0943-42ca-a6c1-eadd45466474",
                          "name": "GPU Core",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": false,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 3300,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.gpu}",
                              "channelName": "freq1"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#f9ffad",
                        "userName": "GPU Mem",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "c2db22f6-3ccc-4293-95f1-f557bc6e9a6b",
                          "name": "GPU Mem",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": false,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 3000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.gpu}",
                              "channelName": "freq2"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#8617e8",
                        "userName": "GPU Power",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "d23f4936-a5e8-4f4b-8ea8-0ac2635f2e98",
                          "name": "GPU Power",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": false,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 400,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.gpu}",
                              "channelName": "power1_average"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#0073ff",
                        "userName": "GPU Fans",
                        "viewType": "Dashboard",
                        "channelDashboard": {
                          "uid": "ab89d529-be3a-4a94-8ec4-af98b4a290ae",
                          "name": "GPU Fans",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.gpu}",
                              "channelName": "fan1"
                            }
                          ]
                        }
                      }
                    ]
                  },
                  {
                    "names": [
                      "fan1",
                      "fan3",
                      "fan5"
                    ],
                    "sensorAndChannelSettings": [
                      {
                        "userColor": "#00d4ff",
                        "userName": "Radiator Fans",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "9ff08d6e-c14b-49ee-97cf-43138646b629",
                          "name": "Fan1",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 3000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.it8696}",
                              "channelName": "fan1"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#0000ff",
                        "userName": "NVME Fan",
                        "viewType": "Dashboard",
                        "channelDashboard": {
                          "uid": "2ba71442-98fb-49bc-ac18-e5214561a26e",
                          "name": "Fan3",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 3600,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.it8696}",
                              "channelName": "fan3"
                            }
                          ]
                        }
                      },
                      {
                        "userColor": "#ffffff",
                        "userName": "CPU Pump",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "d2db76aa-0ac5-4d2c-bfe2-a746d72bc4bf",
                          "name": "Fan5",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 300,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.it8696}",
                              "channelName": "fan5"
                            }
                          ]
                        }
                      }
                    ]
                  },
                  {
                    "names": [
                      "temp1"
                    ],
                    "sensorAndChannelSettings": [
                      {
                        "userName": "970 EVO",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "4a1cbd33-8eef-445e-9a66-bb6c63cbc6a8",
                          "name": "Composite",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 300,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.nvme_970evo}",
                              "channelName": "temp1"
                            }
                          ]
                        }
                      }
                    ]
                  },
                  {
                    "names": [
                      "temp1"
                    ],
                    "sensorAndChannelSettings": [
                      {
                        "userName": "990 PRO",
                        "viewType": "Control",
                        "channelDashboard": {
                          "uid": "fb6ac966-68b8-44c9-8069-ff5234bbdb83",
                          "name": "Composite",
                          "chartType": "Time Chart",
                          "timeRangeSeconds": 300,
                          "autoScaleDegree": false,
                          "autoScaleFrequency": true,
                          "autoScaleWatts": true,
                          "degreeMax": 100,
                          "degreeMin": 0,
                          "frequencyMax": 10000,
                          "frequencyMin": 0,
                          "wattsMax": 800,
                          "wattsMin": 0,
                          "dataTypes": [],
                          "deviceChannelNames": [
                            {
                              "deviceUID": "${id.devices.nvme_990pro}",
                              "channelName": "temp1"
                            }
                          ]
                        }
                      }
                    ]
                  },
                  {
                    "names": [],
                    "sensorAndChannelSettings": []
                  },
                  {
                    "names": [],
                    "sensorAndChannelSettings": []
                  }
                ],
                "dashboards": [
                  {
                    "uid": "${id.dash.system}",
                    "name": "System",
                    "chartType": "Time Chart",
                    "timeRangeSeconds": 900,
                    "autoScaleDegree": false,
                    "autoScaleFrequency": false,
                    "autoScaleWatts": false,
                    "degreeMax": 100,
                    "degreeMin": 0,
                    "frequencyMax": 3300,
                    "frequencyMin": 0,
                    "wattsMax": 400,
                    "wattsMin": 0,
                    "dataTypes": [
                      "Load",
                      "Temp",
                      "Duty",
                      "Freq",
                      "Watts"
                    ],
                    "deviceChannelNames": [
                      {
                        "deviceUID": "${id.devices.cust_sens_dev}",
                        "channelName": "sensor2"
                      },
                      {
                        "deviceUID": "${id.devices.cpu}",
                        "channelName": "temp1"
                      },
                      {
                        "deviceUID": "${id.devices.cpu}",
                        "channelName": "power0"
                      },
                      {
                        "deviceUID": "${id.devices.cpu}",
                        "channelName": "CPU Load"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "temp2"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "freq1"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "freq2"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "power1_average"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "GPU Load"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "fan1"
                      },
                      {
                        "deviceUID": "${id.devices.it8696}",
                        "channelName": "fan1"
                      },
                      {
                        "deviceUID": "${id.devices.it8696}",
                        "channelName": "fan3"
                      }
                    ]
                  },
                  {
                    "uid": "${id.dash.temps}",
                    "name": "Temps",
                    "chartType": "Time Chart",
                    "timeRangeSeconds": 900,
                    "autoScaleDegree": false,
                    "autoScaleFrequency": false,
                    "autoScaleWatts": false,
                    "degreeMax": 100,
                    "degreeMin": 0,
                    "frequencyMax": 3300,
                    "frequencyMin": 0,
                    "wattsMax": 400,
                    "wattsMin": 0,
                    "dataTypes": [
                      "Temp",
                      "Duty"
                    ],
                    "deviceChannelNames": [
                      {
                        "deviceUID": "${id.devices.cust_sens_dev}",
                        "channelName": "sensor2"
                      },
                      {
                        "deviceUID": "${id.devices.cpu}",
                        "channelName": "temp1"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "temp2"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "fan1"
                      },
                      {
                        "deviceUID": "${id.devices.it8696}",
                        "channelName": "fan1"
                      },
                      {
                        "deviceUID": "${id.devices.it8696}",
                        "channelName": "fan3"
                      }
                    ]
                  },
                  {
                    "uid": "${id.dash.cpu}",
                    "name": "CPU",
                    "chartType": "Time Chart",
                    "timeRangeSeconds": 900,
                    "autoScaleDegree": false,
                    "autoScaleFrequency": false,
                    "autoScaleWatts": false,
                    "degreeMax": 100,
                    "degreeMin": 0,
                    "frequencyMax": 3300,
                    "frequencyMin": 0,
                    "wattsMax": 170,
                    "wattsMin": 0,
                    "dataTypes": [
                      "Watts",
                      "Temp",
                      "Duty",
                      "Load"
                    ],
                    "deviceChannelNames": [
                      {
                        "deviceUID": "${id.devices.cpu}",
                        "channelName": "power0"
                      },
                      {
                        "deviceUID": "${id.devices.cpu}",
                        "channelName": "CPU Load"
                      },
                      {
                        "deviceUID": "${id.devices.it8696}",
                        "channelName": "fan1"
                      },
                      {
                        "deviceUID": "${id.devices.cpu}",
                        "channelName": "temp1"
                      }
                    ]
                  },
                  {
                    "uid": "${id.dash.gpu}",
                    "name": "GPU",
                    "chartType": "Time Chart",
                    "timeRangeSeconds": 900,
                    "autoScaleDegree": false,
                    "autoScaleFrequency": false,
                    "autoScaleWatts": false,
                    "degreeMax": 100,
                    "degreeMin": 0,
                    "frequencyMax": 3300,
                    "frequencyMin": 0,
                    "wattsMax": 400,
                    "wattsMin": 0,
                    "dataTypes": [
                      "Temp",
                      "Duty",
                      "Load",
                      "Freq",
                      "Watts"
                    ],
                    "deviceChannelNames": [
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "temp2"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "freq1"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "freq2"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "power1_average"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "GPU Load"
                      },
                      {
                        "deviceUID": "${id.devices.gpu}",
                        "channelName": "fan1"
                      },
                      {
                        "deviceUID": "${id.devices.it8696}",
                        "channelName": "fan1"
                      }
                    ]
                  }
                ],
                "homeDashboard": "${id.dash.system}",
                "themeMode": "dark",
                "chartLineScale": 1.5,
                "time24": false,
                "menuOrder": [
                  {
                    "id": "dashboards",
                    "children": [
                      "${id.dash.system}",
                      "${id.dash.temps}",
                      "${id.dash.cpu}",
                      "${id.dash.gpu}"
                    ]
                  },
                  {
                    "id": "alerts",
                    "children": [
                      "${id.alerts.cpu}",
                      "${id.alerts.gpu}"
                    ]
                  },
                  {
                    "id": "${id.devices.cust_sens_dev}",
                    "children": [
                      "${id.devices.cust_sens_dev}${id.sensors.system}",
                      "${id.devices.cust_sens_dev}${id.sensors.nvme}"
                    ]
                  },
                  {
                    "id": "${id.devices.cpu}",
                    "children": [
                      "${id.devices.cpu}_temp1",
                      "${id.devices.cpu}_power0",
                      "${id.devices.cpu}_CPU Load"
                    ]
                  },
                  {
                    "id": "${id.devices.gpu}",
                    "children": [
                      "${id.devices.gpu}_temp2",
                      "${id.devices.gpu}_freq1",
                      "${id.devices.gpu}_freq2",
                      "${id.devices.gpu}_power1_average",
                      "${id.devices.gpu}_GPU Load",
                      "${id.devices.gpu}_fan1"
                    ]
                  },
                  {
                    "id": "${id.devices.it8696}",
                    "children": [
                      "${id.devices.it8696}_fan1",
                      "${id.devices.it8696}_fan3",
                      "${id.devices.it8696}_fan5"
                    ]
                  },
                  {
                    "id": "${id.devices.nvme_990pro}",
                    "children": [
                      "${id.devices.nvme_990pro}_temp1"
                    ]
                  },
                  {
                    "id": "${id.devices.nvme_970evo}",
                    "children": [
                      "${id.devices.nvme_970evo}_temp1"
                    ]
                  },
                  {
                    "id": "profiles",
                    "children": [
                      "${id.profiles.aio_fans}"
                    ]
                  },
                  {
                    "id": "functions",
                    "children": [
                      "${id.functions.exp_mov_avg}"
                    ]
                  },
                  {
                    "id": "modes",
                    "children": []
                  }
                ],
                "expandedMenuIds": [
                  "${id.devices.cust_sens_dev}",
                  "${id.devices.cpu}",
                  "${id.devices.acpitz}",
                  "${id.devices.gigabyte_wmi}",
                  "${id.devices.it8696}",
                  "${id.devices.cust_sens_dev}",
                  "${id.devices.cpu}",
                  "${id.devices.acpitz}",
                  "${id.devices.gigabyte_wmi}",
                  "${id.devices.it8696}",
                  "dashboards",
                  "${id.devices.cust_sens_dev}",
                  "${id.devices.cpu}",
                  "${id.devices.it8696}",
                  "${id.devices.gpu}",
                  "alerts"
                ],
                "pinnedIds": [],
                "collapsedMainMenu": false,
                "hideMenuCollapseIcon": false,
                "mainMenuWidthRem": 24,
                "frequencyPrecision": 1,
                "customTheme": {
                  "accent": "86 138 242",
                  "bgOne": "27 30 35",
                  "bgTwo": "44 49 60",
                  "borderOne": "138 149 170 0.25",
                  "textColor": "220 225 236",
                  "textColorSecondary": "138 149 170"
                },
                "entityColors": [],
                "showOnboarding": false
              }
            '';
          };
        };
      }
    );
  };
}