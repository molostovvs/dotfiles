import pyautogui
import os
from PIL import Image, ImageFilter

im0 = pyautogui.screenshot()
im1 = im0.filter(ImageFilter.GaussianBlur(30))
im1.save('/tmp/scls.png')
os.popen('i3lock -i /tmp/scls.png -u')