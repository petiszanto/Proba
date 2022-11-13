################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include emlib/subdir.mk
-include drivers/subdir.mk
-include CMSIS/EFM32GG/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: HF1.axf

# Tool invocations
HF1.axf: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU ARM C Linker'
	arm-none-eabi-gcc -g3 -gdwarf-2 -mcpu=cortex-m3 -mthumb -T "HF1.ld" -Xlinker --gc-sections -Xlinker -Map="HF1.map" --specs=nano.specs -o HF1.axf "./CMSIS/EFM32GG/startup_efm32gg.o" "./CMSIS/EFM32GG/system_efm32gg.o" "./drivers/caplesense.o" "./drivers/segmentlcd.o" "./drivers/vddcheck.o" "./emlib/em_system.o" "./src/em_acmp.o" "./src/em_assert.o" "./src/em_cmu.o" "./src/em_core.o" "./src/em_ebi.o" "./src/em_emu.o" "./src/em_gpio.o" "./src/em_lcd.o" "./src/em_lesense.o" "./src/em_rtc.o" "./src/em_usart.o" "./src/em_vcmp.o" "./src/main.o" "./src/segmentlcd_individual.o" -Wl,--start-group -lgcc -lc -lnosys -Wl,--end-group
	@echo 'Finished building target: $@'
	@echo ' '

	@echo 'Building hex file: HF1.hex'
	arm-none-eabi-objcopy -O ihex "HF1.axf" "HF1.hex"
	@echo ' '

	@echo 'Building bin file: HF1.bin'
	arm-none-eabi-objcopy -O binary "HF1.axf" "HF1.bin"
	@echo ' '

	@echo 'Building s37 file: HF1.s37'
	arm-none-eabi-objcopy -O srec "HF1.axf" "HF1.s37"
	@echo ' '

	@echo 'Running size tool'
	arm-none-eabi-size "HF1.axf" -A
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) HF1.axf
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
