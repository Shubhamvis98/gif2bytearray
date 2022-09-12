from machine import Pin, I2C
import ssd1306
import time
import framebuf
from ghost import img

# INIT
WIDTH = 128
HEIGHT = 64
IWIDTH = 128
IHEIGHT = 64

i2c = I2C(0, sda=Pin(0), scl=Pin(1), freq=400000)
oled = ssd1306.SSD1306_I2C(WIDTH, HEIGHT, i2c)
oled.contrast(0)


oled.invert(1)
for i in range(1):
    for i in range(len(img)):
        fb = framebuf.FrameBuffer(bytearray(img[i]), IWIDTH, IHEIGHT, framebuf.MONO_HLSB)
        oled.blit(fb, 0, 0)
        oled.show()
        time.sleep(0.05)


