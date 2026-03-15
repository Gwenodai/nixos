{ den, lib, ... }: {
  den.aspects.gwen-t1 = {
    includes = [ den.aspects.coolercontrol._.manualConfig._.ui ];
    coolercontrol-ui = {
      mode = "0644";
      text = lib.replaceStrings ["# syntax: json\n"] [""] ''
        # syntax: json
        {
          "devices": [
            "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
            "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
            "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
            "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
            "62431f8d94059dfab9adce10c509b9beefe28048c4674d7653baeafa72bdb286",
            "341fd0f49200232856b962da8ac0e1e21895610be9a6bc48415f27190b412931",
            "f42333b13a2853dfb8e516c576470622e74a4659bfffe7ca229f68733beae979",
            "9a64f7a5c7b59e073064f69eea496b0424b867bb35c843c28825f6d4a73aeba5"
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
                        "deviceUID": "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
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
                        "deviceUID": "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
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
                        "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
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
                        "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
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
                        "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
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
                        "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
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
                        "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
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
                        "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
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
                        "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
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
                        "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
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
                        "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
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
                        "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
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
                        "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
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
                        "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
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
                        "deviceUID": "62431f8d94059dfab9adce10c509b9beefe28048c4674d7653baeafa72bdb286",
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
                        "deviceUID": "341fd0f49200232856b962da8ac0e1e21895610be9a6bc48415f27190b412931",
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
              "uid": "1ac5dda5-9814-4c37-8566-38d24ddabe3f",
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
                  "deviceUID": "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
                  "channelName": "sensor2"
                },
                {
                  "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
                  "channelName": "temp1"
                },
                {
                  "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
                  "channelName": "power0"
                },
                {
                  "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
                  "channelName": "CPU Load"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "temp2"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "freq1"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "freq2"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "power1_average"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "GPU Load"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "fan1"
                },
                {
                  "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
                  "channelName": "fan1"
                },
                {
                  "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
                  "channelName": "fan3"
                }
              ]
            },
            {
              "uid": "8295db91-15d9-48dd-8295-439948b14511",
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
                  "deviceUID": "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
                  "channelName": "sensor2"
                },
                {
                  "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
                  "channelName": "temp1"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "temp2"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "fan1"
                },
                {
                  "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
                  "channelName": "fan1"
                },
                {
                  "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
                  "channelName": "fan3"
                }
              ]
            },
            {
              "uid": "a2ec2663-1755-4cd1-8552-4c906d98b21d",
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
                  "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
                  "channelName": "power0"
                },
                {
                  "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
                  "channelName": "CPU Load"
                },
                {
                  "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
                  "channelName": "fan1"
                },
                {
                  "deviceUID": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
                  "channelName": "temp1"
                }
              ]
            },
            {
              "uid": "0a1b47c5-9643-40c9-838c-b0d2a2de1530",
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
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "temp2"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "freq1"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "freq2"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "power1_average"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "GPU Load"
                },
                {
                  "deviceUID": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
                  "channelName": "fan1"
                },
                {
                  "deviceUID": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
                  "channelName": "fan1"
                }
              ]
            }
          ],
          "homeDashboard": "1ac5dda5-9814-4c37-8566-38d24ddabe3f",
          "themeMode": "dark",
          "chartLineScale": 1.5,
          "time24": false,
          "menuOrder": [
            {
              "id": "dashboards",
              "children": [
                "1ac5dda5-9814-4c37-8566-38d24ddabe3f",
                "8295db91-15d9-48dd-8295-439948b14511",
                "a2ec2663-1755-4cd1-8552-4c906d98b21d",
                "0a1b47c5-9643-40c9-838c-b0d2a2de1530"
              ]
            },
            {
              "id": "alerts",
              "children": [
                "2030ba2e-d583-4f5c-9118-00df549af2e7",
                "feac0f69-7051-4dba-aa01-5e7d2adff608"
              ]
            },
            {
              "id": "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
              "children": [
                "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076eesensor1",
                "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076eesensor2"
              ]
            },
            {
              "id": "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
              "children": [
                "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127_temp1",
                "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127_power0",
                "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127_CPU Load"
              ]
            },
            {
              "id": "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
              "children": [
                "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e_temp2",
                "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e_freq1",
                "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e_freq2",
                "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e_power1_average",
                "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e_GPU Load",
                "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e_fan1"
              ]
            },
            {
              "id": "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
              "children": [
                "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803_fan1",
                "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803_fan3",
                "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803_fan5"
              ]
            },
            {
              "id": "341fd0f49200232856b962da8ac0e1e21895610be9a6bc48415f27190b412931",
              "children": [
                "341fd0f49200232856b962da8ac0e1e21895610be9a6bc48415f27190b412931_temp1"
              ]
            },
            {
              "id": "62431f8d94059dfab9adce10c509b9beefe28048c4674d7653baeafa72bdb286",
              "children": [
                "62431f8d94059dfab9adce10c509b9beefe28048c4674d7653baeafa72bdb286_temp1"
              ]
            },
            {
              "id": "profiles",
              "children": [
                "37d94b73-b524-40a3-936a-56e73277722c"
              ]
            },
            {
              "id": "functions",
              "children": [
                "02ba5ea0-89cc-4085-808f-c3b1cc97963b"
              ]
            },
            {
              "id": "modes",
              "children": []
            }
          ],
          "expandedMenuIds": [
            "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
            "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
            "f42333b13a2853dfb8e516c576470622e74a4659bfffe7ca229f68733beae979",
            "9a64f7a5c7b59e073064f69eea496b0424b867bb35c843c28825f6d4a73aeba5",
            "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
            "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
            "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
            "f42333b13a2853dfb8e516c576470622e74a4659bfffe7ca229f68733beae979",
            "9a64f7a5c7b59e073064f69eea496b0424b867bb35c843c28825f6d4a73aeba5",
            "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
            "dashboards",
            "19e098e312e1b1b39163a343ea22b6ea17f18ec1a803ffe0ce44f5bacd6076ee",
            "3145e1a42801faf9cf948df8c705afb4859f084c10a7e7c5e4efecb1e0167127",
            "fa49f4645cba12961942172e0455e53675b4adbc2ed077a740863e40266e9803",
            "97910386cac9bfce54b2c224e4aaef42cd953440cb57f1ff5ff46ac183bf338e",
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