

# Register File Reference

| Address | Name | Size (bits) | Features | Description |
|---------|------|------|-------|-------------|
|0x0 | [OSC_CTRL](#OSC_CTRL) | 8 |  | Controls the Oscillator |
|0x1 | [OSC_DIVIDER](#OSC_DIVIDER) | 8 |  | Internal clock divider value for internal ring oscillator clock |
|0x2 | [ADC_CTRL](#ADC_CTRL) | 8 |  | Control the ADC |
|0x3 | [ADC_WAITTIME](#ADC_WAITTIME) | 32 |  | Waiting time for ADC |
|0x7 | [ADC_FIFO_STATUS](#ADC_FIFO_STATUS) | 8 |  |  |
|0x8 | [ADC_FIFO_DATA](#ADC_FIFO_DATA) | 8 | AXIS FIFO Slave (read) |  |
|0x9 | [TEST_DAC_CTRL](#TEST_DAC_CTRL) | 8 |  |  |
|0xa | [TEST_DAC_VALUE](#TEST_DAC_VALUE) | 8 |  |  |


## <a id='OSC_CTRL'></a>OSC_CTRL


> Controls the Oscillator


**Address**: 0x0




| [7:1] | 0 |
| --|-- |
| RSVD |EN |

- EN : Enable Oscillator


## <a id='OSC_DIVIDER'></a>OSC_DIVIDER


> Internal clock divider value for internal ring oscillator clock


**Address**: 0x1


**Reset Value**: 8'd3




## <a id='ADC_CTRL'></a>ADC_CTRL


> Control the ADC


**Address**: 0x2




| [7:3] | 2 | 1 | 0 |
| --|-- |-- |-- |
| RSVD |RESET |BUSY |START |

- START : Start a conversion
- BUSY : Start a conversion
- RESET : Reset the internal logic


## <a id='ADC_WAITTIME'></a>ADC_WAITTIME


> Waiting time for ADC


**Address**: 0x3


**Reset Value**: 32'd16




## <a id='ADC_FIFO_STATUS'></a>ADC_FIFO_STATUS


> 


**Address**: 0x7




| [7:1] | 0 |
| --|-- |
| RSVD |empty |

- empty : 0 if the ADC output fifo is not empty


## <a id='ADC_FIFO_DATA'></a>ADC_FIFO_DATA


> 


**Address**: 0x8






## <a id='TEST_DAC_CTRL'></a>TEST_DAC_CTRL


> 


**Address**: 0x9




| [7:1] | 0 |
| --|-- |
| RSVD |EN |

- EN : Enable Test DAC


## <a id='TEST_DAC_VALUE'></a>TEST_DAC_VALUE


> 


**Address**: 0xa




