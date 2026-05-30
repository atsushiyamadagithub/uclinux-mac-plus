.global _start
.global _boot_stack
.global boot_entry        
.global command_line_from_bootloader

    .text

_start:
    /* interrupts should already be disabled, bss should be cleared, and the stack should already set at the end of RAM by the bootloader */

    movew  #0x2700, %sr
    movel 4(%sp), command_line_from_bootloader
    moveal #0x003f1ffc, %sp
    jsr start_kernel

_exit:
    bra _exit


    .data

command_line_from_bootloader:
    .long    0
