ASM = nasm
SRC_DIR = src
BUILD_DIR = build

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/boot.bin
	@cp $(BUILD_DIR)/boot.bin $(BUILD_DIR)/main_floppy.img
	@truncate -s 1440k $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/boot.bin: $(SRC_DIR)/bootloader.asm
	@$(ASM) $(SRC_DIR)/bootloader.asm -f bin -o $(BUILD_DIR)/boot.bin
